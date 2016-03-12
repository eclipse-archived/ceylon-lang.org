---
layout: tour12
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

If you're using Ceylon IDE, and you don't want to write the 
`module.xml` descriptor by hand, go to 
`File > Export ... > Ceylon > Java Archive to Module Repository`.

The Ceylon module architecture interoperates with Maven via
Aether. You can find more information [here](../../reference/repository/maven).

## Deploying Ceylon on OSGi

Ceylon is fully interoperable with OSGI, so that Ceylon modules:

- can be deployed as pure OSGI bundles in an OSGI container out-of-the-box without any modification of the module archive file,
- can embed additional OSGI metadata, to declare services for example,
- can easily use OSGI standard services

This provides a great and straightforward opportunity to run Ceylon code inside a growing number of JEE application servers or enterprise containers that are based upon (or integrated with) OSGI.

#### Installing the Ceylon distribution / Ceylon SDK in an OSGI container

In order to be able to resolve and start Ceylon module archives (`.car` files) inside an OSGI container, you will first need to install, in the OSGI container, all the bundles of the Ceylon distribution and SDK.

These bundles are available in a dedicated location on the Ceylon language web site under various delivery forms:

- OSGI bundle repositories (OBR and R5 XML), for Felix-based containers for example,
- P2 repositories for Eclipse development or deployment to an Equinox container,
- Zip archives for direct deployment inside containers,
- Apache Karaf (aka JBoss Fuse) [features](http://karaf.apache.org/manual/latest/users-guide/provisioning.html)

The OSGI interoperability reference gives more details about the [URLs providing these packages](../../reference/interoperability/osgi#retrieving_the_ceylon_distribution_and_sdk_for_osgi), as well as [how to install](../../reference/interoperability/osgi#installing_the_ceylon_distribution_and_sdk_in_an_osgi_container) these bundles, for various containers

#### OSGI Metadata management

[Module archives](./modules#module_archives_and_module_repositories) generated
for execution on the Java virtual machine already contain the OSGI metadata that
can be deduced from the Ceylon module descriptor.

More precisely, for the following module descriptor:

    native("jvm") module example.pureCeylon "3.1.0" {
        import ceylon.locale "1.2.2";
        import java.base "7";
        shared import ceylon.net "1.2.2";
    }

the following OSGI metadata will be automatically generated in the module archive `META-INF/MANIFEST.MF` entry:

    Bundle-SymbolicName: example.pureCeylon
    Bundle-Version: 3.1.0.v20160311-1742
    Export-Package: example.pureCeylon;version=3.1.0
    Require-Bundle: com.redhat.ceylon.dist;bundle-version=1.2.2;visibility
     :=reexport,ceylon.locale;bundle-version=1.2.2,ceylon.net;bundle-versi
     on=1.2.2;visibility:=reexport,ceylon.language;bundle-version=1.2.2;vi
     sibility:=reexport
    Require-Capability: osgi.ee;filter:="(&(osgi.ee=JavaSE)(version>=1.7))"

The Ceylon module imports are translated into a `Require-Bundle` header, and `shared` imports are translated into a `reexport` directive.The `java.base "7"` import is translated into a `Require-Capability` header that requires the same Java version.

Note that the `com.redhat.ceylon.dist` bundle is systematically and implicitly added as a dependency to all generated Ceylon archives.

However it is also possible to customize the OSGI metadata of the generated archive in 2 ways:

1. Additional manifest entries or resources (such as a desclarative service descriptor) can be added by simply adding resources as explained [below](#meta_inf_and_web_inf).

2. Module imports that correspond to __dependencies provided by the OSGI container__ (such as the OSGI framework bundle or any bundle assumed to be available in the OSGI container) should be omitted from the generated `Require-Bundle` header. The `--osgi-provided-bundles=<modules>` option of the `ceylon compile` command allows specifying those modules. The same list can also be specified in the [compiler section](http://www.ceylon-lang.org/documentation/1.2/reference/tool/config#_compiler_section) of the configuration file.
  
  Generally, once omitted from the `Require-Bundle` header, the dependencies to provided bundles should be declared in an `Import-Package` header added in the [`MANIFEST.MF` resource](#meta_inf_and_web_inf), as mentioned in point 1.
 
#### Ceylon Metamodel registering

In order to be able to fully leverage the power of the Ceylon language, the metamodel should be initialized for each module used by a Ceylon application. It is automatically performed when running from the command line through the `ceylon run` command, but in an OSGi container it should be done when starting the Ceylon module. The Ceylon OSGI distribution provides an easy way to register the metamodel for a module, as well as for all the modules transitively imported.

This can be done by adding an OSGI activator class to the Ceylon module, that performs this metamodel registration. The `com.redhat.ceylon.dist` OSGI bundle, implicitly required by all Ceylon modules, already provides such an activator class: `com.redhat.ceylon.dist.osgi.Activator`

So if you don't need to do anything else in your OSGI Ceylon bundle at startup, you can simply add the following line to your [MANIFEST.MF resource](#meta_inf_and_web_inf):

    Bundle-Activator: com.redhat.ceylon.dist.osgi.Activator

Alternatively, if you need to perform some sort initialization in your Ceylon module bundle startup, you can also define an `Activator` class that will delegate to the default `com.redhat.ceylon.dist.osgi.Activator`. In this case:

1. Explicitly import the `com.redhat.ceylon.dist` module in your module descriptor:

       native("jvm") module example.withActivator "1.0.0" {
           import com.redhat.ceylon.dist "1.2.2";
           import java.base "7";
       }

2. Add the following class to your module:

       import com.redhat.ceylon.dist.osgi {
           DefaultActivator = Activator
       }
       import org.osgi.framework {
           BundleContext
       }
       
       shared class Activator() extends DefaultActivator() {
           shared actual void start(BundleContext context) {
               // do module startup stuff
               super.start(context); // will perform the metamodel registering
           }
           shared actual void stop(BundleContext context) {
               // do module shutdown stuff
               super.stop(context);
           }
       }

3. Add the following line to your `example/withActivator/ROOT/META-INF/MANIFEST.MF` resource:

       Bundle-Activator: example.withActivator.Activator

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

There is no mapping between Java's *wrapper* classes like 
`java.lang.Integer` or `java.lang.Boolean` and Ceylon basic 
types, so these conversions must be performed explicitly by
calling, for example, `intValue()` or `booleanValue()`, or
by explicitly instantiating the wrapper class, just like you
would do in Java when converting between a Java primitive
type and its wrapper class.

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

The [module `ceylon.interop.java`](https://herd.ceylon-lang.org/modules/ceylon.interop.java) contains a raft of additional
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

## Iterables

Since Ceylon 1.2.1 it is possible to use a `java.lang.Iterable` in a Ceylon 
`for` statement, like this:

    import java.lang{JIterable=Iterable, JString=String}

    JIterable<Object> objects = ...;
    for (obj in objects) {
        // ...
    }
    
Note that there is no special handling for type of the iterated elements:
If the iterable contains Java `String`s they're not magically transformed to 
Ceylon `String`s:

    JIterable<JString> strings = ...;
    for (s in strings) {
        // s is a JString
    }

Also note this is not supported when using an entry or tuple destructing 
iterator:

    JIterable<String-String> stringPairs = ...;
    for (key->item in stringPairs) {
        // not supported
    }

In practice it is unusual to have a Java `Iterable` of Ceylon `Entry`s 
or `Tuple`s.

## Utility functions and classes

In the module [`ceylon.interop.java`](#{site.urls.apidoc_current_interop_java}/index.html)
you'll find a suite of useful utility functions and classes for
Java interoperation. For example, there are classes that adapt
between Ceylon collection types and Java collection types.

### Converting between `Iterable`s

An especially useful adaptor is 
[`CeylonIterable`](#{site.urls.apidoc_current_interop_java}/CeylonIterable.type.html), 
which lets you iterate any Java `Iterable` from a `for` loop in 
Ceylon, or apply any of the usual operations of a Ceylon 
[`Iterable`](#{site.urls.apidoc_1_2}/Iterable.type.html) to it.

<!-- try: -->
    import java.util { JList=List, JArrayList=ArrayList }
    import ceylon.interop.java { CeylonIterable }
    
    ...
    
    JList<String> strings = JArrayList<String>();
    strings.add("hello");
    strings.add("world");
    
    for (string in CeylonIterable(strings)) {
        print(string);
    }

(Alternatively, we could have used 
[`CeylonList`](#{site.urls.apidoc_current_interop_java}/CeylonList.type.html)
in this example.)

Similarly there are `CeylonStringIterable`, `CeylonIntegerIterable`, 
`CeylonFloatIterable`,`CeylonByteIterable` and `CeylonBooleanIterable` 
classes which as well as converting the iterable type also convert
the elements from their Java types to the corresponding Ceylon type.

### Getting a `java.util.Class`

Another especially useful function is [`javaClass`](#{site.urls.apidoc_current_interop_java}/index.html#javaClass),
which obtains an instance of `java.util.Class` for a given type.

<!-- try: -->
    import ceylon.interop.java { CeylonIterable }
    import java.lang { JClass=Class }
    
    JClass<Integer> jc = javaClass<Integer>();
    print(jc.protectionDomain);

The functions [`javaClassFromInstance`](#{site.urls.apidoc_current_interop_java}/index.html#javaClassFromInstance)
and [`javaClassFromDeclaration`](#{site.urls.apidoc_current_interop_java}/index.html#javaClassFromDeclaration)
are also useful.

## Java annotations

You can annotate a Ceylon class or interface with Java annotations.
However, you must use an initial lowercase identifier to refer to
the Java annotation.

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

### Gotcha!

A Java annotation with `@Target(ElementType.METHOD)` may be applied to
a getter or setter method on Java. Similarly, it may be applied to a
Ceylon getter or setter. But it _may not_ be applied it to a Ceylon 
_reference_ declaration.

For example, given the following Java annotation:

<!-- lang: java -->
    @Target(ElementType.METHOD)
    public @interface Awesome {}

We may apply the annotation to a getter or setter:

<!-- try: -->
    awesome String name => _name;
    awesome assign name => _name = name;

But the following is _not_ legal:

<!-- try: -->
    awesome String name = "Trompon"; //compile error!

The reason for this restriction is that if either:

- the Ceylon reference is `variable`, or
- the Java annotation is also marked `@Target(ElementType.FIELD)`,

then this code would be ambiguous.

## `META-INF` and `WEB-INF`

Some Java frameworks and environments require metadata packaged in
the  `META-INF` or `WEB-INF` directory of the module archive, or
sometimes even in the root directory of the module archive. We've
already seen how to [package resources](../modules/#resources) in 
Ceylon module archives by placing the resource files in the modules' 
subdirectory of the resource directory, named `resource` by default.

Then, given a module named `net.example.foo`:

- resources to be packaged in the root directory of the  module 
  archive should be placed in `resource/net/example/foo/ROOT/`,
- resources to be packaged in the `META-INF` directory of the 
  module archive should be placed in 
  `resource/net/example/foo/ROOT/META-INF/`, and
- resources to be packaged in the `WEB-INF` directory of the 
  module archive should be placed in 
  `resource/net/example/foo/ROOT/WEB-INF/`.
    
## Limitations

Here's a couple of limitations to be aware of:

- You can't call Java methods using the named argument syntax, since
  Java 7 doesn't expose the names of parameters at runtime (and 
  Ceylon doesn't yet depend on features of Java 8).
- You can't obtain a method reference, nor a static method reference,
  to an overloaded method.
- Java generic types don't carry reified type arguments at runtime, 
  so certain operations that depend upon reified generics (for 
  example, some `is` tests) fail at runtime.

## There's more ...

In a mixed Java/Ceylon project, you'll probably need to use a build
system like Gradle, Maven, or Apache `ant`. Ceylon has 
[plugins](../../reference/tool/) for each of these build systems.

Finally, we're going to learn about interoperation with languages 
like JavaScript with [dynamic typing](../dynamic).
