---
title: Let it work
author: Stéphane Épardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [compiler]
---

Hi, my name is Stéphane Épardaud and I´ll be your technical writer today :)

I want to talk a bit about some of the challenges we faced in the Ceylon compiler, and the solutions
we found. As is described in the [compiler architecture page](/code/contribute/#ceylon_compiler_components)
the backend of the Ceylon compiler extends OpenJDK´s Javac compiler by translating Ceylon source code into
Javac AST, which is then compiled into bytecode by Javac. Some of the reasons why we went this route of
extending Javac rather than create our own compiler from scratch are that:

- We are guaranteed to generate valid bytecode, because it has to be valid Java code, since it´s checked
by Javac.
- We can compile Java and Ceylon code at the same time, without needing to write a Java parser
and compiler. (Well this is not technically true in [M1](/documentation/1.0/roadmap/#milestone_1), 
but it will definitely be possible). 

But there are things we can´t do properly in Java, and here I´m going to give you an example where we
scratched our heads in trying to find a proper mapping.

# Attributes instead of fields

In Ceylon, we don´t have Java fields, we have _attributes_, which are similar to JavaBean´s properties.
This means that Ceylon attributes are translated to JavaBean getters and setters. And for interoperability
we map JavaBean properties to Ceylon attributes. Now the biggest challenge with using JavaBean getter and setter
methods in place of fields is that we want attributes to support the same operations you can do on Java fields,
such as the `++` operation. How do we map this:

    class Counter() {
        Natural n = 0;
    }
    Counter c = Counter();
    Natural n = c.n++;

Into working Java code which looks like this (optimised for `long` because otherwise `++` 
[is polymorphic](/documentation/1.0/reference/operator/increment/)):

<!-- lang: java -->
    class Counter{
        long n;
        long getN(){
            return n;
        }
        void setN(long n){
            this.n = n;
        }
    }
    Counter c = new Counter();
    long n = c.getN()++;

Wait a minute: this is not valid!

So the problem is that there are a lot of operations you can do on 
[l-values](http://en.wikipedia.org/wiki/Value_(computer_science\)),
that is, variables which can be assigned. To summarize the difference between _l-values_ and _r-values_, the following mnemonics
helps: an _l-value_ is something which can be assigned and read, it can appear as the _left_ side of an assignment, while an
_r-value_ is an expression that can only be read and not assigned. In our example, `c.n` is an _l-value_ while `2 + 2` would be
an _r-value_.

So we expect to be able to do every assignment operation on _l-values_, such as `:=`, `+=` and `++`. The problem we face is that
in Java, `c.n` is an _l-value_ but when using getters, `c.getN()` is not: it´s an `r-value`, you can´t assign to it, you can´t
do `++` on it. For that you need to use the setter. Now the thing is that setters in JavaBean return `void`, so they´re not
expressions, or even an `l-value`: they´re statements. And we can´t put statements inside expressions. For instance we can´t do:

<!-- lang: java -->
    Counter c = new Counter();
    long n = c.setN(c.getN()+1);

We cannot do that because `setN()` is a statement: it returns void. Plus that would actually be an incorrect way to define `++`,
since we need to return the old value of `n` prior to the increment, so we´d need a temporary variable. The only way to have
statements inside expressions in Java is to create an anonymous class:

<!-- lang: java -->
    Counter c = new Counter();
    long n = new Object(){
        long postIncrement(Counter c){
            long previousValue = c.getN();
            c.setN(previousValue+1);
            return previousValue;
        }
    }.postIncrement(c);

And the solution to all other other assignment operations are similar: anonymous classes for things as trivial as `++`, surely
this is crazy? If only there were some other way, short of generating bytecode ourselves (in which case we can do whatever we
want without needing do make it translatable into Java). 

# Let it be…

So one day we´re looking inside OpenJDK´s Javac to try to find something, and we stumble upon mention of a `comma` operator. For
those who don´t know [`C`](http://en.wikipedia.org/wiki/C_(programming_language)), 
the [comma operator](http://en.wikipedia.org/wiki/Comma_operator) (`,`) allows you to execute several
expressions and return the right-most expression value.  

We look at this and we think: “this can´t be right, Java doesn´t have the comma operator, we´d know”. So why is it there? Looking
a bit more we discover that it´s there to support `++` on _boxed_ `Integer` values. Because this isn´t a primitive operation,
you need the same sort of workaround we have:

<!-- lang: java -->
    Integer i = new Integer(0);
    Integer j = new Object(){
        Integer postIncrement(Integer previousValue){
            // assuming you could assign a captured variable:
            i = new Integer(previousValue.intValue() + 1);
            return previousValue;
        }
    }.postIncrement(i);

So they use this operator in order to save a temporary value in an expression context, where you normally can´t. And upon
further examination it turns out that they (the OpenJDK Javac authors) implemented the comma operator using an even more
generic exppression: a `Let` expression!

I´m very familiar with _let_ expressions, such as they are in 
[Scheme](http://en.wikipedia.org/wiki/Scheme_(programming_language\)#Block_structure) or in 
[ML](http://en.wikipedia.org/wiki/ML_(programming_language\)), but I´m sure many of you are not, so in short:

A _let_ expression allows you to declare and bind new variables in a local scope, run statements and return an expression from
this scope, all in the context of an expression. 

So let´s rewrite our previous example in pseudo-Java with `let`:

<!-- lang: java -->
    Integer i = new Integer(0);
    Integer j = (let
                  // store the previous value in a temporary variable
                  Integer previousValue = i;
                 in 
                  // assign the new value
                  i = new Integer(previousValue.intValue() + 1);
                  // return the previous value
                  return previousValue;);
 
Now, obviously this is not valid Java, because `let` expressions are not part of the Java language, but the OpenJDK Javac
compiler uses this construct behind the scenes to rewrite parts of the Java AST into pseudo-code that can be translated
into efficient bytecode in the end. All they needed was an AST node to represent this, and support from the bytecode
generator to support this AST type.

And guess what: since we feed Java AST to Javac we can use this construct :)

In fact this is precisely how we solved most of our issues, such as the `++` operator: 

<!-- lang: java -->
    Counter c = new Counter();
    long n = (let
               long previousValue = c.getN();
              in
               c.setN(previousValue+1);
               return previousValue;);

This solution allows us to define every assignment operator such as `:=`, `++` or `+=` on attributes, that are mapped
into JavaBean getter/setter methods using efficient code.

All we needed to do was to add some bits of support for `let` expressions inside Javac because they never needed to get
them so early in the AST so it was missing some support in one or two phases of the compiler, but peanuts really.

# Conclusion

When we set out to extend the Javac compiler we didn´t really know what to expect, but over time we´ve found it has a really
solid API and is very well done and documented. We were able to extend it in ways it was never imagined to be extended, and
it followed along nicely. Not only that but we found out that the OpenJDK developers, when faced with the issue of `++` on boxed
`Integers` didn´t just hack along some quick and dirty way to fix it: they went ahead and implemented a much more powerful and
generic way to solve every similar issue with the `let` expression. Congratulation guys, you did good and it was worth it, 
because thanks to you we can implement really crazy stuff.

We´re now using this `let` expression for implementing many operators and features, such as:

- [named parameter invocation](/documentation/1.0/reference/operator/invoke/), 
to keep source-file evaluation order before reordering the parameters for the callee,
- the [`?.`](/documentation/1.0/reference/operator/nullsafe-invoke/), `?` 
and [`?[]`](/documentation/1.0/reference/operator/nullsafe-lookup) null-safe operators, to store the 
temporary variable before we test it for null.

So thanks, OpenJDK authors, thanks to you we´ll have efficient compilation of Ceylon code :)
