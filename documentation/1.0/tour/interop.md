---
layout: tour
title: Tour of Ceylon&#58; Interoperation with Java
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
- `long`, `int`, `short`, and `byte` are represented by 
  Ceylon's `Integer` type,
- `double` and `float` are represented by Ceylon's `Float` 
  type, and
- `java.lang.String` is represented by Ceylon's `String` type.

According to these rules, all conversions from a Java primitive 
to a Ceylon type are _widening_ conversions, and are guaranteed 
to succeed at runtime. However, conversion from a Ceylon type 
to a Java primitive type might involve an implicit _narrowing_ 
conversion. For example, if:

- a Ceylon `Integer` is assigned to a Java `int` or `byte`,
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
considered to belong to `java.lang`:

- `boolean[]` is `java.lang.BooleanArray`,
- `char[]` is `java.lang.CharArray`,
- `long[]` is `java.lang.LongArray`,
- `int[]` is `java.lang.IntArray`,
- `short[]` is `java.lang.ShortArray`,
- `byte[]` is `java.lang.ByteArray`,
- `double[]` is `java.lang.DoubleArray`, and
- `float[]` is `java.lang.FloatArray`.

The object `arrays` in `java.lang` provides methods for casting
these types to a Ceylon `Array` type.

<!-- try: -->
    import java.lang { JavaString=String, Byte, arrays }
    
    Array<Byte> byteArray = JavaString("hello world").bytes.array;  //cast a ByteArray to Array<Byte>
    ByteArray bytes = arrays.asByteArray(byteArray);  //cast it back to ByteArray

You can think of the `ByteArray` as the actual underlying
`byte[]` instance, and the `Array<Byte>` as an instance of the
Ceylon class `Array` that wraps the `byte[]` instance.

### Null values are checked at runtime

Java types offer no information about whether a field or method
can produce a null value, except in the very special case of a
primitive type. Therefore, the compiler inserts runtime null value 
checks wherever Ceylon code calls a Java function that returns an 
object type, or evaluates a Java field of object type, and assigns
the result to an non-optional Ceylon type.

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

### Overloaded methods cannot be refined in Ceylon

It's possible to call an overloaded method defined in Java
from Ceylon, but it's not possible to write a Ceylon class
which refines multiple overloaded methods with the same
name.

### All generic Java types are invariant

Ceylon treats all parameterized types defined in Java as
invariant types. Unfortunately, since Ceylon does not (or at
least does not _yet_) have use-site variance, Java types with 
wildcards cannot be correctly represented within Ceylon's type 
system. 

## There's more ...

Finally, we're going to learn about interoperation with languages 
like JavaScript with [dynamic typing](../dynamic).
