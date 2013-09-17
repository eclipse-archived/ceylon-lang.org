---
layout: reference
title: Using Java from Ceylon
tab: documentation
unique_id: docspage
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

<!-- try: -->
    import java.io { File { separator, createTempFile } }
    
    void m(){
        print(separator);
        createTempFile("foo", "bar");
    }

Note that you can alias them too like other imports:

<!-- try: -->
    import java.io { JFile = File { sep = separator, roots = listRoots } }
    import java.lang { ObjectArray }
    
    void m(){
        print(sep);
        ObjectArray<JFile> roots2 = roots();
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

<!-- try: -->
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

### Java array types <!-- m5 -->

Java arrays are supported and mapped to _virtual_ objects in the `java.lang` package:

<table>
  <tbody>
    <tr>
      <th>Java type</th>
      <th>Ceylon type</th>
    </tr>
    <tr>
      <td><code>boolean[]</code></td>
      <td><code>java.lang.BooleanArray</code></td>
    </tr>
    <tr>
      <td><code>byte[]</code></td>
      <td><code>java.lang.ByteArray</code></td>
    </tr>
    <tr>
      <td><code>short[]</code></td>
      <td><code>java.lang.ShortArray</code></td>
    </tr>
    <tr>
      <td><code>int[]</code></td>
      <td><code>java.lang.IntArray</code></td>
    </tr>
    <tr>
      <td><code>long[]</code></td>
      <td><code>java.lang.LongArray</code></td>
    </tr>
    <tr>
      <td><code>float[]</code></td>
      <td><code>java.lang.FloatArray</code></td>
    </tr>
    <tr>
      <td><code>double[]</code></td>
      <td><code>java.lang.DoubleArray</code></td>
    </tr>
    <tr>
      <td><code>char[]</code></td>
      <td><code>java.lang.CharArray</code></td>
    </tr>
    <tr>
      <td><code>T[]</code></td>
      <td><code>java.lang.ObjectArray&lt;T&gt;</code></td>
    </tr>
  </tbody>
</table>

These virtual types must be imported from the `java.base/7` module, as the rest of the core of the JDK, and
their definition is as follows, for example for `BooleanArray`:

<!-- try: -->
    shared class BooleanArray(Integer size, Boolean element = false){
        
        doc "Gets the item at the specified index"
        shared Boolean get(Integer index);
        
        doc "Sets the item at the specified index"
        shared void set(Integer index, Boolean element);
        
        doc "The array size"
        shared Integer size;
        
        doc "Get a Ceylon Array that is a view backed by this array"
        shared Array<Boolean> array;
        
        doc "Copies this array to another array"
        shared void copyTo(BooleanArray destination, Integer sourcePosition = 0, Integer destinationPosition = 0, Integer length = size);
    }

As you can see, we mapped every Java array operation to methods and attributes, and added a way to get a
Ceylon `Array` object from a Java array, which allows you to access Java arrays as if they were Ceylon
arrays. Be careful that the Java array is only wrapped so all changes to it will be visible in the
Ceylon `Array`.

Note that the `IntArray` type has an extra method to convert an array of Unicode Code Points to a Ceylon
`Array` of `Character`:

<!-- try: -->
        doc "Get a Ceylon Array that is a view backed by this array"
        shared Array<Character> codePointArray;

See how to use Java arrays:

<!-- lang: java -->
    public class JavaType {
        public String[] giveMeAnArray(){ return new String[]{"Foo"}; }
        public void takeThisArray(String[] arr){}
    }

And:

<!-- try: -->
    JavaType t = JavaType();
    ObjectArray<String> array = t.giveMeAnArray();
    String first = array.get(0);
    array.set(0, "Updated");
    t.takeThisArray(array);


#### Working with Java arrays

We added another _virtual_ type in `java.lang` called `arrays`, to allow you to create Java arrays based on Ceylon
`Iterable` values, and to unwrap Ceylon `Array` to the Java arrays they are wrapping. We also have various methods
to help converting arrays of Java `String` and Ceylon `String` values.

It has the following signature:

<!-- try: -->
    shared object arrays {
    
        doc "Converts an `Iterable` of `Integer` to a Java `byte` array"
        shared ByteArray toByteArray({Integer*} values);
    
        doc "Unwraps a Ceylon array to the Java `byte` array it was constructed from (using `ByteArray.array` at the time)"
        shared ByteArray asByteArray(Array<Integer> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `short` array"
        shared ShortArray toShortArray({Integer*} values);
    
        doc "Unwraps a Ceylon array to the Java `short` array it was constructed from (using `ShortArray.array` at the time)"
        shared ShortArray asShortArray(Array<Integer> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `int` array"
        shared IntArray toIntArray({Integer*} values);
    
        doc "Unwraps a Ceylon array to the Java `int` array it was constructed from (using `IntArray.array` at the time)"
        shared IntArray asIntArray(Array<Integer> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `long` array"
        shared LongArray toLongArray({Integer*} values);
    
        doc "Unwraps a Ceylon array to the Java `long` array it was constructed from (using `LongArray.array` at the time)"
        shared LongArray asLongArray(Array<Integer> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `float` array"
        shared FloatArray toFloatArray({Float*} values);
    
        doc "Unwraps a Ceylon array to the Java `float` array it was constructed from (using `FloatArray.array` at the time)"
        shared FloatArray asFloatArray(Array<Float> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `double` array"
        shared DoubleArray toDoubleArray({Float*} values);
    
        doc "Unwraps a Ceylon array to the Java `double` array it was constructed from (using `DoubleArray.array` at the time)"
        shared DoubleArray asDoubleArray(Array<Float> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `char` array"
        shared CharArray toCharArray({Character*} values);
    
        doc "Unwraps a Ceylon array to the Java `char` array it was constructed from (using `CharArray.array` at the time)"
        shared CharArray asCharArray(Array<Character> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `int` array"
        shared IntArray toCodePointArray({Character*} values);
    
        doc "Unwraps a Ceylon array to the Java `int` array it was constructed from (using `IntArray.codePointArray` at the time)"
        shared IntArray asCodePointArray(Array<Character> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `boolean` array"
        shared BooleanArray toBooleanArray({Boolean*} values);
    
        doc "Unwraps a Ceylon array to the Java `boolean` array it was constructed from (using `BooleanArray.array` at the time)"
        shared BooleanArray asBooleanArray(Array<Boolean> array);
    
        doc "Converts an `Iterable` of `Integer` to a Java `Object` array"
        shared ObjectArray<T> toObjectArray<T>({T*} values);
    
        doc "Unwraps a Ceylon array to the Java `Object` array it was constructed from (using `ObjectArray<T>.array` at the time)"
        shared ObjectArray<T> asObjectArray<T>(Array<T> array);
    
        doc "Converts an `Iterable` of Ceylon `String` to a Java array of Java `String`"
        shared ObjectArray<JavaString> toJavaStringArray({String*} values);
    
        doc "Converts an `Iterable` of Java `String` to a Java array of Ceylon `String`"
        shared ObjectArray<String> toStringArray({JavaString*} values);
    
        doc "Converts a Java array of Java `String` to a Java array of Ceylon `String`"
        shared ObjectArray<String> javaStringArrayToCeylonStringArray(ObjectArray<JavaString> array);
    
        doc "Converts a Java array of Ceylon `String` to a Java array of Java `String`"
        shared ObjectArray<JavaString> ceylonStringArrayToJavaStringArray(ObjectArray<String> array);
    }


#### Creating your own Java array in Ceylon

You can create Java arrays in Ceylon:

<!-- lang: java -->
    public class JavaType {
        public void takeThisArray(ceylon.language.String[] arr){}
        public void takeThisArray(int[] arr){}
    }

And:

<!-- try: -->
    JavaType t = JavaType();
    ObjectArray<String> a = arrays.toJavaStringArray{"One", "Two", "Three"}; 
    t.takeThisArray(a);
    IntArray i = arrays.toIntArray{1, 2, 3}; 
    t.takeThisArray(i);

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

<!-- try: -->
    import com.foo { JavaEnum { one = \iONE, two = \iTWO } }

    void enums(){
        JavaEnum e = one;
        e.field = e.field;
        e.property = e.property;
        e.method();
    }

## Calling Java code with unsafe nulls <!-- m4 -->

Ceylon always knows whether a value can or not be `null`, but this is not the case in Java,
so when calling Java code, we don't really know if a value, or a method's return value
can be `null` or not. There's simply no way to know this, unless you know the API, and so
the decision is yours. When calling Java code, we will make your life easier and treat
the return values as non-optional, so you can store them in non-optional variables,
but you can also treat them as optional (like in `exists` tests) and things will work out.

If you decide to store a value obtained from calling Java code into a non-optional variable,
we will insert a `null` check at the threshold, so that you get an exception at the most useful
place. That check is of course not generated if you store a Java value in an optional variable,
because `null` is allowed then.

We treat Java method parameters and writeable fields and JavaBean properties as accepting
optional values if they are not Java primitives, thus allowing you to set them to `null`
or to a value.

## Implementing Java code with unsafe nulls <!-- m4 -->

When implementing a Java interface or class in Ceylon, you can decide to make the method
parameters and return values optional or not. The same is true when implementing JavaBean
properties (as Ceylon attributes). 

## Using Java annotations on Ceylon declarations

Ceylon annotations differ from Java annotations in an important respect: 
Ceylon requires an annotation constructor to be invoked at the 
declaration being annotated. 
Java doesn't have the concept of an annotation constructor, so for 
each Java annotation type we pretend there's a corresponding annotation 
constructor (whose name is the same as the annotation type name, 
but with a lower cased initial letter), which can be `import`ed:

    import javax.annotation{generated, 
        postConstruct, 
        preDestroy, 
        resource,
        Resource {
            AuthenticationType{
                application=\iAPPLICATION
            }
        }
    }

These annotation constructors can then be used in the same way as normal 
Ceylon annotation constructors

    class Foo() {
        postConstruct
        shared void afterConstrution() {}
    }

Invocations of these synthetic annotation constructors support Java enumeration 
elements and class literals (using `Declaration` reference expressions):

    class Bar() {
        resource{
            name="tom";
            authenticationType=application;
            type=`AnnotationInterop`;
        }
        annotationTakingClass(`class Bar`)
        shared variable String tom = "";
    }

## Importing JDK modules <!-- m4 -->

The Java JDK is not imported by default anymore since Milestone 4, which means you need to import
the JDK modules if you want to import JDK packages.

The JDK has been mapped to Ceylon modules following the current JDK module list for 
[Jigsaw](http://openjdk.java.net/projects/jigsaw/), which is the module system planned
for Java 9. Note that the Jigsaw module list is far from being final, so it is subject to
change.

The current list of JDK modules is as follows:

- `java.base`: the JDK base packages such as `java.lang`, `java.util`, `java.io`, `java.net`, `java.text`,
NIO and security
- `java.logging`: contains `java.util.logging` aka. JUL
- `java.desktop`: contains `java.applet`, `java.awt.**`, `javax.imageio.**`, `javax.print.**`, `javax.sound`, `javax.swing.**`, `javax.accessibility`
- `java.jdbc`: contains `java.sql`, `javax.sql`
- `java.jdbc.rowset`: contains `javax.sql.rowset.**`
- `javax.script`: contains `javax.script`
- `javax.xml`: contains `javax.xml.**`, `org.w3c.dom.**`, `org.xml.sax.**`
- `javax.xmldsig`: contains `javax.xml.crypto.**`
- `java.management`: contains `javax.management`
- `java.instrument`: contains `java.lang.instrument`
- `java.rmi`: contains `java.rmi`
- `java.prefs`: contains `java.util.prefs`
- `java.tls`: contains `javax.net.**`, `javax.security.cert`
- `java.auth`: contains `javax.security.sasl`
- `java.auth.kerberos`: contains `javax.security.auth.kerberos`, `org.ietf.jgss`
- `java.security.acl`: contains `java.security.acl`
- `javax.naming`: contains `javax.naming.**`
- `javax.transaction`: contains `javax.transaction.**`
- `javax.jaxws`: contains `javax.xml.bind.**`, `javax.xml.soap`, `javax.xml.ws.**`, `javax.activation`
- `javax.annotation`: contains `javax.annotation`
- `java.corba`: contains `javax.activity`, `javax.rmi.**`, `org.omg.**`
- `java.compiler`: contains `javax.tools`, `javax.lang.model.**`, `javax.annotation.processing`

There are additional vendor-specific JDK modules, whose module/package-list mappings are
[defined in the source](https://github.com/ceylon/ceylon-module-resolver/blob/master/impl/src/main/resources/com/redhat/ceylon/cmr/impl/package-list.oracle.jdk7).

## Obtaining Java `jar` dependencies

You can either install Java `jar` dependencies in your Ceylon [repositories](../../repository) manually
in order for Ceylon to find them, or you can resolve them from legacy 
[Maven repositories](../../repository/#legacy_repositories). 

## See also

* [Calling Ceylon from Java](../ceylon-from-java)
* The [type mapping rules](../type-mapping)

