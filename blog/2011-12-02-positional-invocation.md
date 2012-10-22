---
title: Implementing Method Invocation in ceylonc
author: Tom Bentley
layout: blog
unique_id: blogpage
tab: blog
tags: [compiler]
---

My main involvement in the Ceylon project has been in the compiler and within
that one of the things I've been involved with is *method invocation*. So 
I thought I'd blog about some of the details of the compiler, to show that 
working on it isn't that hard.

Syntactically, Ceylon has two different ways of invoking a method (and the 
[metamodel](/documentation/1.0/tour/functions/) will add a third). 
*Positional invocation*
will be very familiar to a Java programmer. In Ceylon it's conceptually 
pretty much the same, including support for ['varargs'](/documentation/1.0/tour/named-arguments/#sequenced_parameters). 
In this post I'm going to go into some detail about how support 
for positional method invocation is implemented in the compiler. I might cover 
the other syntactic form, [*named argument invocation*](/documentation/1.0/tour/named-arguments/), 
at a later date.

Before we go much further I just need to define some terminology. A method is
declared with zero or more *parameters*, the last of which may be a 
*sequenced parameter* ('varargs'):

    void foo(Natural n, Integer i, String... strings) {
        // some logic
    }
    
At a (positional) call site the method is supplied with values
for each of the parameters in the declaration. These values are usually called 
the *arguments* of the method invocation.

## How we generate code

In the following sections I'm going to be presenting bits of Ceylon code and 
the 'equivalent Java' code but it's 
important to understand that the Ceylon compiler doesn't 
actually generate Java source code. It instead constructs an abstract syntax 
tree (AST) directly 
using the internal OpenJDK `javac` API. This AST is then subject to the same 
Java type checks as normal Java source code, before it get converted to 
bytecode. You can read more about the architecture of the Ceylon compiler 
[here](/code/architecture/).

The major benefit of piggy-backing on `javac` like this is that
we don't have to get into the details of generating correct bytecode, such as 
worrying about which instruction to jump to. We can 
stick to higher level concepts that we're more familiar with, while we focus 
on actually getting something working. In the long term, it would be nice 
if `ceylonc` could be [self-hosting](http://en.wikipedia.org/wiki/Bootstrapping_%28compilers%29).

## Erasure

Because of the similarity with Java, supporting positional invocation in Ceylon 
isn't difficult: It boils down to generating a plain Java method 
invocation. But the two certainly aren't equivalent.

Although notionally in Ceylon 'everything is an object', the compiler is 
allowed (and does) optimise the numerical types 
(`Natural`, 
[`Integer`](/documentation/1.0/api/ceylon/language/class_Integer.html), 
[`Float`](/documentation/1.0/api/ceylon/language/class_Float.html), 
[`Boolean`](/documentation/1.0/api/ceylon/language/class_Boolean.html)) to the
corresponding Java primitive type 
(`long`, `long`, `double` and `boolean` respectively). This means that when you 
write a Ceylon statement such as

    Natural n = 1;
    
it is transformed into a Java statement like this

<!-- lang: java -->
    final long n = 1;

We call this 'erasure' (yes, I know erasure has another meaning in
Java to do with the loss of generic type information, but it's the term 
we use).

Erasure in itself wouldn't
cause a problem for method invocation because the method parameters are 
subject to erasure just as the method arguments are. However, sometimes we 
need to 'box' the primitive, [just like Java does](http://docs.oracle.com/javase/1.5.0/docs/guide/language/autoboxing.html). 

A good example of this is 
passing a `Natural` argument to a parameter declared 
[`Natural?`](/documentation/1.0/tour/basics/#dealing_with_objects_that_arent_there). 
The Java method declaration must use a boxed type (`Natural` from the runtime) 
as opposted to the Java primitive (`long`) it would otherwise be erased to 
in order to cope with the possibility of being passed a `null`. 
This means it is the compiler's responsibility to box the 
erased `Natural` (a Java `long`) at the call site.

Ceylon uses its own boxing classes in the runtime version of the 
language module.
Each class implements the API of the relevant type. Because Ceylon doesn't use 
the same classes to box primitives as Java does we can't rely on 
`javac`'s auto boxing/unboxing support. Performing this boxing correctly and
exactly when and where it's needed is where method invocation starts to 
get a little more complex than simply being 'A Ceylon method invocation is the 
same as a Java method invocation'.

## Varargs 

Varargs isn't implemented in terms of Java's varargs support. 
The reason in this case is that a Ceylon 
sequence is not the same thing as a Java array. So when someone declares a 
Ceylon method like this

    void varargs(T... ts) {
    
    }

the equivalent Java looks something like this

<!-- lang: java -->
    void varargs(Iterable<T> ts) {
    
    }

Now consider the Ceylon call site

    varargs<String>("foo", "bar", "baz");

When compiling this invocation we have to create a concrete instance of the 
[`Iterable<T>`](/documentation/1.0/api/ceylon/language/interface_Iterable.html) (using the arguments provided) to pass 
to the method.
This is done using an `ArraySequence` (an implementation of a Ceylon 
[`Sequence`](/documentation/1.0/api/ceylon/language/interface_Sequence.html) 
in the runtime), so that the generated Java looks something like this

<!-- lang: java -->
    varargs(new ArraySequence("foo", "bar", "baz"));

Aside: The observant reader will realise that using varargs with erased types creates
another boxing problem...

## Conclusion

So, after all that explanation, hopefully the [source code](https://github.com/ceylon/ceylon-compiler/blob/c8ca6087e94a98654d7361c3f399a099c2cc7a97/src/com/redhat/ceylon/compiler/codegen/ExpressionTransformer.java#LC758) 
should make some kind of sense.

None of what I've discussed above should be *that* hard to understand for 
anyone who's done much Java programming. I will admit at this point that I 
deliberately chose something that would be familiar and where the 
transformation between Ceylon and Java are small. This has allowed me to focus 
on some of the annoying-but-necessary details that are important to 
understand if you're going to hack on the compiler. 

The take-home message is 
that you really don't have to know a great deal about compilers, or even the 
JVM to be able to contribute something genuinely useful.

## Note

Since this post was originally written:

* the `Natural` type has since been remove from `ceylon.language`.
* `ceylonc` has become `ceylon compile`.

