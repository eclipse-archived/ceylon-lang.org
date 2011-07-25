---
layout: tour
title: Tour of Ceylon&#58; classes, interfaces and objects
tab: documentation
author: Emmanuel Bernard
---

# #{page.title}

This is the second step in our tour of the Ceylon language.

## Creating your own classes

Type (interfaces, classes, and type parameters) names are capitalized. Members (methods and attributes) and locals names are not. The Ceylon compiler is watching you. If you try to write class `hello` or String `Name`, you'll get a compilation error.

Our first version of the `Hello` class has a single attribute and a single method:

<pre class="brush: ceylon">
doc "A personalized greeting"
class Hello(String? name) {
     
    doc "The greeting"
    shared String greeting;
    if (exists name) {
        greeting = "Hello, " name "!";
    }
    else {
        greeting = "Hello, World!";
    }
     
    doc "Print the greeting"
    shared void say(OutputStream stream) {
        stream.writeLine(greeting);
    }
}
</pre>

`shared` describes the accessibility of the attribute or method.

## Hiding implementation details

Ceylon tries to simplify how to expose or hide members and make that safer than Java.

By default, members of a class are hidden from code outside the body of the class. By annotating a member with the `shared` annotation, we declare that the member is visible to any code to which the class itself is visible.

And, of course, a class itself may be hidden from other code. By default, a toplevel class is hidden from code outside the package in which the class is defined. Annotating a top level class with `shared` make it visible to any code to which the package containing the class is visible.

Finally, packages are hidden from code outside the module to which the package belongs by default. Only explicitly shared packages are visible to other modules.

Got the idea? We are playing russian dolls here.

## Abstracting state using attributes


The attribute greeting is a simple attribute, the closest thing Ceylon has to a Java field.

<pre class="brush: ceylon">
shared String greeting = "Hello, " name "!";
shared Natural months = years * 12;
</pre>

The Ceylon compiler forces you to specify a value of any simple attribute or local before making use of the simple attribute or local in an expression.

<pre class="brush: ceylon">
Natural count;
shared void inc() {
    count++;   //compile error
}
</pre>

Think of an attribute has field + getter + setter done right and defined in the language. Some attributes are simple value holders like the one we've just seen; others are more like a getter method, or, sometimes, like a getter and setter method pair.

We could rewrite the attribute greeting as a getter:

<pre class="brush: ceylon">
shared String greeting {
    if (exists name) {
        return "Hello, " name "!";
    }
    else {
        return "Hello, World!";
    }
}
</pre>

Notice that the syntax of a getter declaration looks a lot like a method declaration with no parameter list.

## Understanding object initialization

In Ceylon, classes don't have constructors. 

Instead:

* the parameters needed to instantiate the class are declared directly after the name of the class (like a method would), and
* the code to initialize the new instance of the class goes directly in the body of the class.

<pre class="brush: ceylon">
class Hello(String? name) {
    
    shared String greeting;
    if (exists name) {
        greeting = "Hello, " name "!";
    }
    else {
        greeting = "Hello, World!";
    }
     
    shared void say(OutputStream stream) {
        stream.writeLine(greeting);
    }
}
</pre>
  
The syntax of Ceylon is more regular than Java. Regularity makes a language easy to learn and easy to refactor.

Now let's turn our attention to a different possible implementation of greeting:

<pre class="brush: ceylon">
class Hello(String? name) {
    shared String greeting {
        if (exists name) {
            return "Hello, " name "!";
        }
        else {
            return "Hello, World!";
        }
    }
    ... 
}
</pre>

The class initializer parameter `name` is used inside the getter `greeting`. Parameters can be used in the scope of their block structure. Like method parameters in Java are visible in the method, class parameters in Ceylon are visible to the elements in the body of their class.

That's just a fancy way of obfuscating the idea that greeting holds onto the value of name, even after the initializer completes.

## Instantiating classes and overloading their initializer parameters

We have not done this work for nothing! Let's no see how to use the `Hello` class.

<pre class="brush: ceylon">
doc "Print a personalized greeting"
void hello() {
    Hello(process.args.first).say(process.output);
}
</pre>

Our rewritten `hello()` method just creates a new instance of `Hello`, and invokes `say()`. Ceylon doesn't need a `new` keyword to instantiate a class.

Bad news: Ceylon doesn't support method overloading (the truth is that overloading is the source of various problems in Java, especially when generics come into play). However we can emulate most non-evil uses of constructor or method overloading using:

* defaulted parameters, 
* sequenced parameters, i.e. varargs, and
* union types or enumerated type constraints

We're not going to get into all the details of these workarounds right now, but here's a quick example of each of the three techniques:

<pre class="brush: ceylon">
//defaulted parameter
void println(String value, String eol = "\n") {
    writeLine(value + eol);
}
</pre>

<pre class="brush: ceylon">
//sequenced parameter
void print(String... strings) {
    for (String string in strings) {
        writeLine(string);
    }
}
</pre>

<pre class="brush: ceylon">
//union type
void print(String|Named printable) {
    String string;
    switch (printable)
    case (is String) {
        string = printable;
    }
    case (is Named) {
        string = printable.name;
    }
    writeLine(string);
}
</pre>

Don't worry if you don't completely understand the third example just yet. 

Let's overload `Hello`, and its `say()` method, using defaulted parameters:

<pre class="brush: ceylon">
doc "A command line greeting"
class Hello(String? name = process.args.first) {
    ...
     
    doc "Print the greeting"
    shared void say(OutputStream stream = process.output) {
        stream.writeLine(greeting);
    }
     
}
</pre>

Our `hello()` method is now looking really simple as we use the default parameter values:

<pre class="brush: ceylon">
doc "Print a personalized greeting"
void hello() {
    Hello().say();
}
</pre>

There's more...

We'll now explore [inheritance and refinement (overriding)](../inheritance).

