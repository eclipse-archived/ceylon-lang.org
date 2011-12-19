---
layout: tour
title: Tour of Ceylon&#58; Basics
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# #{page.title}

Let's start!

## Writing a simple program

Here's a classic example program.

    void hello() {
        print("Hello, World!");
    }

This method prints `Hello, World!` on the console. A toplevel method like this 
is just like a C function - it belongs directly to the package that contains 
it, it's not a member of any specific type. You don't need a receiving object 
to invoke a toplevel method. Instead, you can just call it like this:

    hello();

Or you can run it directly from the command line:

<!-- lang: none -->

    ceylonc -src . -out . hello.ceylon
    ceylon -cp unversioned/default_module-unversioned.car hello

Ceylon doesn't have Java-style `static` methods, but you can think of 
toplevel methods as filling the same role. Ceylon has a very strict 
block structure - a nested block always has access to declarations in all 
containing blocks. This isn't the case with Java's `static` methods.

## Adding inline documentation

It's usually a good idea to add some kind of documentation to important 
methods like `hello()`. One way we could do this is by using a C-style 
comment, either like this:

    /* The classic Hello World program */
    void hello() {
        print("Hello, World!");
    }

Or like this:

    //The classic Hello World program
    void hello() {
        print("Hello, World!");
    }

But it's much better to use the `doc` annotation for comments that describe 
declarations.

	doc "The classic Hello World program"
	by "Gavin"
	see (goodbye)
	throws (IOException)
	void hello() {
	    print("Hello, World!");
	}

The `doc`, `by`, `see` and `throws` annotations contain documentation that is 
included in the output of the Ceylon documentation compiler, `ceylond`.

Notice that when an annotation argument is a literal, it doesn't need to be 
enclosed in parentheses. We can write simply: 

    by "Gavin"

instead of:

    by ("Gavin")

Annotations like `doc`, `by`, `see`, and `throws`, aren't keywords. They're 
just ordinary identifiers. The same is true for annotations which are part of 
the language definition, for example: `abstract`, `variable`, `shared`, `formal`, 
`default`, `actual`, etc. This is quite different to other C-like languages. On 
the other hand, `void` _is_ a keyword, just like in C or Java.

## Formatting inline documentation

The `doc` annotation may contain [Markdown](http://daringfireball.net/projects/markdown/syntax)
formatting.

    doc "The classic [Hello World program][helloworld]
         that prints a message to the console, this 
         time written in [Ceylon][]. 
         
         This simple program demonstrates:
         
         1. how to define a toplevel method, and
         2. how to `print()` a literal `String`.
         
         You can compile and run `hello()` from the 
         command line like this:
         
             ceylonc -src . -out . hello.ceylon
             ceylon -cp unversioned/default_module-unversioned.car hello
         
         Or you can use `Run As > Ceylon Application` 
         in the IDE.
         
         [helloworld]: http://en.wikipedia.org/wiki/Hello_world_program
         [Ceylon]: http://ceylon-lang.org"
         
    void hello() {
        print("Hello, World!");
    }

Since Markdown is sensitive to the initial column in which text appears, you 
need to be careful to indent the lines of the multiline string literal 
correctly, as we've done here.  

## Strings and string interpolation

Let's make our program to tell us a little more about itself.

    doc "The Hello World program
         ... version 1.1!"
    void hello() {
        print("Hello, this is Ceylon " 
              process.languageVersion
              " running on Java " 
              process.javaVersion 
              "!");
    }

As you can see from the `doc` annotation we can split a string across multiple lines. That's especially 
useful when we're writing documentation in a `doc` annotation. We can 
interpolate expressions inside a string: we call that a string template.

A string template must begin and end in a string literal. The following is 
not legal syntax:

    print("Hello, this is Ceylon " 
          process.languageVersion); //compile error!

But we can easily fix it:

    print("Hello, this is Ceylon " 
          process.languageVersion 
          "");

(If you're wondering why the syntax isn't something like `"Hello, this is Ceylon ${process.languageVersion}"`
[here's why](/documentation/faq/language-design/#string_interpolation_syntax).)

The `+` operator you're probably used to is an alternative way to concatenate
strings, and more flexible in many cases:

    print("Hello, this is Ceylon " + 
          process.languageVersion +
          " running on Java " + 
          process.javaVersion + 
          "!");

## Dealing with objects that aren't there

Let's take a name as input from the command line. We have to account for the 
case where nothing was specified at the command line, which gives us an 
opportunity to explore how `null` values are treated in Ceylon, which is 
quite different to what you're probably used to in Java or C#.

Let's consider an overly-verbose example to start with (we'll get on to the
preferred form in a moment):

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
use the `if (exists ...)` control structure to split the code that deals with 
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
[union type](../types/#more_about_union_types) `Nothing|String`. The value
`null` isn't a primitive value in Ceylon, it's just an instance of the 
perfectly ordinary class `Nothing`.

It's possible to declare the local name inside the `if (exists ... )` 
condition (and because Ceylon has [type inference](../types#type_inference), 
you don't even have to declare the type):

    String greeting;
    if (exists name = process.arguments.first) {
        greeting = "Hello, " name "!";
    }
    else {
        greeting = "Hello, World!";
    }
    print(greeting);

This is the preferred style most of the time, since we can't actually use 
`name` for anything useful outside of the `if (exists ... )` construct.

# Operators for handling null values

There are a couple of operators that will make your life easier when dealing 
with `null` values.

    shared String greeting = "Hello, " + 
                             name ? "World";

The `?` operator returns its first argument if the first argument is not 
`null`, or its second argument otherwise. It's a more convenient way to 
handle `null` values in simple cases.

The related `?.` operator lets us call operations on optional 
types and provide an alternative value if the type is `null`.

    shared String shoutedGreeting = "HELLO, " + 
                                    name?.uppercased ? "WORLD";

## Defaulted parameters

While we're on the topic of values that aren't there, it's worth mentioning 
that a method parameter may specify a default value.

    void hello(String name="World") {
        print("Hello, " name "!");
    }

Then we don't need to specify an argument to the parameter when we call 
the method:

    hello(); //Hello, World!
    hello("JBoss"); //Hello, JBoss!

Defaulted parameters must be declared after all required parameters in the 
parameter list of a method.

Ceylon also supports sequenced parameters (varargs), declared using an ellipsis 
(i.e. `String...`). But we'll [come back](../missing-pieces/#sequenced_parameters) 
to them after we discuss [sequences](../sequences) and [`for` loops](../missing-pieces#control_structures).

## There's more...

Let's now discuss [classes, interfaces, and objects](../classes).

