---
layout: reference13
title_md: How to use native annotations
tab: documentation
unique_id: docspage
author: Tako Schotanus
---

# #{page.title_md}

Native annotations are used to mark code that is specific to a certain backend.
This can either mean code written in the native language for that backend, for
example Java when running on the JVM or JavaScript when running on Node.js
or in a browser. But it can also be code that is written in Ceylon but that
uses certain features specific for that backend which make it unsuitable
for compilation on other backends.

## Syntax and terminology

The native annotation comes in two form: with and without an argument specifying
the backend or backends for which the annotated code is meant. A native annotation
without an argument, eg. `native`, is called a "header". A native annotation
*with* an argument, eg. `native("jvm"), is called an "implementation".

The following is an example of some headers without associated Ceylon implementations
which means the compilers will look for native implementations.

<!-- try: -->
    native shared String exampleAttribute;

    native shared Integer exampleMethod();

    native shared class Example() {
        native shared String time();
    }

And this is an example of the same headers now with two implementations each, one
for the JVM backend marked with `native("jvm")` and one for the JavaScript backend
marked with `native("js")`:


<!-- try: -->
    native shared String exampleAttribute;
    native("jvm") shared String exampleAttribute => "JVM";
    native("js") shared String exampleAttribute => "JS";

    native shared Integer exampleMethod();
    native("jvm") shared Integer exampleMethod() => 42;
    native("js") shared Integer exampleMethod() => 7 * 6;

    native shared class Example() {
        native shared String time();
    }

    native("jvm") shared class Example() {
        native("jvm") shared String time() {
            return Date().string;
        }
    }   

    native("js") shared class Example() {
        native("js") shared String time() {
            dynamic {
                return Date().toString();
            }
        }
    }   

Also, native headers can optionally have an implementation or it can be left out.
This default implementation will be used automatically for each backend for which
no implementation (either using `native("...")` or native code) can be found.
The code itself by necessity has to be cross-platform. Some examples:

<!-- try: -->
    native shared String attribute;
    native shared String attributeWith = "hello";

    native shared Integer method();
    native shared Integer methodWith() => 5;

For declarations like classes and objects similar rules apply but instead of being
able to leave out the class/object bodies you do so for their member attributes
and methods, like this:

<!-- try: -->
    native shared class Klass() {
        native shared String attribute;
        native shared String attributeWith = "hello";
        native shared Integer method();
        native shared Integer methodWith() => 5;
    }

    native("js") shared class Klass() {
        native("js") shared String attribute = "foo";
        native("js") shared Integer method() => 42;
        native("js") shared Integer methodWith() => 6;
    }

The example implementation above shows that we had to add code for the "attribute"
and the "method()" because the header didn't provide a default implementation, it
also shows that we didn't mention "attributeWith" which means the default version
from the header will be used and finally it also shows us overriding the default
implementation for "methodWith()" with a new implementation.

Any **method**, **attribute**, **class** and **object** declaration can be marked `native`,
be they toplevel or members or even nested. But right now **interface** declarations are
not yet supported, but they will be in the near future. Any other declarations cannot
be marked native (basically because it would make no sense).

## Using native declarations

First a couple of rules you have to adhere to when using `native`:

 * All `shared` `native` declarations must declare a header
 * A native header and its implementations must have the exact same declaration
 * A header and its implementations mus be declared in the same file
 * You cannot access native code that has no header from non-native code
 * Within a native implementation you can only acces native code from the same backend

Going into more detail for each of them:

### All `shared` `native` declarations must declare a header

This means you can't just have a single shared native declaration like this:

<!-- try: -->
    native("jvm") shared String time() {
        return Date().string;
    }

This is actually a rule that we'll be trying to relax in the future, but for
the moment having a shared native declaration means you need to add a header
and need to provide implementations for the other backends.

### A native header and its implementations must have the exact same declaration

This rules means that all parameter types, parameter names, return types, type argument types
and type argument names and bounds must all be exactly the same. Basic language annotations
like `shared`, `actual`, `formal` etc must also be duplicated (a notable exception is the
`doc` annotation). So the following would not be correct:

<!-- try: -->
    native Integer parse(String number);

    native("jvm") Float parse(Integer number) {
        // Method has wrong return type
        // and wrong paramter type
    }

    native("js") shared Integer parse(String num, Boolean strict) {
        // Method is marked "shared"
        // Has wrong parameter name
        // And wrong number of parameters
    }

### A header and its implementations must be declared in the same file

This is a restriction we hope to lift at some point in the future but for now it's required
that a header and all its associated implementations be declarared in the same file.
If you have a declaration that is becoming too big for your taste to fit all possible
implementations in a single file you might think about refactoring the code a bit to
delegate the actual work to some private declarations. For example in one file you put:

<!-- try: -->
    native shared void reallyBigMethod();

    native("jvm") shared void reallyBigMethod() {
        reallyBigMethodForJvm();
    }

    native("js") shared void reallyBigMethod() {
        reallyBigMethodForJs();
    }

And in two other files you could define:

<!-- try: -->
    native("jvm") void reallyBigMethodForJvm() {
        ...
    }

And:

<!-- try: -->
    native("js") void reallyBigMethodForJs() {
        ...
    }

### You cannot access native code that has no header from non-native code

Non-native code is cross-platform and should be able to run anywhere, accessing code
specifically meant for a single backend (it has no header and therefore no other
implementations) is therfore prohibited:

<!-- try: -->
    native("js") String time() {
        return Date().string;
    }

    shared void run() {
        print(time()); // Error
    }

### Within a native implementation you can only acces native code from the same backend

Code meant for different backends cannot be mixed, which means that if you have an
implementation for the JVM backend it can only reference declarations that are
non-native (you can think of non-native code as having an implementation for
all possible backends) or other native JVM declarations. So the first two references
in the `run()` method below are okay while the 3rd one displays an error:

<!-- try: -->
    void nonNative() {
    }

    native("js") void jsOnly() {
    }

    native("jvm") void forJvm() {
    }

    shared("js") shared void run() {
        nonNative(); // Ok
        jsOnly(); // Ok too
        forJvm(); // Error
    }

This same rule also applies when dealing with native modules and imports as explained
in the next section.


## Native `module` and `import`

Up to now we have only seen `native` annotations on declarations, but there are two
other places where we can use the annotation:

A **module** can also be marked `native` when *all* declarations in it are to be
considered native for the given backend. A `module` can not be a native header so it
always needs an argument:

<!-- try: -->
    native("jvm")
    module my.jvmmodule "1.0" {
        import java.base "7";
    }

In this example the entire module is meant for the `jvm` backend so there's no need
to mark things `native` anywhere else in the code, everything is already considered
to be exclusively for that single backend.

But you might want to write a cross-platform module and *still* be able to use
platform-specific imports. So that's why it's possible to mark imports as well:

An **import** inside a module descriptor can be marked `native` to indicate that it's
only meant for code marked native for the same backend. An `import` can not be a native
header so it always needs an argument:

<!-- try: -->
    module my.networking "1.0" {
        native("jvm") import java.nio "7";
        native("js") import network "0.1.3";
        import ceylon.collection "1.2.0";
    }

In the above example the `my.networking` module is cross-platform because it isn't
marked `native` but it does provide the `java.nio` import for any code in the module
that is marked native for the `jvm` and the `network` import for any native code
marked `js`. And the unmarked cross-platform `ceylon.collection` is available to
both of them.

NB: you can not put a `native` annotation on the `import` statements in source files,
the compiler will figure out for itself which are meant for which backend.

## Native headers and members

The situation with declarations that can contain members, like classes for example,
can become somewhat complicated so let's look at some examples:

<!-- try: -->
    native shared class Example() {
        // Plain non-native members
        shared String notNativeAttribute = "foobar";
        shared Integer notNativeAnswer() {
            return 42;
        }

        // Native members without implmentation
        native shared String nativeAttribute;
        native shared Integer nativeMethod();

        // Native members with default implmentation
        native shared String nativeAttributeWith = "foobar";
        native shared Integer nativeMethodWith() => 42;
    }

First are those members that are not marked native. They will not be treated in any special
way, they will just become members of the final declaration. But they can not contain any
native code nor can they be defined in any of the native implementations.

Then come the native members *without* implementation. They *must* be defined in the native
implementation of their container and are required to have an implementation.

And finally we have the native members *with* a default implementation. They *can* be redefined
in the native implementation of their container, but this is not required.

An example of a native implementation of the above class could be:

<!-- try: -->
    native("jvm") shared class Example() {
        // Implementation required
        native("jvm") shared String nativeAttribute => "eg";
        native("jvm") shared Integer nativeMethod() => 6 * 7;

        // Allowed to be redefined
        native("jvm") shared Integer nativeMethodWith() => 13; 
    }   

## Tips & tricks

One very useful trick you can use when dealing with a project with mutiple native modules,
some of which are written for the JVM backend and some of which are for the JS backend, is
that you can let the compilers figure out for themselves which modules they should compile
and which they should skip. When you use:

<!-- try: -->
    $ ceylon compile '*'
    $ ceylon compile-js '*'

the compilers will *only* compile those modules that are either not marked native or
that are marked native for that particular backend. That way you don't have to explicitly
specify each of the modules to compile on the command line.

## See also

* [`native`](../annotation/native) annotation reference
* [`native`](#{site.urls.apidoc_1_3}/index.html#native) annotation documentation
* Reference for [annotations in general](../../structure/annotation/)

