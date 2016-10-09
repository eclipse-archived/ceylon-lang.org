---
layout: tour13
title: Interoperation with Java
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

Ceylon is designed to execute in a virtual machine environment 
(loosely speaking, in an environment with built-in garbage
collection), but it doesn't have its own native virtual machine.
Instead, it "borrows" a virtual machine designed for some other
language. For now the options are:

- the Java Virtual Machine, or 
- a JavaScript virtual machine. 

In this chapter, we're going to learn about how to interoperate 
with native code running on the Java Virtual Machine. In the
[next chapter](../dynamic) we'll discuss JavaScript.

## Defining a native Java module

Many Ceylon modules that call native Java code are designed
to execute only no the JVM. In this case, we declare the whole
Ceylon module as a _native JVM module_ using the `native`
annotation.

<!-- try: -->
    native ("jvm") 
    module ceylon.formatter "1.3.1" {
        shared import java.base "7";
        shared import com.redhat.ceylon.typechecker "1.3.1";
        import ceylon.collection "1.3.1";
        ...
    }

A cross-platform module may call native Java code too, but in
this case we need to apply the `native` import to `import`
statements that declare dependencies on native Java `jar`
archives.

<!-- try: -->
    module ceylon.formatter "1.3.1" {
        native ("jvm") shared import java.base "7";
        shared ("jvm") import com.redhat.ceylon.typechecker "1.3.1";
        import ceylon.collection "1.3.1";
        ...
    }

Furthermore, in this case, we must annotate declarations which 
make use of the Java classes in these archives.

<!-- try: -->
    import java.lang { System }
    
    native ("jvm")
    void hello() => System.out.println("Hello, world!");

It's *not* necessary to annotate individual declarations in a
module that is already declared as a native JVM module.

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

To make use of native code belonging to a packaged `.jar`
archive, you have two options:

- add the archive to a Ceylon module repository, along with
  JBoss Modules metadata defined in a `module.xml` or 
  `module.properties` file, or
- import the archive directly from a 
  [legacy Maven repository](../../reference/repository/maven).

A `module.xml` or `module.properties` file specifies dependency
information for a `.jar`.

- The format of the `module.properties` file is documented
  [here](../../reference/structure/module-properties/), and 
- the `module.xml` descriptor format is defined 
  [here](https://docs.jboss.org/author/display/MODULES/Module+descriptors).

If you're using Ceylon IDE for Eclipse, and you don't want to 
write the `module.xml` descriptor by hand, go to 
`File > Export ... > Ceylon > Java Archive to Module Repository`.

The Ceylon module architecture interoperates with Maven via
Aether. You can find more information 
[here](../../reference/repository/maven).

## Deploying Ceylon on OSGi

Ceylon is fully interoperable with OSGI, so that Ceylon 
modules:

- can be deployed as pure OSGI bundles in an OSGI container 
  out-of-the-box, without any modification of the module 
  archive file,
- can embed additional OSGI metadata, to declare services for 
  example, and
- can easily use OSGI standard services.

This provides a great and straightforward opportunity to run 
Ceylon code inside a growing number of JEE application servers 
or enterprise containers that are based upon (or integrated 
with) OSGI.

You can learn more about Ceylon and OSGi from the 
[reference documentation](../../reference/interoperability/osgi-overview).

## Interoperation with Java types

Calling and extending Java types from Ceylon is mostly 
completely transparent. You don't need to do anything "special"
to use or extend a Java class or interface in Ceylon, or to
call its methods.

There's a handful of things to be aware of when writing Ceylon 
code that calls a Java class or interface, arising out of the
differences between the type systems of the two languages.

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

Almost all of the time, this behavior is completely intuitive.
But there's two wrinkles to be aware of...

### Gotcha!

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

### Gotcha again!

There's no mapping between Java's *wrapper* classes like 
`java.lang.Integer` or `java.lang.Boolean` and Ceylon basic 
types, so these conversions must be performed explicitly by
calling, for example, `intValue()` or `booleanValue()`, or
by explicitly instantiating the wrapper class, just like you
would do in Java when converting between a Java primitive
type and its wrapper class.

This is mainly important when working with Java collection
types. For example, a Java `List<Integer>` doesn't contain
_Ceylon_ `Integer`s.

<!-- try: -->
    import java.lang { JInteger=Integer }
    import java.util { JList=List } 
    
    JList<JInteger> integers = ... ;
    for (integer in integers) { //integer is a JInteger!
        Integer int = integer.intValue(); //convert to Ceylon Integer
        ...
    }

(This isn't really much worse than Java, by the way: a Java
 `List<Integer>` doesn't contain Java `int`s either!)

Worse, a Java `List<String>` doesn't contain _Ceylon_
`String`s.

<!-- try: -->
    import java.lang { JString=String }
    import java.util { JList=List } 
    
    JList<JString> strings = ... ;
    for (string in strings) { //string is a JString!
        String str = string.string; //convert to Ceylon String
        ...
    }

Watch out for this!

### Tip: converting Java strings

Explicitly converting between `String` and Java `String` is
easy:

- the `.string` attribute of a Java string returns a Ceylon
  string, and
- one of the constructors of  `java.lang.String` accepts a
  Ceylon `String`, or, alternatively,
- the function [`javaString`](#{site.urls.apidoc_current_interop_java}/index.html#javaString) 
  in the module `ceylon.interop.java` converts a Ceylon string
  to a Java string without requiring an instantiation.

### Tip: converting Java primitive wrapper types

Likewise, conversions between Ceylon types and Java primitive
wrapper types are just as trivial, for example:

- the `.intValue()` method of `java.lang.Integer` returns a
  Ceylon `Integer`, and
- the constructor of `java.lang.Integer` accepts a Ceylon 
  `Integer`.

### Tip: using the `small` annotation

If, for some strange reason, you _really_ need a 32-bit `int` 
or `float` at the bytecode level, instead of the 64-bit `long`
or `double` that the Ceylon compiler uses by default, you can
use the `small` annotation.

<!-- try: -->
    small Integer int = string.hash;

Note that `small` is defined as a _hint_, and may be ignored
by the compiler. 

### Java array types are represented by special Ceylon classes

Since there are no primitively-defined array types in Ceylon, 
arrays are represented by special classes. These classes are
considered to belong to the package `java.lang`. (Which belongs
to the module `java.base`.) So these classes must be explicitly
imported!

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
    import java.lang { ByteArray }
    
    ByteArray javaByteArray = ByteArray(10);
    Array<Byte> byteArray = javaByteArray.byteArray;

You can think of the `ByteArray` as the actual underlying
`byte[]` instance, and the `Array<Byte>` as an instance of 
the Ceylon class `Array` that wraps the `byte[]` instance.

The [module `ceylon.interop.java`](https://herd.ceylon-lang.org/modules/ceylon.interop.java) 
contains a raft of additional methods for working with these
Java array types.

### Java generic types are represented without change

A generic instantiation of a Java type like `java.util.List<E>` 
is representable without any special mapping rules. A Java 
`List<String>` may be written as `List<String>` in Ceylon, 
after importing `List` and `String` from the module `java.base`.

<!-- try: -->
    import java.lang { String }
    import java.util { List, ArrayList }
    
    List<String> strings = ArrayList<String>();

### Tip: disambiguating Java types using aliases

Note that it's a good idea to distinguish a Java type with
the same name as a common Ceylon type using an `import` alias.
So we would rewrite the code fragment above like this:

<!-- try: -->
    import java.lang { JString = String }
    import java.util { JList = List, JArrayList = ArrayList }
    
    JList<JString> strings = JArrayList<JString>();

### Wildcards and raw types are represented using use-site variance

In pure Ceylon code, we almost always use 
[declaration-site variance](../generics/#covariance_and_contravariance).
However, this doesn't work when we interoperate with Java 
generic types with wildcards. Therefore, Ceylon supports 
use-site variance (wildcards).

- `List<out Object>` has a covariant wildcard, and is 
  equivalent to `List<? extends Object>` in Java, and
- `Topic<in Object>` has a contravariant wildcard, and is 
  equivalent to `Topic<? super Object>` in Java.

Java raw types are also represented with a covariant wildcard. 
The raw type `List` is represented as `List<out Object>` in 
Ceylon.

Wildcard types are unavoidable when interoperating with Java, 
and perhaps occasionally useful in pure Ceylon code. But we 
recommend avoiding them, except where there's a really good 
reason.

### Gotcha!

Instances of Java generic types don't carry information about
generic type arguments at runtime. So certain operations which
are legal in Ceylon are rejected by the Ceylon compiler when
a Java generic type is involved. For example, the following code
is illegal, since `JList` is a Java generic type, with erased
type arguments:

<!-- try: -->
    import java.lang { JString = String }
    import java.util { JList = List, JArrayList = ArrayList }
    
    Object something = JArrayList<JString>();
    if (is JList<JString> something) { //error: type condition cannot be fully checked at runtime
        ... 
    }

This isn't a limitation of Ceylon; the equivalent code is also
illegal in Java!

### Tip: dealing with Java type erasure

When you encounter the need to narrow to an instantiation of a
Java generic type, you can use an _unchecked_ type assertion:

<!-- try: -->
    import java.lang { JString = String }
    import java.util { JList = List, JArrayList = ArrayList }
    
    Object something = JArrayList<JString>();
    if (is JList<out Anything> something) { //ok
        assert (is JList<JString> something); //warning: type condition might not be fully checked at runtime
        ...
    }

This code is essentially the same as what you would do in Java:

1. test against the raw type `List` using `instanceof`, and then
2. narrow to `List<String>` using an unchecked typecast.

Just like in Java, the above code produces a warning, since the
type arguments in the assertion cannot be checked at runtime.

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

The Ceylon compiler doesn't usually have any information that a
Java method returning a class or interface type could return `null`, 
and so it won't warn you at compile time if you call a Java method
that sometimes returns `null`.

### Java types annotated `@Nullable` are exposed as optional types

There are now a number of Java frameworks that provide 
annotations (`@Nullable` and `@Nonnull`/`@NonNull`/`@NotNull`) 
for indicating whether a Java type can contain `null` values. 
The Ceylon compiler understands these annotations.

So, as an exception to the above gotcha, when one of these
annotations is present, Java null values _are_ checked at
compile time.

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

Therefore: 

- to call the single-argument setter, use an assignment
  statement like `foo.bar = bar`, but
- to call the two-argument setter, use a method call like
  `foo.setBar(bar,baz)`.

### Java constants and enum values

Java constants like `Integer.MAX_VALUE` and enum values, like
`RetentionPolicy.RUNTIME` follow an all-uppercase naming 
convention. Since this looks rather alien in Ceylon code, it's
acceptable to refer to them using camel case. This:

<!-- try: -->
    Integer maxInteger = JInteger.maxValue;
    RetentionPolicy policy = RetentionPolicy.runtime;

is preferred to this:

<!-- try: -->
    Integer maxInteger = JInteger.\iMAX_VALUE;
    RetentionPolicy policy = RetentionPolicy.\iRUNTIME;

However, both options are accepted by the compiler.

## Java annotations

Java annotations may be applied to Ceylon program elements.
An initial lowercase identifier must be used to refer to the
Java annotation type.

For example:

<!-- try: -->
    import javax.persistence {
        id,
        generatedValue,
        entity,
        column,
        manyToOne,
    }
    
    entity
    class Person(firstName, lastName, city) {
        
        id generatedValue
        column { name = "pid"; }
        value _id = 0;
        
        shared String firstName;
        shared String lastName;
        
        manyToOne { optional=false; }
        shared City city;
        
        string => "Person(``_id``, ``firstName`` ``lastName``, ``city.name``)";
    }

Note that `id` here refers to the Java annotation `javax.persistence.Id`.

Annotation values of type `java.util.Class` may be specified
by passing the corresponding Ceylon `ClassDeclaration`. For
example, you would use `` `Person` `` where you would use 
`Person.class` in Java.

## Java `Iterable`s and `AutoCloseable`s 

It's possible to use a `java.lang.Iterable` or Java array in 
a Ceylon `for` statement or comprehension.

<!-- try: -->
    import java.lang { JIterable=Iterable }
    
    JIterable<Object> objects = ... ;
    for (obj in objects) {
        ...
    }

Similarly, it's possible to use a Java `AutoCloseable` in a
Ceylon `try` statement.

<!-- try: -->
    import java.io { File, FileInputStream }
    
    File file = ... ;
    try (inputStream = FileInputStream(file)) {
         ...
    }

### Gotcha!

Note that there is no special handling for type of the 
iterated elements: if the iterable contains Java `String`s 
they're not magically transformed to Ceylon `String`s:

<!-- try: -->
    import java.lang { JIterable=Iterable, JString=String }
    
    JIterable<JString> strings = ...;
    for (s in strings) {
        // s is a JString
    }

### Gotcha again!

Also note that `java.lang.Iterable` is not supported together 
with entry or tuple destructuring:

<!-- try: -->
    JIterable<String->String> stringPairs = ...;
    for (key->item in stringPairs) {
        // not supported
    }

In practice it's unusual to have a Java `Iterable` containing 
Ceylon `Entry`s or `Tuple`s.

## Java collections and operators 

Two of Ceylon's built-in operators may be applied to Java types:

- the element lookup operator (`list[index]`) may be used 
  with Java arrays, `java.util.List`, and `java.util.Map`, 
  and
- the containment operator (`element in container`) may be 
  used with instances of `java.util.Collection`.

## Utility functions and classes

In the module [`ceylon.interop.java`](#{site.urls.apidoc_current_interop_java}/index.html)
you'll find a suite of useful utility functions and classes for
Java interoperation. For example, there are classes that adapt
between Ceylon collection types and Java collection types.

### Tip: creating Java lists

The following idioms are very useful for instantiating Java 
`List`s:

<!-- try: -->
    import java.util { Arrays }
    
    value words = Arrays.asList("hello", "world");
    value squares = Arrays.asList(for (x in 0..100) x^2);
    value args = Arrays.asList(*process.arguments);

(Note that these code examples work because `Arrays.asList()`
has a variadic parameter.)

### Tip: xonverting between `Iterable`s

An especially useful adaptor is 
[`CeylonIterable`](#{site.urls.apidoc_current_interop_java}/CeylonIterable.type.html), 
which lets you apply any of the usual operations of a Ceylon 
[stream](#{site.urls.apidoc_1_3}/Iterable.type.html) to it.

<!-- try: -->
    import java.util { JList=List, JArrayList=ArrayList }
    import ceylon.interop.java { CeylonIterable }
    
    ...
    
    JList<String> strings = JArrayList<String>();
    strings.add("hello");
    strings.add("world");
    
    CeylonIterable(strings).each(print);

(Alternatively, we could have used 
[`CeylonList`](#{site.urls.apidoc_current_interop_java}/CeylonList.type.html)
in this example.)

Similarly there are `CeylonStringIterable`, `CeylonIntegerIterable`, 
`CeylonFloatIterable`,`CeylonByteIterable` and `CeylonBooleanIterable` 
classes which as well as converting the iterable type also convert
the elements from their Java types to the corresponding Ceylon type.

### Tip: getting a `java.util.Class`

Another especially useful function is 
[`javaClass`](#{site.urls.apidoc_current_interop_java}/index.html#javaClass),
which obtains an instance of `java.util.Class` for a given type.

<!-- try: -->
    import ceylon.interop.java { javaClass }
    import java.lang { JClass=Class }
    
    JClass<Integer> jc = javaClass<Integer>();
    print(jc.protectionDomain);

The functions [`javaClassFromInstance`](#{site.urls.apidoc_current_interop_java}/index.html#javaClassFromInstance)
and [`javaClassFromDeclaration`](#{site.urls.apidoc_current_interop_java}/index.html#javaClassFromDeclaration)
are also useful.

## `META-INF` and `WEB-INF`

Some Java frameworks and environments require metadata packaged 
in the `META-INF` or `WEB-INF` directory of the module archive, 
or sometimes even in the root directory of the module archive. 
We've already seen how to [package resources](../modules/#resources) 
in Ceylon module archives by placing the resource files in the 
module-specific subdirectory of the resource directory, named 
`resource` by default.

Then, given a module named `net.example.foo`:

- resources to be packaged in the root directory of the module 
  archive should be placed in `resource/net/example/foo/ROOT/`,
- resources to be packaged in the `META-INF` directory of the 
  module archive should be placed in 
  `resource/net/example/foo/ROOT/META-INF/`, and
- resources to be packaged in the `WEB-INF` directory of the 
  module archive should be placed in 
  `resource/net/example/foo/ROOT/WEB-INF/`.

## Interoperation with Java's `ServiceLoader`

 Annotating a Ceylon class with the `service` annotation makes
 the class available to Java's 
 [service loader architecture](https://docs.oracle.com/javase/8/docs/api/java/util/ServiceLoader.html).

<!-- try: -->
     service (`Manager`)
     shared class DefautManager() satisfies Manager {}
 
 A Ceylon module may gain access to Java services by calling
 [`Module.findServiceProviders()`](#{site.urls.apidoc_1_3}/meta/declaration/Module.type.html#findServiceProviders).

<!-- try: -->
     {Manager*} managers = `module`.findServiceProviders(`Manager`);
     assert (exists manager = managers.first);"

This code will find the first `service` which implements 
`Manager` and is defined in the dependencies of the module in 
which this code occurs. To search a different module and its 
dependencies, specify the module explicitly:

<!-- try: -->
     {Manager*} managers = `module com.acme.manager`.findServiceProviders(`Manager`);
     assert (exists manager = managers.first);"

The `service` annotation and `Module.findServiceProviders()`
work portably across the JVM and JavaScript environments.

## Limitations

Here's a couple of limitations to be aware of:

- You can't call Java methods using the named argument syntax, 
  since Java 7 doesn't expose the names of parameters at runtime 
  (and Ceylon doesn't yet depend on features of Java 8).
- You can't obtain a method reference, nor a static method 
  reference, to an overloaded method.
- Java generic types don't carry reified type arguments at 
  runtime, so certain operations that depend upon reified 
  generics (for example, some `is` tests) are rejected at 
  compile time, or unchecked at runtime.

## There's more ...

You can learn more about `native` declarations from the 
[reference documentation](/documentation/reference/interoperability/native/).

In a mixed Java/Ceylon project, you'll probably need to use a 
build system like Gradle, Maven, or Apache `ant`. Ceylon has 
[plugins](../../reference/tool/) for each of these build 
systems.

Finally, we're going to learn about interoperation with 
languages like JavaScript with [dynamic typing](../dynamic).
