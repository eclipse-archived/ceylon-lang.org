---
layout: reference
title: Using Java from Ceylon
tab: documentation
unique_id: docspage
milestone: Milestone 2
author: Tom Bentley
---

# #{page.title}

## Description

This page covers how you can use Java classes from Ceylon.

**Important Note: Everything documented here is subject to change before 1.0.**

### Dealing with Ceylon constraints

#### Accessing Java types with an initial lowercase letter

If you want to use a Java type with an initial lowercase letter, you have to
prefix its name with `\I` to let the Ceylon parser know that we're talking about
a type name.

Note that this does not apply to Java primitives, which are in general handled by
the [type mapping](../type-mapping) or by using the corresponding JVM boxed versions.

#### Accessing Java methods or fields with an initial uppercase letter

If you want to use a Java method or field with an initial uppercase letter, you have to
prefix its name with `\i` to let the Ceylon parser know that we're talking about
an attribute/method name.

#### Accessing Java methods or fields whose name is a Ceylon keyword

Ceylon doesn't have many keywords, but if you need to access a Java method or field whose
name, you have to prefix its name with `\i` to let the Ceylon parser know that we're 
talking about an attribute/method name.

### Dealing with overloading

#### Calling overloaded constructors or methods

This should work out of the box.

#### Overriding overloaded methods

This is not possible at the moment, because it would require nothing short of supporting
overloading in Ceylon, [which is not something we want to do](../../../faq/language-design/#overloading).

### Dealing with static fields and methods

Just like in Java, you can use static fields and methods as it they were instance
fields or methods, so if you have an instance at hand, you're all set up.

#### Accessing Static methods or fields

You can access static methods or fields without having an instance of the container
type by importing them from their containing type, which makes them toplevel attributes
or methods:

    import java.io { File { separator, createTempFile } }
    
    void m(){
        print(separator);
        createTempFile("foo", "bar");
    }

Note that you can alias them too like other imports:

    import java.io { JFile = File { sep = separator, roots = listRoots } }
    
    void m(){
        print(sep);
        Array<JFile> roots2 = roots();
    }

Note that since many Java static fields actually have an initial uppercase letter you will
have to prefix their name with `\i`.

### Accessing instance fields

You can access Java instance fields as if they were normal Ceylon attributes,
except if they are not public or if they are hidden by a JavaBean property of
the same name.

### Accessing JavaBean properties

Ceylon maps instance attributes to JavaBean properties, so naturally, every
JavaBean property defined in Java is mapped to a Ceylon instance attribute.

### Accessing instance methods

1. Java Bean accessors (`get*()` and `set*()` methods) will be 
   treated as Ceylon attributes, and therefore can only be accessed as such. 
1. If there is a Java Bean setter that has no corresponding getter (such as in
   the older parts of the JDK such as `Vector.size()` and `Vector.setSize()`)
   then both methods are available as normal Ceylon instance methods.
1. The `Object.toString()` and `Object.hashCode()` methods are mapped to the
   respective Ceylon instance attributes `string` and `hash`, and as such are
   not visible as instance methods.
1. The `java.lang.Object` type is mapped to the Ceylon type 
   `ceylon.language.IdentifiableObject` as defined in [type mapping](../type-mapping),
   therefore the fields and methods defined in `java.lang.Object` are not visible
   in Ceylon (we might change this in the future).

Other instance methods can be accessed as normal Ceylon instance method.

### Catching Java exceptions

A Ceylon-side `catch (Exception e) { ... }` will catch `java.lang.Exception` 
(and, of course its subclasses).

It's currently impossible to catch non-`java.lang.Exception` subclasses of
`java.lang.Throwable`. In particular this means it's currently impossible to 
catch `java.lang.Error`.

### Java primitive types

Every Java primitive type (including arrays) is mapped to a Ceylon type as
described in the [type mapping list](../type-mapping). This means you can
get Java primitives into Ceylon and send them back. If you satisfy or extend
a Java type, Ceylon will use the proper Java primitive types to satisfy the
constraints imposed by the Java type.

In some very specific cases, such as with overloading, you might have to write
some code in a special way though. For instance, since `short` and `int` are
both mapped to the Ceylon type `celon.language.Integer` which in turn is mapped
to `long`, if you want to call a method overriden for a specific version of these
three types, you have to make it explicit:


<!-- lang: java -->
    public class JavaType {
        public void foo(short s){}
        public void foo(long s){}
        public void takesAShort(short s){}
    }

And:

<!-- check:none -->
    import java.lang { JavaShort = Short }
    
    void m(){
        JavaType t = JavaType();
        // this will be stored as a long on the JVM
        Integer i = 2;
        // this will produce a short and thus call foo(short)
        t.foo(JavaShort(i).shortValue());
        // this will call foo(long)
        t.foo(i);
        // naturally this works too
        t.takesAShort(i); 
    }

At the moment you cannot declare a method or attribute in Ceylon such that its
type represents a certain Java primitive (though if you override a method or
attribute, its primitive type will be respected). In the future we may implement
this with a compiler annotation to specify the underlying primitive type to use.

### Java array types

Java arrays are supported and mapped to the Ceylon type `Array&lt;t&gt;` which
means you can access them just like a Ceylon `List`.

<!-- lang: java -->
    public class JavaType {
        public String[] giveMeAnArray(){ return new String[]{"Foo"}; }
        public void takeThisArray(String[] arr){}
    }

And:

<!-- check:none -->
    JavaType t = JavaType();
    Array<String> array = t.giveMeAnArray();
    String first = array[0];
    array.setItem(0, "Updated");
    t.takeThisArray(array);

#### Creating your own Java array in Ceylon

You can create Java arrays in Ceylon, but at the moment you can only create arrays of
non-primitive types:

<!-- lang: java -->
    public class JavaType {
        public void takeThisArray(ceylon.language.String[] arr){}
    }

And:

<!-- check:none -->
    JavaType t = JavaType();
    Array<String> a = array("One", "Two", "Three"); 
    t.takeThisArray(a);

#### Arrays and identity

Currently their identity is not respected: they are boxed to a Ceylon wrapper when they
pass from Java to Ceylon code. This means that the following code will fail:

<!-- check:none -->
    JavaType t = JavaType();
    Array<String> array = t.giveMeAnArray();
    // identical will be false because we're getting two different wrapper objects
    Boolean identical = t.giveMeAnArray() === t.giveMeAnArray();

Note: this will change in the future once we iron out all the optimisations we can do.

The underlying array is always preserved and not copied though, which means that
if you modify an array, the modification will be visible on every reference to that
underlying array, including in the Java type that gave it to you: 

<!-- check:none -->
    JavaType t = JavaType();
    Array<String> array1 = t.giveMeAnArray();
    Array<String> array2 = t.giveMeAnArray();
    array1.setItem(0, "foo");
    Boolean identicalContents = array2[0] == "foo";

#### Arrays of primitives

Arrays of primitives that you get from Java will be mapped according to the 
[type mapping rules](../type-mapping), which means that there will be some
implicit conversions on read/write, but their underlying type will be preserved. 

It is not possible at the moment to create an array of Java primitive types in Ceylon.
This will be supported in the future, probably by a future Java interoperability module.

### Java `enum` types

It is currently impossible to create a Java enum from Ceylon, but you can use them as if
they were toplevel objects:

<!-- lang: java -->
    public enum JavaEnum {
    
        ONE, TWO;
    
        public long field;
        public void method(){}
        public long getProperty(){ return 1; }
        public void setProperty(long p){}
    }

And:

<!-- check:none -->
    import com.foo { JavaEnum { one = \iONE, two = \iTWO } }

    void enums(){
        JavaEnum e = one;
        e.field := e.field;
        e.property := e.property;
        e.method();
    }

## Obtaining Java `jar` dependencies

You can either install Java `jar` dependencies in your Ceylon [repositories](../../repository) manually
in order for Ceylon to find them, or you can resolve them from legacy 
[Maven repositories](../../repository/#legacy_repositories). 

## See also

* [Calling Ceylon from Java](../ceylon-from-java)
* The [type mapping rules](../type-mapping)

