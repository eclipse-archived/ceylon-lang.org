---
layout: reference
title: Calling Ceylon from Java
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Description

Although titled '*Calling* Ceylon from Java', this page covers all access to 
Ceylon types from Java, not just method calls.

**Important Note: Everything documented here is subject to change after M1.**

### Declaring Ceylon types

In general a Ceylon type compiles into a Java type of the same name.

### Instantiating Ceylon classes

Ceylon types are instantiated like every Java type, except they can only have
a single constructor. 

#### Calling a Ceylon initialiser with default parameter values

Ceylon initialisers can have default parameter values. If you want to call an initialiser with
default parameter values, you need to know where to fetch the default values from.

The following Ceylon code:

    shared class Foo(Integer n = 5, Integer m = n + 1) {
    }

Can be invoked in Java using the following code:

<!-- lang: java -->
    long n = Foo.Foo$impl.$init$n();
    // Note that default parameter values may use previous parameter values 
    long m = Foo.Foo$impl.$init$m(n); 
    Foo f = new Foo(n, m);

### Accessing Ceylon attributes

If the Ceylon attribute
is annotated `shared` the Java accessor will be declared `public`, otherwise
it will be annotated `private`.

#### Instance attributes

In general a Ceylon instance attribute compiles into a Java Bean-style getter and 
(if the attribute is `variable` or has an `assign` block) setter. 

`Boolean` attributes use `get` accessors rather than an `is` accessors. 
Note that a `get` accessor is still valid for `boolean` properties 
according to the Java Bean specification.

#### Toplevel attributes

A toplevel attribute is compiled into a class of the same name, which is `final`,
has a `private` constructor, a `static` getter method and if the attribute is mutable, a
corresponding `static` setter method.

Toplevel attributes like the following:

    shared variable Boolean bool = true;

Are accessed and set using the following Java code:

<!-- lang: java -->
    // bool is the name of the Java class that holds the toplevel attribute 
    boolean value = bool.getBool();
    bool.setBool(false);

If a Ceylon attribute name is a Java keyword, the Java type name
will be prefixed with `$`, like `$true`.

### Calling Ceylon methods

In general a Ceylon method compiles directly into a Java method of the same 
name. The method result type and argument types may not however 
translate directly because of the [type mapping rules](../type-mapping).

If a Ceylon method name is a Java keyword, it will be prefixed with `$`, like `$true`.

#### Calling Ceylon toplevel methods

A Ceylon toplevel method is compiled into a class of the same name, which is `final`,
has a `private` constructor, and a `static` method of the same name corresponding to the 
toplevel method.

Toplevel methods like the following:

    shared Boolean foo(Boolean b){
        return b;
    }

Are called using the following Java code:

<!-- lang: java -->
    // foo is the name of the Java class that holds the toplevel method 
    boolean value = foo.foo(false);

#### Calling a Ceylon method with default parameter values

Ceylon methods can have default parameter values. If you want to call a method with
default parameter values, you need to know where to fetch the default values from.

The following Ceylon code:

    shared class Foo() {
        shared void foo(Integer n = 5, Integer m = n + 1) {}
    }

Can be invoked in Java using the following code:

<!-- lang: java -->
    Foo f = new Foo();
    long n = Foo.Foo$impl.foo$n(f);
    // Note that default parameter values may use previous parameter values 
    long m = Foo.Foo$impl.foo$m(f, n); 
    f.foo(n, m);

### Methods and initialisers with varargs

Method and initialisers can have varargs, which are represented in the resulting Java
code as a `Iterable<? extends T>` parameter.

If you wish to invoke a Ceylon method or initialiser that supports varargs you need to
use the following idiom:

<!-- lang: java -->
    // Foo.foo supports varargs of String...
    Foo f = new Foo();
    // pass no parameter
    f.foo(ceylon.language.$empty.getEmpty());
    // pass two parameters
    f.foo(new ceylon.language.ArraySequence(ceylon.language.String.instance("a"), 
                                            ceylon.language.String.instance("b")));


### Catching Ceylon exceptions

The root of the exception hierarchy in Ceylon is `ceylon.language.Exception`, 
(a subclass of `java.lang.RuntimeException` at runtime). This means that pure Ceylon code can only
generate unchecked exceptions.

Impure Ceylon (that is, Ceylon code which access Java code) may throw 
*any* exception that is thrown by that Java code, including checked exceptions. 
Ceylon methods do not declare `throws java.lang.Throwable` in their bytecode, 
even though they can in principle throw `Throwable`. In practice 
Ceylon methods are very unlikely to throw `Throwable` itself 
(because Java methods are unlikely to), but Ceylon methods are quite likely 
to throw `java.lang.Exception`. So unless you know otherwise, it's 
probably sensible to wrap calls to Ceylon methods in a Java-side 
`try/catch` which handles this possibility.

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
        <td><code>byte x</code>, <code>short x</code>, <code>int x</code>, <code>long x</code></td>
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

## See also

* [Calling Java from Ceylon](../java-from-ceylon)
* The [type mapping rules](../type-mapping)

