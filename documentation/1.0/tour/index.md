---
layout: tour
title: Welcome to the Tour
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc _root: ..
---

# #{page.title}

This tour of the Ceylon language is primarily intended for 
developers with some experience in object-oriented 
programming. It assumes basic familiarity with concepts like 
static typing, inheritance, subtyping, and type 
parameterization (generics). If you already know a language 
like Java, C#, or C++, you already have all the background 
you need.

### What if I don't know Java?

_If you're new to object-oriented programming,_ you'll still
be able to learn Ceylon. These concepts aren't difficult to
pick up! But you might find some chapters of the tour pretty
hard going first time through. If so, take it slowly: 
experiment with the language using [Ceylon IDE](../ide), and 
gradually get a feel for how these things work and how they 
are useful. None of us learned to program from books or 
tutorials or from other people telling us how to do it. We 
learned by playing and experimenting and working with other
people's code.

_If you're completely new to static typing,_ you'll probably
find Ceylon very fussy and even a bit complicated at first. 
There's a lot more rules to know about than in a language like 
Python, Ruby, or Smalltalk. But we promise that the benefits 
make it worthwhile in the end, especially once you learn to 
use the IDE effectively. Tools for a dynamic language simply 
can't reason about your code like Ceylon IDE can! 

### Help us improve!

If you find some part of this tour difficult to read or difficult 
to understand, or if you think one of the examples sucks, or if 
you think a section is missing some useful information, please
[let us know](/community).

## Before you start

If you're using the [command line distribution](/download) to
try out Ceylon for the first time, we highly recommend you 
start by compiling and running the samples included in the
distribution.

Instructions for getting started are contained in the file
`README.md` in the root directory of the distribution, or
[right here in GitHub][ceylon-dist readme].

[ceylon-dist readme]: https://github.com/eclipse/ceylon/blob/master/dist/README.md

Now, let's just make sure we can compile and run our own program 
from the command line and IDE.

## A _really_ simple program

Here's a classic example program.

<!-- id: hello -->
<!-- try-post:
    hello();
-->
    void hello() {
        print("Hello, World!");
    }

This function prints `Hello, World!` on the console. We call this a _toplevel_ 
function because it's not a member of any specific type. So you don't need a 
receiving object to invoke a toplevel function. Instead, you can just call it 
like this:

<!-- try:
    void hello() {
        print("Hello, World!");
    }
    hello();
-->
<!-- cat-id: hello -->
<!-- cat: void m() { -->
    hello();
<!-- cat: } -->

Or you can run it directly from the command line.

Ceylon doesn't have `static` methods like Java, C++, or C#, but you can think 
of toplevel functions as filling the same role. The reason for this difference
is that Ceylon has a very strict block structure - a nested block always has 
access to declarations in all containing blocks. This isn't the case with 
Java's `static` methods.

Ceylon doesn't (yet) support _scripting_. You can't write statements like 
`print("Hello, World!");` outside of a function or class. This is _not_, on
its own, a legal program:

<!-- try: -->
    print("Hello, World!");  //error: must occur inside a function or class


## Running the program from the command line

Let's try it out. Save the above code in the file `./source/hello.ceylon` 
and then run the following commands:

<!-- lang: bash -->
    ceylon-1.0.0/bin/ceylon compile source/hello.ceylon
    ceylon-1.0.0/bin/ceylon run --run hello default

where `ceylon-1.0.0` is the path to your Ceylon install directory. You should
see the message `Hello, World!`. You will find the compiled module archive 
`default.car` in the directory `./modules/default`.

A very useful trick is:

<!-- lang: bash -->
    ceylon-1.0.0/bin/ceylon help compile

And:

<!-- lang: bash -->
    ceylon-1.0.0/bin/ceylon help run

The command
[ceylon help](#{site.urls.ceylon_tool_current}/ceylon-help.html) 
outputs usage information about any of the 
[`ceylon` subcommands](#{site.urls.ceylon_tool_current}/index.html).

*If you're still having trouble getting started with the command line tools, 
try [compiling and running the samples](#before_you_start) if you haven't 
already.*

### Selecting the JDK

Ceylon requires Java 7, so you might need to verify that this is the version
of Java you're using.

<!-- lang: bash -->
    bash$ java -version
    java version "1.7.0_05"
    Java(TM) SE Runtime Environment (build 1.7.0_05-b06)
    Java HotSpot(TM) 64-Bit Server VM (build 23.1-b03, mixed mode)
    bash$ javac -version
    javac 1.7.0_05

If you're using some other version of Java, you'll need to change to use 
Java 7:

- on Linux, use `update-java-alternatives`,
- on Mac, use the `System Preferences` 
  [applet](http://www.java.com/en/download/help/mac_controlpanel.xml), or
- on Windows, set the `JAVA_HOME` environment variable.

### Setting the character encoding

If you see the following error, or similar, when compiling a Ceylon program:

<!-- lang: none -->
    unmappable character for encoding ASCII

Then you have a source file whose character encoding doesn't match the default
character encoding for your OS. You'll need to explicitly specify the character
encoding on the command line like this:

<!-- lang: bash -->
    ceylon compile --encoding UTF-8 source/hello.ceylon

## Running the program from the IDE

To run the program in [Ceylon IDE](../ide), go to the Ceylon 
perspective, then:

1. create a new project using `File > New > Ceylon Project`, 
2. create a new `.ceylon` file inside the project using 
   `File > New > Ceylon Source File`,
3. paste the definition of `hello()` in this new file, and then 
4. select the file and run it using `Run > Run As > Ceylon Application`.

This executes the program on the JVM.

If you have `node.js` installed, you can go to `Project > Properties`, select 
the `Ceylon` section, enable `Compile project to JavaScript`, then click `OK`, 
and run the program using `Run > Run As > Ceylon JavaScript Application`.

Or, if you're unfamiliar with Eclipse, go to `Help > Cheat Sheets`, open the 
`Ceylon` item, and run the `Hello World with Ceylon` cheat sheet which takes 
you step by step through the process.

### Selecting the JDK

Ceylon IDE requires Java 7, so you might need to verify that Eclipse is running 
on a Java 7 VM. Go to `Eclipse > About Eclipse`, click `Installation Details`,
and go to the `Configuration` tab. You'll see the Java version listed among the 
other system properties. See the [instructions above](#selecting_the_jdk) to
change the version of Java. You might need to edit `eclipse.ini`.

You need to make sure that your project is configured to compile using the Java 
7 compiler. Go to `Project > Properties`, select the `Java Compiler` section,
and make sure that the project is configured to use the Java 7 compiler.

### Setting the character encoding

To set the source file character encoding in Eclipse, go to 
`Project > Properties`, select the `Resource` section, and select a
`Text file encoding`, for example, `UTF-8`.

## Continue the tour

We'll begin with the [Basics](basics). 
