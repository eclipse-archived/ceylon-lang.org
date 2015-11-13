---
layout: reference12
title_md: Using Ceylon from Java
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

## Description

This page covers how you can use Ceylon classes, interfaces etc from Java.

### Ceylon classes and interfaces

Every

- toplevel Ceylon class or interface, or 
- Ceylon inner class 

compiles to a Java class or interface of the same name.

The situation is more complicated for inner interfaces. The compiler 
produces a top level interface whose name is produced by concatenating the 
names of containing types with `$`.

For example, this Ceylon class:

<!-- try: -->
    class C() {
        interface I {}
    }
    
results in the following Java interface:

<!-- lang: java -->
    interface C$I {}

This is necessary in order to support arbitrary nesting of interfaces and 
classes within other types, which cannot be expressed in Java.

### Instantiating Ceylon classes

A Ceylon class with initializer parameters or a default constructor is 
instantiated like any other Java class. 

For example, suppose we have the following Ceylon class:

<!-- try: -->
    shared class Person(String name) {}

Then, in Java, we can call the constructor like this:

<!-- lang: java -->
    Person person = new Person("Some One");

This would still be true if the class were defined with a default 
constructor like this:

<!-- try: -->
    shared class Person { shared new(String name) {} }

On the other hand, instantiation via a named constructor is a bit less 
comfortable. Given:

<!-- try: -->
    shared class Person {
        shared new create(String name) {}
    }

Then, in Java, we can call the named constructor like this:

<!-- lang: java -->
    Person person = new Person(Person.create_, "Some One");

### Instantiating a class with defaulted parameters

A Ceylon class or constructor may have defaulted parameters. Such a class 
has an overloaded constructor for each defaulted initializer parameter or 
default constructor parameter.

For example, suppose we have the following Ceylon class:

<!-- try: -->
    shared class Animal(String name, Species = elephant, Integer age = 0) {}

Then, in Java, we can instantiate a `Person` as follows:

<!-- lang: java -->
    Animal animal = new Animal("Trompon");
    Animal animal = new Animal("Trompon", elephant);
    Animal animal = new Animal("Trompon", elephant, 6);

This would still be true if the class were defined with a default 
constructor like this:

<!-- try: -->
    shared class Animal {
        shared new(String name, Species = elephant, Integer age = 0) {}
    }

### Accessing Ceylon values

The type of a Ceylon value is translated to Java according to the 
[type mapping rules](../type-mapping).

If a Ceylon value name is a Java keyword, it will be prefixed with `$`, 
for example, `$int`.

#### Instance attributes

A `shared` Ceylon attribute compiles into a JavaBean-style getter 
and&mdash;if the attribute is `variable` or has an `assign` 
block&mdash;a JavaBeans-styel setter.

For example, this class has `getName()`, `getAge()`, and `setAge()`:

<!-- try: -->
    class Person(shared String name, shared variable Integer age) {}

`Boolean` attributes use `get` accessors rather than an `is` accessors. 
(Note that a `get` accessor is acceptable for `boolean` properties, 
according to the JavaBean specification.)

If both the attribute and the type it belongs to are `shared`, the
Java accessors will be `public`.

#### Toplevel values

A toplevel value compiles to a class of the same name, suffixed with an 
underscore (`_`), which:

- is `final`,
- has a `private` constructor, 
- a `static` getter method and,
- if the attribute is mutable, a corresponding `static` setter method.

For example, this toplevel values:

<!-- try: -->
    shared variable Boolean bool = true;

may be accessed and set using the following Java code:

<!-- lang: java -->
    // bool_ is the name of the Java class that holds the toplevel value 
    boolean value = bool_.get_();
    bool_.set_(false);

If the value is declared `shared`, the class and its accessors will both
be `public`.

### Calling Ceylon functions

A Ceylon function compiles directly into a Java method of the same name. 
The method result type and argument types are translated according to the 
[type mapping rules](../type-mapping).

If a Ceylon function name is a Java keyword, it will be prefixed with `$`, 
for example, `$true`.

#### Toplevel functions

A toplevel function compiles to a class of the same name, suffixed with 
an underscore (`_`), which:

- is `final`,
- has a `private` constructor, and 
- a `static` method of the same name as the toplevel function.

Thus, this toplevel function:

<!-- try: -->
    shared Boolean foo(Boolean b) => !b;

may be called using the following Java code:

<!-- lang: java -->
    // foo_ is the name of the Java class that holds the toplevel function 
    boolean value = foo_.foo(false);

#### Calling a function with defaulted parameters

A Ceylon function may have defaulted parameters. There will be an overloaded 
method for each defaulted parameter. 

For example, suppose we have the following Ceylon function:

<!-- try: -->
    shared Boolean foo(Boolean b = false, Boolean c = false) => b||c;

Then, in Java, we can invoke `foo()` as follows:

<!-- lang: java -->
    Boolean bool = foo();
    Boolean bool = foo(true);
    Boolean bool = foo(true, true);

### Functions, initializers, and constructors with variadic parameters

A function, initializer, or constructor may have a variadic parameter, which 
is represented in the resulting Java code as a parameter of type 
`Sequential<? extends T>`. 

### Catching Ceylon exceptions

The root of the exception hierarchy in Ceylon is `ceylon.language::Throwable`, 
Unlike Java's `Throwable`, 
`ceylon.language::Throwable` is `sealed` and the only subclasses available 
to users are `ceylon.language::Exception` and `ceylon.language::AssertionError`.
In order to best interoperate between the JVM and the JavaScript virtual 
machines there's is no Ceylon equivalent to `java.lang.Error`
(in general JavaScript virtual machine errors are uncatchable and fatal). 

The JVM implementation of `ceylon.language::Exception` is a 
`java.lang.RuntimeException`. On the other hand, `ceylon.language::AssertionError` is a 
`java.lang.Error` at runtime. This means that pure Ceylon code 
compiled for the JVM can only generate unchecked exceptions.

Impure Ceylon (that is, Ceylon code which access Java code) may throw 
*any* exception that is thrown by that Java code, including checked exceptions. 
Ceylon methods do not declare `throws java.lang.Throwable` in their bytecode, 
even though they can in principle throw `Throwable`. In practice 
Ceylon methods are very unlikely to throw `Throwable` itself 
(because Java methods are unlikely to), but Ceylon methods are quite likely 
to throw `java.lang.Exception`. So unless you know otherwise, it's 
probably sensible to wrap calls to Ceylon methods in a Java-side 
`try/catch` which handles this possibility.

If you really need to catch `java.lang.Error` from Ceylon you have two choices:

* you can catch `ceylon.language::Throwable` and then decide whether 
  you really have the error you're interested in (e.g. from 
  its error message). This has a tendency to be bug-prone 
  (exception messages can change), but doesn't require your module to 
  be JVM only.

* if you're willing to have a JVM-only module you can
 explicitly import `java.lang.Error` and catch it directly.

### Type conversions

If you need to convert a Java or Ceylon type according to the 
[type mapping rules](../type-mapping), you can do so using the following
methods.

#### Convert from a Java type to a Ceylon type

<table>
    <tr>
        <th>Java type</th>
        <th>Convert to Ceylon object</th>
    </tr>
    <tr>
        <td><code>boolean b</code></td>
        <td><code>ceylon.language.Boolean.instance(b)</code></td>
    </tr>
    <tr>
        <td><code>byte x</code></td>
        <td><code>ceylon.language.Byte.instance(x)</code> <!--1.1--></td>
    </tr>
    <tr>
        <td><code>short x</code>, <code>int x</code>, <code>long x</code></td>
        <td><code>ceylon.language.Integer.instance(x)</code></td>
    </tr>
    <tr>
        <td><code>float x</code>, <code>double x</code></td>
        <td><code>ceylon.language.Float.instance(x)</code></td>
    </tr>
    <tr>
        <td><code>char c</code></td>
        <td><code>ceylon.language.Character.instance(c)</code></td>
    </tr>
    <tr>
        <td><code>T[] a</code></td>
        <td><code>ceylon.language.Array.instance(a)</code></td>
    </tr>
    <tr>
        <td><code>java.lang.String s</code></td>
        <td><code>ceylon.language.String.instance(s)</code></td>
    </tr>
</table>

#### Convert from a Ceylon type to a Java type

<table>
    <tr>
        <th>Ceylon type</th>
        <th>Convert to Java object</th>
    </tr>
    <tr>
        <td><code>ceylon.language.Boolean b</code></td>
        <td><code>b.booleanValue()</code></td>
    </tr>
    <tr>
        <td><code>ceylon.language.Byte b</code></td>
        <td><code>b.byteValue()</code> <!--1.1--></td>
    </tr>
    <tr>
        <td><code>ceylon.language.Integer i</code></td>
        <td><code>i.longValue()</code></td>
    </tr>
    <tr>
        <td><code>ceylon.language.Float f</code></td>
        <td><code>f.doubleValue()</code></td>
    </tr>
    <tr>
        <td><code>ceylon.language.Character c</code></td>
        <td><code>c.intValue()</code></td>
    </tr>
    <tr>
        <td><code>ceylon.language.Array a</code></td>
        <td><code>a.toArray()</code></td>
    </tr>
    <tr>
        <td><code>ceylon.language.String s</code></td>
        <td><code>s.toString()</code></td>
    </tr>
</table>

## Annotating Java declarations with Ceylon annotations

Ceylon annotation classes are compiled into Java annotation types (`@interface`s). 
Each annotation class parameter is mapped to an annotation type member. 
This means it's mostly a matter of adding the Ceylon annotation types 
to your Java declarations.

* The name of the annotation type is the name of the annotation class 
  with `$annotation` appended
* Annotation classes that subclass `SequencedAnnotation` have an extra 
  wrapper annotation type, which holds an array of the individual 
  annotations. The name of this wrapper annotation type is the 
  name of the annotation class with `$annotations` appended.
* Annotation classes that subclass `ConstrainedAnnotation` have their 
  program element constraints transformed into a 
  `@Target` constaint. However, due to the differing semantics for 
  constraining annotations it's not a bijective mapping.
* Due to the constraints placed on annotation types by the Java language 
  and virtual machine to type mapping differs
    * `Iterable`, `Sequence` and `Tuple`-typed parameters are 
    all mapped to a Java array of the relevant type.
    * Declaration references are mapped to `java.lang.String` using a special syntax 
      detailed below.
    * `object`s of enumerated types mapped to the `java.lang.Class`
      for the anonymous class.

The grammar for the Declaration reference syntax is as follows:

    ref              ::= version? module ;
                         // note: version is optional to support looking up the
                         // runtime version of a package, once we support this
    version          ::= ':' SENTINEL ANYCHAR* SENTINEL ;
    module           ::= dottedIdent package? ;
    dottedIdent      ::= ident ('.' ident)* ;
    package          ::= ':' ( relativePackage | absolutePackage ) ? ( ':' declaration ) ? ;
                         // note: if no absolute or relative package given, it's the 
                         // root package of the module
    relativePackage  ::= dottedIdent ;
    absolutePackage  ::= '.' dottedIdent ;
                         // note: to suport package names which don't start 
                         // with the module name
    declaration      ::= type | function | value ;
    type             ::= class | interface ;
    class            ::= 'C' ident ( '.' member )?
    interface        ::= 'I' ident ( '.' member )?
    member           ::= declaration ;
    function         ::= 'F' ident ;
    value            ::= 'V' ident ;

For example the `ClassDeclaration` for `ceylon.language::String` in ceylon.language 
version 0.6 would be `::0.6:ceylon.language::CString`, and for the value `true` 
it would be `::0.6:ceylon.language::Vtrue`.


## See also

* [Calling Java from Ceylon](../java-from-ceylon)
* The [type mapping rules](../type-mapping)

