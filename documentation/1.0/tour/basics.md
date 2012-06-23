---
layout: tour
title: Tour of Ceylon&#58; Basics
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# #{page.title}

Let's get started!

Before we can get into any of the really interesting and powerful features of 
this language, we need to get comfortable with some of the basic syntax, so
we'll know what we're looking at later on. 

## A _really_ simple program

Here's a classic example program.

<!-- id: hello -->
    void hello() {
        print("Hello, World!");
    }

This method prints `Hello, World!` on the console. A toplevel method like this 
is just like a C function - it belongs directly to the package that contains 
it, it's not a member of any specific type. You don't need a receiving object 
to invoke a toplevel method. Instead, you can just call it like this:

<!-- cat-id: hello -->
<!-- cat: void m() { -->
    hello();
<!-- cat: } -->

Or you can run it directly from the command line. 

Ceylon doesn't have Java-style `static` methods, but you can think of 
toplevel methods as filling the same role. The reason for this difference
is that Ceylon has a very strict block structure - a nested block always has 
access to declarations in all containing blocks. This isn't the case with 
Java's `static` methods.

## Running the program from the command line

Let's try it out. Save the above code in the file `./source/hello.ceylon` 
and then run the following commands:

<!-- lang: bash -->
    ceylon-0.3/bin/ceylonc source/hello.ceylon
    ceylon-0.3/bin/ceylon -run hello default

where `ceylon-0.3` is the path to your Ceylon install directory. You should
see the message `Hello, World!`. You will find the compiled module archive 
`default.car` in the directory `./modules/default`.

*If you're having trouble getting started with the command line tools, the
[command line distribution](/download) of Ceylon contains a file named
`README.md` in the root directory that contains instructions on compiling
and running the simple examples in the `samples/` directory.*

A very useful trick is:

<!-- lang: bash -->
    ceylon-0.3/bin/ceylonc -help
    ceylon-0.3/bin/ceylon -help

## Running the program from the IDE

To run the program in [Ceylon IDE](#{page.doc_root}/ide), go to the Ceylon 
perspective, create a new project using `File > New > Ceylon Project`, then 
create a new `.ceylon` file using `File > New > Ceylon Unit`. Put the code 
of `hello()` in this new file, then select the file and run it using 
`Run > Run As > Ceylon Application`.

Or, if you're unfamiliar with Eclipse, go to `Help > Cheat Sheets`, open
the `Ceylon` item, and run the `Hello World with Ceylon` cheat sheet which 
takes you step by step through the process.

## String literals

String literals in Ceylon may span multiple lines. Try this:

<!-- id: hello -->
    void hello() {
        print("Hello, 
               World!");
    }

The output is:

<!-- lang: none -->
    Hello, 
    World!

Note that because the second line of the string literal contained whitespace 
right up until the first character of the first line of the string literal,
all that whitespace was automatically removed. This helps us format our
code nicely.

It's often useful to collapse whitespace in a multiline string literal. The
[`String`](#{site.urls.apidoc_current}/ceylon/language/class_String.html)
class has an attribute called [`normalized`](#{site.urls.apidoc_current}/ceylon/language/class_String.html#normalized). 
We can use it like this:

<!-- id: hello -->
    void hello() {
        value message = "Hello, 
                         World!";
        print(message.normalized);
    }

Which results in the output:

<!-- lang: none -->
    Hello, World!

Multiline strings are especially useful for adding documentation to a 
program.

## Adding inline documentation

It's usually a good idea to add some kind of documentation to important 
methods like `hello()`. One way we could do this is by using a C-style 
comment, either like this:

<!-- id: hello -->
    /* The classic Hello World program */
    void hello() {
        print("Hello, World!");
    }

Or like this:

<!-- id: hello -->
    //The classic Hello World program
    void hello() {
        print("Hello, World!");
    }

But it's much better to use the `doc` annotation for comments that describe 
declarations.

<!-- check:none: Requires IO -->
<!-- id: hello -->
	doc "The classic Hello World program"
	by "Gavin"
	see (goodbye)
	throws (IOException)
	void hello() {
	    print("Hello, World!");
	}
<!-- cat: 
    void goodbye() {
        // ...
    } -->

The `doc`, `by`, `see`, `throws`, and `tagged` annotations contain documentation 
that is included in the output of the Ceylon documentation compiler, `ceylond`.

Notice that when an annotation argument is a literal, it doesn't need to be 
enclosed in parentheses. We can write simply: 

<!-- check:none -->
    by "Gavin"

instead of:

<!-- check:none -->
    by ("Gavin")

Annotations like `doc`, `by`, `see`, and `throws`, aren't keywords. They're 
just ordinary identifiers. The same is true for annotations which are part of 
the language definition, for example: `abstract`, `variable`, `shared`, `formal`, 
`default`, `actual`, etc. This is quite different to other C-like languages. (On 
the other hand, `void` _is_ a keyword, just like in C or Java.)

## Formatting inline documentation

The `doc` annotation may contain [Markdown](http://daringfireball.net/projects/markdown/syntax)
formatting.

<!-- id: hello -->
    doc "The classic [Hello World program][helloworld]
         that prints a message to the console, this 
         time written in [Ceylon][]. 
         
         This simple program demonstrates:
         
         1. how to define a toplevel method, and
         2. how to `print()` a literal `String`.
         
         You can compile and run `hello()` from the 
         command line like this:
         
             ceylonc source/hello.ceylon
             ceylon -run hello default
         
         Or you can use `Run As > Ceylon Application` 
         in the IDE.
         
         [helloworld]: http://en.wikipedia.org/wiki/Hello_world_program
         [Ceylon]: http://ceylon-lang.org"
         
    void hello() {
        print("Hello, World!");
    }

Since Markdown is sensitive to the initial column in which text appears, 
you need to be careful to indent the lines of the multiline string literal 
correctly, as we've done here.  

## String interpolation and concatenation

Let's make our program tell us a little more about itself.

<!--
    doc "The Hello World program
         ... version 1.1!"
    void hello() {
        print("Hello, this is Ceylon " 
              process.languageVersion
              " running on Java " 
              process.javaVersion 
              "!");
    }
-->

<!-- id: hello2 -->
    void hello2() {
        print("Hello, you ran me at " 
               process.milliseconds
              " ms, with " 
               process.arguments.size
              " command line arguments.");
    }

Notice how our message contains interpolated expressions. This is called
a _string template_. A string template must begin and end in a string 
literal. The following is not legal syntax:

<!-- check:none: Demoing error -->
    print("Hello, you ran me at " 
           process.milliseconds); //compile error!

But we can easily fix it:

<!-- cat: void m() { -->
    print("Hello, you ran me at " 
           process.milliseconds 
          "");
<!-- cat: } -->

(If you're wondering why the syntax isn't something like 
`"Hello, you ran me at ${process.milliseconds}"`,
[here's why](#{page.doc_root}/faq/language-design/#string_interpolation_syntax).)

The `+` operator you're probably used to is an alternative way to concatenate
strings, and more flexible in many cases:

<!-- cat: void m() { -->
    print("Hello, you ran me at " + 
           process.milliseconds.string +
          " ms, with " +
           process.arguments.size.string +
          " command line arguments.");
<!-- cat: } -->

Note that when we use `+` to concatenate strings, we have to explicitly 
invoke the 
[`string`](#{site.urls.apidoc_current}/ceylon/language/class_Object.html#string) 
attribute to convert numeric expressions to strings. The 
`+` operator does not automatically convert its operands to strings, so the 
following does not compile:  

<!-- check:none:Demoing error -->
    print("Hello, you ran me at " + 
           process.milliseconds +
          " ms, with " +
           process.arguments.size +
          " command line arguments.");    //compile error!

## Dealing with objects that aren't there

Let's take a name as input from the command line. We have to account for the 
case where nothing was specified at the command line, which gives us an 
opportunity to explore how `null` values are treated in Ceylon, which is 
quite different to what you're probably used to in Java or C#.

Let's consider an overly-verbose example to start with (we'll get on to the
more convenient form in a moment):

    doc "Print a personalized greeting"
    void hello() {
        String? name = process.arguments.first;
        String greeting;
        if (exists name) {
            greeting = "Hello, " name "!";
        }
        else {
            greeting = "Hello, World!";
        }
        print(greeting);
    }

The type `String?` indicates that `name` may contain a `null` value. We then 
use the `if (exists ...)` control structure to branch the code that deals with 
a non-`null` vs a `null` name.

Unlike Java, locals, parameters, and attributes that may contain `null` values 
must be explicitly declared as being of optional type (the `T?` syntax). 
There's simply no way to assign `null` to a local that isn't of optional type. 
The compiler won't let you.

Nor will the Ceylon compiler let you do anything dangerous with a value of 
type `T?` - that is, anything that could cause a `NullPointerException` in 
Java - without first checking that the value is not `null` using 
`if (exists ... )`.

In fact, it's not even possible to use the equality operator `==` with an 
expression of optional type. You can't write `if (x==null)` like you can in 
Java. This helps avoid the undesirable behavior of `==` in Java where `x==y` 
evaluates to true if `x` and `y` both evaluate to `null`.

Note that the syntax `String?` is just an abbreviation for the 
[union type](../types/#union_types) `Nothing|String`. The value `null` isn't 
a primitive value in Ceylon, it's just a perfectly ordinary instance of the 
perfectly ordinary class `Nothing`. (However, the Ceylon compiler does
some special magic to transform this value to a JVM-level null.)

It's possible to declare the local name inside the `if (exists ... )` 
condition (and because Ceylon has local [type inference](../types#type_inference), 
you don't even have to declare the type):

<!-- cat: void hello() { -->
    String greeting;
    if (exists name = process.arguments.first) {
        greeting = "Hello, " name "!";
    }
    else {
        greeting = "Hello, World!";
    }
    print(greeting);
<!-- cat: } -->

This is the preferred style most of the time, since we can't actually use 
`name` for anything useful outside of the `if (exists ... )` construct.

# Operators for handling null values

There are a couple of operators that will make your life easier when dealing 
with `null` values.

<!-- cat: void hello(String? name) { -->
    String greeting = "Hello, " + (name else "World");
<!-- cat: 
    print(greeting);
} -->

The `else` operator returns its first argument if the first argument is not 
`null`, or its second argument otherwise. It's a more convenient way to 
handle `null` values in simple cases.

There's also an operator for _producing_ a null value:

    String? name = !arg.trimmed.empty then arg;

The `then` operator evaluates its second argument if its first argument 
evaluates to `true`, or evaluates to `null` otherwise.

You can chain an `else` after a `then` to reproduce the behavior of C's
ternary `?:` operator:

    String name = !arg.trimmed.empty then arg else "World";

The `?.` operator lets us call operations on optional types.

<!-- cat: void hello(String? name) { -->
    String shoutedGreeting = "HELLO, " + (name?.uppercased else "WORLD");
<!-- cat: 
    print(shoutedGreeting);
} -->

## Defaulted parameters

While we're on the topic of values that aren't there, it's worth mentioning 
that a method parameter may specify a default value.

<!-- id: hello -->
    void hello(String name="World") {
        print("Hello, " name "!");
    }

Then we don't need to specify an argument to the parameter when we call 
the method:

<!-- cat-id: hello -->
<!-- cat: void m() { -->
    hello(); //Hello, World!
    hello("JBoss"); //Hello, JBoss!
<!-- cat: } -->

Defaulted parameters must be declared after all required parameters in the 
parameter list of a method.

Ceylon also supports sequenced parameters (varargs), declared using an 
ellipsis (i.e. `String...`). But we'll [come back](../named-arguments/#sequenced_parameters) 
to them after we discuss [sequences](../sequences).

## Numbers

Ceylon doesn't have any primitive types, so numeric values are usually 
represented by the classes 
[`Integer`](#{site.urls.apidoc_current}/ceylon/language/class_Integer.html)
and [`Float`](#{site.urls.apidoc_current}/ceylon/language/class_Float.html),
which we'll come back to [later in the tour](../language-module/#numeric_types).

Even though they're classes, you can use all the usual numeric literals and
operators with them. For example, the following method efficiently determines 
if an `Integer` represents a prime number:

    doc "Determine if `n` is a prime number."
    throws (Exception, "if `n<2`")
    Boolean prime(Integer n) {
        if (n<2) {
            throw;
        }
        else if (n<=3) {
            return true;
        }
        else if (n%2==0 || n%3==0) {
            return false;
        }
        else if (n<25) {
            return true;
        }
        else {
            for (b in 1..((n.float**0.5+1)/6).integer) {
                if (n%(6*b-1)==0 || n%(6*b+1)==0) {
                    return false;
                }
            }
            else {
                return true;
            }
        }
    }

Try it, by running the following method:

    doc "Print a list of all two-digit prime numbers."
    void findPrimes() {
        print({ for (i in 2..99) if (prime(i)) i });
    }

Heh, this was just a little teaser to keep you interested. We'll 
explain the syntax we're using here a bit 
[later in the tour](../comprehensions).

## There's more...

Ceylon is an object-oriented language, so an awful lot of the code we write 
in Ceylon is contained in a _class_. Let's learn about [classes](../classes)
right now.

