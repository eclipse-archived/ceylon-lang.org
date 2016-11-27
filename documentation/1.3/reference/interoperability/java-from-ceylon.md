---
layout: reference13
title_md: Using Java from Ceylon
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

## Description

This page covers how you can use Java classes from Ceylon.

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

#### Accessing Java declarations whose name is a Ceylon keyword

If you need to access a Java method or field whose
name is a Ceylon keyword (e.g. a method called `value()`), you have to prefix its name with `\i` 
to let the Ceylon parser know that we're talking about an attribute/method name.

If you need to access a Java class or interface whose
name is a Ceylon keyword (e.g. a class called `value`), you have to prefix its name with `\I` 
to let the Ceylon parser know that we're talking about a type name.

### Dealing with overloading

#### Calling overloaded constructors or methods

No special syntax is required to call an overloaded constructor or method.

Occasionally, as in Java, a typecast is required to distinguish the overloaded
version. Ceylon doesn't have unsafe typecasts, but it does have the [`of`](../../operator/of) operator:

<!-- try: -->
    import java.lang { JException=Exception }
    
    ...
    
    throw JException(null of String?);

#### Overriding overloaded methods

Although it [is not possible in Ceylon to declare overloaded methods](../../../faq/language-design/#overloading), 
it is possible to refine overloaded methods defined in a Java type. 

### Dealing with static fields and methods

It's easy to access `static` members of a Java class.

#### Accessing static methods or fields

You can access static methods or fields just like you would in Java:

<!-- try: -->
    import java.io { File }
    
    void m(){
        print(File.separator);
        File.createTempFile("foo", "bar");
    }

Note that since many Java static fields actually have an initial uppercase letter you will
have to prefix their name with `\i`.

#### Importing static methods or fields

Alternatively, you can import a `static` method or field from its containing type:

<!-- try: -->
    import java.io { File { separator, createTempFile } }
    
    void m(){
        print(separator);
        createTempFile("foo", "bar");
    }

You can even use aliases:

<!-- try: -->
    import java.io { JFile = File { sep = separator, roots = listRoots } }
    import java.lang { ObjectArray }
    
    void m(){
        print(sep);
        ObjectArray<JFile> roots2 = roots();
    }

This is a good way to eliminate the `\i`:

<!-- try: -->
    import java.lang { Integer { maxInt=\iMAX_VALUE } }
    
    void m() {
        print(maxInt);
    }

### Accessing instance fields

You can access Java instance fields as if they were normal Ceylon attributes,
except if they are not `public` or if they are hidden by a JavaBean property of
the same name.

### Accessing JavaBean properties

Ceylon maps instance attributes to JavaBean properties, so naturally, every
JavaBean property defined in Java is mapped to a Ceylon instance attribute.

### Accessing instance methods

1. Java Bean accessors (`get*()` and `set*()` methods) will be treated as Ceylon 
   attributes, and therefore can only be accessed as such. 
2. If there is a Java Bean setter that has no corresponding getter (such as in
   the older parts of the JDK such as `Vector.size()` and `Vector.setSize()`)
   then both methods are available as normal Ceylon instance methods.
3. The `Object.toString()` and `Object.hashCode()` methods are mapped to the
   respective Ceylon instance attributes `string` and `hash`, and as such are
   not visible as instance methods.
4. Other methods declared by `java.lang.Object` are not visible in Ceylon.

Other instance methods can be accessed as normal Ceylon instance methods.

### Catching Java exceptions

A Ceylon-side `catch (Exception e) { ... }` will catch `java.lang.Exception` 
(and, of course its subclasses).

A Ceylon-side `catch (Throwable e) { ... }` will catch `java.lang.Throwable`. 
There is no way to catch only `java.lang.Error`.

Since Ceylon 1.2.1 you can use a `java.lang::AutoCloseable` as a resource in 
a Ceylon [`try`](../../statement/try) statement.

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

### Java array types

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

These virtual types must be imported from the `java.base/7` or `java.base/8` 
module, as the rest of the core of the JDK, and
their definition is as follows, for example for `BooleanArray`:

<!-- try: -->
    import java.lang { JBoolean = Boolean }

    shared class BooleanArray(Integer size, Boolean element = false){
        
        "Gets the item at the specified index"
        shared Boolean get(Integer index);
        
        "Sets the item at the specified index"
        shared void set(Integer index, Boolean element);
        
        "The array size"
        shared Integer size;
        
        "Get a Ceylon Array that is a view backed by this array"
        shared Array<JBoolean> array;

        "Get a Ceylon Array that is a view backed by this array"
        shared Array<Boolean> booleanArray;
        
        "Get a Ceylon Iterable that is a view backed by this array"
        shared Iterable<Boolean> iterable;

        "Copies this array to another array"
        shared void copyTo(BooleanArray destination, 
                           Integer sourcePosition = 0, 
                           Integer destinationPosition = 0, 
                           Integer length = size - sourcePosition);

        "True if this array is equal to the given array"
        shared Boolean equals(Object other);

        "A string representation of this array"
        shared String string;

        "A hash code for this array"
        shared Integer hash;

        "A shallow copy of this array"
        shared BooleanArray clone();
    }

As you can see, we mapped every Java array operation to methods and attributes, and added a way to get a
Ceylon `Array` object from a Java array, which allows you to access Java arrays as if they were Ceylon
arrays. Be careful that the Java array is only wrapped so all changes to it will be visible in the
Ceylon `Array`.

Note that the `IntArray` type has an extra method to convert an array of Unicode Code Points to a Ceylon
`Array` of `Character`:

<!-- try: -->
        "Get a Ceylon Array that is a view backed by this array"
        shared Array<Character> codePointArray;

Also note that the `ObjectArray` type is covariant in its element type `T`, as is the case in Java, and
that therefore, to fit Ceylon semantics regarding declaration-site variance, its `set` method accepts
`Object` and not just `T`. However, if you try to store elements whose type is not compatible with `T`,
you will get a `java.lang.ArrayStoreException`.

<!-- try: -->
    shared class ObjectArray<out T>(Integer size, T? element = null){
        "Sets the item at the specified index"
        shared void set(Integer index, Object element);
        // ...
    }

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

Ceylon 1.2.2 brought a number of improvements to interoperating with 
Java arrays:

<!-- try: -->
    // lookup operator support for arrays
    value firstViaLookup = array[0];
    // arrays in a for statement
    for (string in array) {
        print(string);
    }
    // arrays in a for comprehension
    value shouty = {for (string in array) uppercased};
    
#### Creating your own Java array in Ceylon

You can create Java arrays in Ceylon:

<!-- lang: java -->
    public class JavaType {
        public void takeThisArray(String[] arr){}
        public void takeThisArray(int[] arr){}
    }

And:

<!-- try: -->
    JavaType t = JavaType();
    ObjectArray<JString> a = ObjectArray<JString>(2);
    a.set(0, "foo");
    a.set(1, "bar"); 
    t.takeThisArray(a);
    IntArray i = IntArray(2); 
    a.set(0, 0);
    a.set(1, 1); 
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

Or:

<!-- try: -->
    import com.foo { JavaEnum }

    void enums(){
        JavaEnum e = JavaEnum.\iONE;
        e.field = e.field;
        e.property = e.property;
        e.method();
    }

## Other areas of interoperation

Since Ceylon 1.2.2 there has been some improved support for interop with 
certain language constructs:

<!-- try: -->
    import java.lang{ JIterable=Iterable }
    import java.util{ JMap=Map, JList=List }
    JIterable<Person> people = ...;
    JList<Person> peopleList = ...;
    JMap<Person,Task> tasks = ...;
    
    // Use java.lang.Iterable in for statements
    for (person in people) {
        print(person.name);
    }
    
    // Use java.lang.Iterable in for comprehensions
    value adults = {for (person in people) if (person.age > 18) person};
    
    // Using the lookup operator with java.util.List
    value firstPerson = peopleList[0];
    
    // Using the lookup operator with java.util.Map
    value firstTask = tasks[firstPerson];
    
    // Using in operator with java.util.Collection
    assert (firstPerson in peopleList);
   

## Calling Java code with unsafe nulls

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

## Implementing Java code with unsafe nulls

When implementing a Java interface or class in Ceylon, you can decide to make the method
parameters and return values optional or not. The same is true when implementing JavaBean
properties (as Ceylon attributes). 

## Using Java annotations on Ceylon declarations

Ceylon annotations differ from Java annotations in an important respect: 
Ceylon requires an *annotation constructor* to be invoked at the 
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

In some cases the target of the annotation is ambiguous, for example you might 
need to annotate a *field* with `@Inject`, but in Ceylon there is no 
field in the source code to apply the annotation to. 
In these cases there are several synthetic annotation 
constructors available, named according to the possible `@Target` of the 
annotation type in question. For example
 
    class Injected() {
        inject__FIELD
        shared variable String whatever;
    }

The compiler will warn you if you apply an annotation constructor to an 
element in an ambiguous way, and force you to use the more specific 
named variant.

## java.io.Serializable

It is a common requirement of Java frameworks that user classes 
be serializable (in the Java sense).

Ceylon classes directly extending `Basic` or `Object` automatically 
implement `java.io.Serializable` whether or not
they are declared with a `satisfies Serializable` clause. Of course, subclasses 
of such classes will inherit `java.io.Serializable`. Thus most classes 
in Ceylon are serializable.

`object`s and instances created from value constructors are supported
and result in the appropiate instance being resolved during deserialization.
This means that you still have a single instance of classes which are 
supposed to be singletons.

Currently there is no mechanism for marking a field as `transient` or 
for specifying a `serialVersionUID`. It is possible to implement the 
"magic" methods of 
[`java.io.Serializable`][1]
`writeObject()`, `readObject()`, `readObjectNoData()`, 
`writeReplace()` and `readResolve()`.

A number of runtime classes are not serializable, including callables, 
the iterables supporting comprehensions and metamodel 
implementation classes. This means that you should thoroughly test
the actually serializability of the instances your application creates 
if you're relying on 
serializablility in your application.

[1]:https://docs.oracle.com/javase/7/docs/api/java/io/Serializable.html


## 'Default' constructors

Frameworks frequently require that user classes have a no-arguments 
constructor. The need for this usually stems from the fact that such 
classes will be instantiated via reflection APIs. 

The usual idiom in Ceylon is for the constructor to fully initialize 
the instance. Thus the idomatic class:

    class Person(firstName, lastName, dateOfBirth) {
        shared variable String firstName;
        shared variable String lastName;
        shared variable Date dateOfBirth;
    }
    
would have to be written non-idiomatically as 

    class Person {
        shared variable String firstName;
        shared variable String lastName;
        shared variable Date dateOfBirth;
        "Constructor for the framework"
        shared new () {
            this.firstName = "";
            this.lastName = "";
            this.dateOfBirth = epoch;
        }
        shared new instance(String firstName, String lastName, Date dateOfBirth) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.dateOfBirth = dateOfBirth;
        }
    }

You could omit the `instance()` constructor, but at the cost Ceylon clients of 
`Person` having to instantiate and then call the setters separately.

    
So the ceylon compiler generates a 
`protected` no-arguments constructor behind the scenes, specifically for use 
by frameworks, while Ceylon clients get the benefits of an API that is 
pleasant to use.

There are some cases where a constructor is not generated (or is not no-arguments):

* Generic classes have constructors, but they take reified type arguments, 
  and so won't be useful to frameworks. (They will be useful to non-generic 
  subclasses though).
* `object` ("anonymous") classes, since these have a singleton semantic 
  which would be subverted by providing an accessible constructor.
* Simiarly, classes which have only value constructors.


## Importing JDK modules

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
- `javax.xml`: contains `javax.xml.**`, `org.w3c.dom`, `org.w3c.dom.{bootstrap,events,ls}`
   (`css`, `html`, `ranges`, `stylesheets`, `traversal` and `views` are in the `oracle.jdk.jaxp` module), `org.xml.sax.**`
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
[defined in the source](https://github.com/ceylon/ceylon/blob/master/model/src/com/redhat/ceylon/model/cmr/package-list.oracle.jdk7).

## Obtaining Java `jar` dependencies

You can either install Java `jar` dependencies in your Ceylon [repositories](../../repository) manually
in order for Ceylon to find them, or you can obtain them from a 
[Maven repository](../../repository/maven). 

## See also

* [Calling Ceylon from Java](../ceylon-from-java)
* The [type mapping rules](../type-mapping)

