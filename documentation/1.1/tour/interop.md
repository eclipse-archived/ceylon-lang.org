---
layout: tour11
title: Interoperation with Java
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

The Ceylon language was designed to execute in a virtual machine
environment (loosely speaking, in an environment with built-in
garbage collection), but it doesn't have its own native virtual
machine. Instead, it "borrows" a virtual machine designed for
some other language. For now the options are the Java Virtual
Machine, or a JavaScript virtual machine. In this chapter, we're
going to learn about how to interoperate with native code running
on the Java Virtual Machine.

## Depending on the Java SDK

A Ceylon program can only use native code belonging to a module. 
In particular, the Java SE SDK is available as a set of modules, 
according to the modularization proposed by the Jigsaw project.
So to make use of the Java SE SDK we need to import one or more
of these modules. For example:

- the module `java.base` contains core packages including
  `java.lang`, `java.util`, and `javax.security`,
- the module `java.desktop` contains the AWT and Swing desktop
  UI frameworks, and
- `java.jdbc` contains the JDBC API.

So, if we need to use the Java collections framework in our
Ceylon program, we need to create a Ceylon module that depends
on `java.base`.

<!-- try: -->
    module org.jboss.example "1.0.0" {
        import java.base "7";
    }

Now, we can simply import the Java class we're interested in
and use it like any ordinary Ceylon class:

<!-- try: -->
    import java.util { HashMap }
    
    void hashyFun() {
        value hashMap = HashMap<String,Object>();
    }

_TODO: instructions for using JavaFX here._

## Depending on a Java archive

Two make use of native code belonging to a packaged `.jar`
archive, you have two options:

- add the archive to a Ceylon module repository, along with
  JBoss modules metadata in a `module.xml` or `module.properties`
  file, or
- import the archive from a legacy Maven repository.

The format of the `module.properties` file is documented
[here](../../reference/structure/module-properties/), and the 
`module.xml` descriptor format is defined 
[here](https://docs.jboss.org/author/display/MODULES/Module+descriptors).

If you're using Ceylon IDE, and you don't want to write the 
`module.xml` descriptor by hand, go to 
`File > Export ... > Ceylon > Java Archive to Module Repository`.

The Ceylon module architecture interoperates with Maven via
Aether. You can find more information 
[here](../../reference/repository/#legacy_repositories).

## Deploying Ceylon on OSGi

_TODO: document OSGi interop._

## Interoperation with Java types

There's a handful of things to be aware of when writing Ceylon 
code that calls a Java class or interface.

### Java primitive types are mapped to Ceylon types

You're never exposed to Java primitive types when calling a
Java method or field from Ceylon. Instead:

- `boolean` is represented by Ceylon's `Boolean` type,
- `char` is represented by Ceylon's `Character` type,
- `long`, `int`, and `short` are represented by 
  Ceylon's `Integer` type,
- `byte` is represented by Ceylon's `Byte` type,
- `double` and `float` are represented by Ceylon's `Float` 
  type, and
- `java.lang.String` is represented by Ceylon's `String` type.

According to these rules, all conversions from a Java primitive 
to a Ceylon type are _widening_ conversions, and are guaranteed 
to succeed at runtime. However, conversion from a Ceylon type 
to a Java primitive type might involve an implicit _narrowing_ 
conversion. For example, if:

- a Ceylon `Integer` is assigned to a Java `int` or `short`,
- a Ceylon `Float` is assigned to a Java `float`, or if
- a Ceylon UTF-32 `Character` is assigned to a Java 16-bit
  `char`

the assignment can fail at runtime, producing an exception.

_Note: it is not a goal of Ceylon's type system to warn about
operations which might result in numeric overflow. In general,
almost _any_ operation on a numeric type, including `+` or `*`, 
can result in numeric overflow._ 

### Java array types are represented by special Ceylon classes

Since there are no primitively-defined array types in Ceylon, 
arrays are represented by special classes. These classes are
considered to belong to the package `java.lang`. (Which belongs
to the module `java.base`.)

- `boolean[]` is represented by the class `BooleanArray`,
- `char[]` is represented by the class `CharArray`,
- `long[]` is represented by the class `LongArray`,
- `int[]` is represented by the class `IntArray`,
- `short[]` is represented by the class `ShortArray`,
- `byte[]` is represented by the class `ByteArray`,
- `double[]` is represented by the class `DoubleArray`,
- `float[]` is represented by the class `FloatArray`, and, 
  finally,
- `T[]` for any object type `T` is represented by the class 
  `ObjectArray<T>`.

We can obtain a Ceylon `Array` without losing the identity 
of the underlying Java array.

<!-- try: -->
    ByteArray javaByteArray = ByteArray(10);
    Array<Byte> byteArray = javaByteArray.byteArray;

You can think of the `ByteArray` as the actual underlying
`byte[]` instance, and the `Array<Byte>` as an instance of 
the Ceylon class `Array` that wraps the `byte[]` instance.

The module `ceylon.interop.java` contains a raft of additional
methods for working with these Java array types.

### Null values are checked at runtime

Java types offer no information about whether a field or method
can produce a null value, except in the very special case of a
primitive type. Therefore, the compiler inserts runtime null 
value checks wherever Ceylon code calls a Java function that 
returns an object type, or evaluates a Java field of object 
type, and assigns the result to an non-optional Ceylon type.

In this example, no runtime null value check is performed, since
the return value of `System.getProperty()` is assigned to an 
optional type:
    
<!-- try: -->
    import java.lang { System }
    
    void printUserHome() {
        String? home = System.getProperty("user.home");
        print(home);
    }

In this example, however, a runtime type check occurs when
the return value of `System.getProperty()` is assigned to the
non-optional type `String`:

<!-- try: -->
    import java.lang { System }
    
    String getUserHome() {
        return System.getProperty("user.home");
    }

The runtime check ensures that `null` can never unsoundly 
propagate from native Java code with unchecked null values 
into Ceylon code with checked null values, resulting in an 
eventual `NullPointerException` in Ceylon code far from the
original call to Java.

### Gotcha!

The Ceylon compiler doesn't have any information that a Java
method could return `null`, and so it won't warn you at 
compile time if you call a Java method that sometimes returns
`null`.

### Java properties are exposed as Ceylon attributes

A Java getter/setter pair will appear to a Ceylon program as
a Ceylon attribute. For example:

<!-- try: -->
    import java.util { Calendar, TimeZone } 

    void calendaryFun() {
        Calendar calendar = Calendar.instance;
        TimeZone timeZone = calendar.timeZone;
        Integer timeInMillis = calendar.timeInMillis;
    }

If you want to call a Java setter method, assign a value to
it using `=`:

<!-- try: -->
    calendar.timeInMillis = system.milliseconds;

### Gotcha!

Note that there are certain corner cases here which might be
confusing. For example, consider this Java class:

<!-- try: -->
<!-- lang: java -->
    public class Foo {
        public String getBar() { ... }
        public void setBar(String bar) { ... }
        public void setBar(String bar, String baz) { ... }
    }

From Ceylon, this will appear as if it were defined like this:

<!-- try: -->
    shared class Foo {
        shared String bar { ... }
        assign bar { ... }
        shared void setBar(String bar, String baz) { ... }
    }


## Wildcards

In pure Ceylon code, we almost always use 
[declaration-site variance](../generics/#covariance_and_contravariance).
However, this doesn't work when we interoperate with Java generic
types with wildcards. Therefore, Ceylon supports use-site variance
(wildcards).

- `List<out Object>` has a covariant wildcard, and is equivalent 
  to `List<? extends Object>` in Java, and
- `Topic<in Object>` has a contravariant wildcard, and is 
  equivalent to `Topic<? super Object>` in Java.

Wildcard types are unavoidable when interoperating with Java, and 
perhaps occasionally useful in pure Ceylon code. But we recommend
avoiding them, except where there's a really good reason.  


## Utility functions and classes

In the module [`ceylon.interop.java`](https://modules.ceylon-lang.org/repo/1/ceylon/interop/java/1.1.0/module-doc/api/index.html)
you'll find a suite of useful utility methods and classes for
Java interoperation. For example, there are classes that adapt
between Ceylon collection types and Java collection types.

## There's more ...

Finally, we're going to learn about interoperation with languages 
like JavaScript with [dynamic typing](../dynamic).
