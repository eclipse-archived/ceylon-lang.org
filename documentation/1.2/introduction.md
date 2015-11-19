---
layout: documentation12
title: Quick introduction
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ..
---

# #{page.title}

It's impossible to get to the essence of a programming language by looking
at a list of its features. What really _makes_ the language is how all the
little bits work together. And that's impossible to appreciate without 
actually writing code. In this section we're going to try to quickly show 
you enough of Ceylon to get you interested enough to actually try it out.
This is _not_ a comprehensive feature list!

## Support for Java and JavaScript virtual machines

Write your code in Ceylon, and have it run on the JVM, on Node.js, or in a 
web browser. Some modules are platform-dependent, but the language itself
is equally at home on Java and JavaScript virtual machines.

Ceylon modules may be deployed on Ceylon's own JVM-based module runtime,
on any OSGi container, on the 
[Node.js module system](http://nodejs.org/api/modules.html), on 
[Vert.x](http://vertx.io/core_manual_ceylon.html#vertx-for-ceylon), or in 
a browser using [require.js](http://requirejs.org/).

When cross-platform execution is not a priority, Ceylon is designed to 
[interoperate](#interoperation_with_native_java_and_javascript) 
smoothly and elegantly with native Java and JavaScript code and libraries,
and even with Maven and OSGi. Thus, Ceylon programs have access to not one
but two huge ecosystems of reusable building blocks.

## A familiar, readable syntax

Ceylon's syntax is ultimately derived from C. So if you're a C, Java, or C#
programmer, you'll immediately feel right at home. Indeed, one of the goals
of the language is for most code to be immediately readable to people who
*aren't* Ceylon programmers, and who *haven't* studied the syntax of the
language.

Here's what it looks like to define and call a simple function:

<!-- try-pre:
    class Point(x, y) { shared Float x; shared Float y; }

-->
<!-- try-post:

    print(dist);
-->
<!-- implicit-id:point: class Point() { shared Float x = 0.0; shared Float y = 0.0; } -->
<!-- cat-id:point -->
<!-- cat: void m() { -->
    function distance(Point from, Point to) {
        return ((from.x-to.x)^2 + (from.y-to.y)^2)^0.5;
    }
    
    value dist = distance(Point(0.0, 0.0), Point(2.0, 3.0));
<!-- cat: } -->

Here's how we create and iterate a sequence:

<!-- cat: void m() { -->
    String[] names = ["Tom", "Dick", "Harry"];
    for (name in names) {
        print("Hello, ``name``!");
    }
<!-- cat: } -->

If these code examples look boring to you, well, that's kinda the idea -
they're boring because you understood them immediately!

Here's a simple class:

<!-- try-post:

    value counter = Counter();
    print(counter.currentValue);
    counter.increment();
    print(counter.currentValue);
-->
    class Counter(count=0) {
        variable Integer count;
        shared Integer currentValue {
            return count;
        }
        shared void increment() {
            count++;
        }
    }

If that's a little _too_ boring, you're allowed to write it more compactly 
using fat arrows instead of brace-delimited blocks:

<!-- try-post:

    value counter = Counter();
    print(counter.currentValue);
    counter.increment();
    print(counter.currentValue);
-->
    class Counter(count=0) {
        variable Integer count;
        shared Integer currentValue => count;
        shared void increment() => count++;
    }

## Declarative syntax for treelike structures

Hierarchical structures are so common in computing that we have dedicated
languages like XML for dealing with them. But when we want to have procedural
code that interacts with hierarchical structures, the "impedence mismatch"
between XML and our programming language causes all sorts of problems. So
Ceylon has a special built-in "declarative" syntax for defining hierarchical 
structures. This is especially useful for creating user interfaces:

<!-- try: -->
    Table table = Table {
        title = "Squares";
        rows = 5;
        Border {
            padding = 2;
            weight = 1;
        };
        Column {
            heading = "x";
            width = 10;
            String content(Integer row) {
                return row.string;
            }
        },
        Column {
            heading = "x^2";
            width=10;
            String content(Integer row) {
                return (row^2).string;
            }
        }
    };

But it's much more generally useful, forming a great foundation for 
expressing everything from build scripts to test suites:

<!-- try: -->
    Suite tests = Suite {
        Test { 
            "sqrt() function";
            void run() {
                assert(sqrt(1)==1);
                assert(sqrt(4)==2);
                assert(sqrt(9)==3);
            }
        },
        Test {
            "sqr() function";
            void run() {
                assert(sqr(1)==1);
                assert(sqr(2)==4);
                assert(sqr(3)==9);
            }
        }
    };

Any framework that combines Java and XML requires special purpose-built 
tooling to achieve type-checking and authoring assistance. Ceylon frameworks
that make use of Ceylon's built-in support for expressing treelike structures
get this, and more, for free.

## Principal typing, union types, and intersection types

Ceylon's conventional-looking syntax hides a powerful type system that is 
able to express things that other static type systems simply can't. All
types in Ceylon can, at least in principle, be expressed within the type
system itself. There are no primitive types, arrays, or anything similar.
Even `Null` is a class. Even `Tuple` is a class.

The type system is based on analysis of "best" or *principal* types. For 
every expression, a unique, most specific type may be determined, without 
the need to analyze the rest of the expression in which it appears. And all 
types used internally by the compiler are *denotable* - that is, they can be 
expressed within the language itself. What this means in practice is that 
the compiler always produces errors that humans can understand, even when 
working with complex generic types. The Ceylon compiler *never* produces 
error messages involving mystifying non-denotable types like Java's 
`List<capture#3-of ?>`.

An integral part of this system of denotable principal types is first-class
support for union and intersection types. A *union type* is a type which
accepts instances of any one of a list of types:

<!-- try: -->
    Person | Organization personOrOrganization = ... ;

An *intersection type* is a type which accepts instances of all of a list
of types:

<!-- try: -->
    Printable & Sized & Persistent printableSizedPersistent = ... ;

Union and intersection types are often useful as a convenience in ordinary 
code. (Once you start using Ceylon, you'll be amazed just how often!) More 
importantly, they help make things that are complex and magical in other 
languages&mdash;especially generic type argument inference&mdash;simple and 
straightforward in Ceylon.

For example, consider the following:

<!-- try-post:

    print(stuff);
    print(joinedStuff);
-->
    value stuff = { "hello", "world", 1.0, -1 };
    value joinedStuff = concatenate({"hello", "world"}, {1.0, 2.0}, {});

The compiler automatically infers the types: 

* `Iterable<String|Float|Integer>` for `stuff`, and 
* `Sequential<String|Float>` for `joinedStuff`. 

These are the correct principal types of the expressions. We didn't need 
to explictly specify any types anywhere.

We've worked hard to keep the type system [quite simple at its core][manifesto]. 
This makes the language easier to learn, and helps control the number of 
buggy or unintuitive corner cases. And a highly regular type system also 
makes it easier to write generic code.

[manifesto]: /blog/2012/01/18/type-system-manifesto

## Mixin inheritance

Like Java, Ceylon has classes and interfaces. A class may inherit a single
superclass, and an arbitrary number of interfaces. An interface may inherit
an arbitrary number of other interfaces, but may not extend a class other
than `Object`. And interfaces can't have fields, but may define concrete 
members. Thus, Ceylon supports a restricted kind of multiple inheritance, 
called *mixin inheritance*. 

<!-- try-post:

empty.printIt();
-->
    interface Sized {
        shared formal Integer size;
        shared Boolean empty => size==0;
        string => empty then "EMPTY" else "SIZE: ``size``";
    }
    
    interface Printable {
        shared void printIt() => print(this);
    }
    
    object empty satisfies Sized & Printable {
        size => 0;
    }

What really distinguishes interfaces from classes in Ceylon is that 
interfaces are *stateless*. That is, an interface may not directly hold
a reference to another object, it may not have initialization logic, and
it may not be directly instantiated. Thus, Ceylon neatly avoids the need 
to perform any kind of "linearization" of supertypes.

## Polymorphic attributes

Ceylon doesn't have fields, at least not in the traditional sense.
Instead, *attributes* are polymorphic, and may be refined by a subclass, 
just like methods in other object-oriented languages. 

An attribute might be a reference to an object:

<!-- try-pre:
    String firstName = "John";
    String lastName = "Doe";

-->
<!-- try-post:

    print(name);
-->
<!-- cat: String firstName = "John"; -->
<!-- cat: String lastName = "Doe"; -->
    String name = firstName + " " + lastName;

It might be a getter:

<!-- try-pre:
    String firstName = "John";
    String lastName = "Doe";

-->
<!-- try-post:

    print(name);
-->
<!-- cat: String firstName = "John"; -->
<!-- cat: String lastName = "Doe"; -->
    String name {
        return firstName + " " + lastName;
    }

Or it might be a getter/setter pair:

<!-- try-pre:
    variable String fullName = "John Doe";

-->
<!-- try-post:

    print(name);
    name = "Pietje Pluk";
    print(name);
-->
<!-- cat: variable String fullName = "John Doe"; -->
    String name {
        return fullName;
    }
    
    assign name {
        fullName = name;
    }

In Ceylon, we don't need to write trival getters or setters which merely 
mediate access to a field. The state of a class is always 
[completely abstracted](../tour/classes/#abstracting_state_using_attributes) 
from clients of the class: we can change a reference attribute to a 
getter/setter pair without breaking clients.

## Typesafe null and flow-sensitive typing

There's no `NullPointerException` in Ceylon, nor anything similar. Ceylon
requires us to be explicit when we declare a value that might be null, or
a function that might return null. For example, if `name` might be null, 
we must declare it like this:

<!-- try: -->
    String? name = ...

Which is actually just an abbreviation for:

<!-- try: -->
    String | Null name = ...

An attribute of type `String?` might refer:

- to an actual string, the `String` half of the union type, or 
- the value `null`, the only instance of the class `Null`.
 
So Ceylon won't let us do anything useful with a value of type `String?` 
without first checking that it isn't null using the special `if (exists ...)` 
construct.

<!-- try-post:

    hello(null);
    hello("John Doe");
-->
    void hello(String? name) {
        if (exists name) {
            //name is of type String here
            print("Hello, ``name``!");
        }
        else {
            print("Hello, world!");
        }
    }

Similarly, there's no `ClassCastException` in Ceylon. Instead, the 
`if (is ...)` and `case (is ...)` constructs test and narrow the type of
a value in a single step. Indeed, the code above is really just a clearer
way of writing the following:

<!-- try-post:

    hello(null);
    hello("John Doe");
-->
    void hello(String? name) {
        if (is String name) {
            //name is of type String here
            print("Hello, ``name``!");
        }
        else {
            print("Hello, world!");
        }
    }

The ability to narrow the type of a value using conditions like `is` and
`exists` is called _flow-sensitive typing_. Another scenario where 
flow-sensitive typing comes into play is assertions:

<!-- try: -->
    if ('/' in string) {
        value bits = string.split('/'.equals); // bits has type {String+}
        value first = bits.first;              // so first is not null
        value second = bits.rest.first;        // but second _could_ be null
        //assert that second is in 
        //fact _not_ null, since we happen to
        //know that the string contains a /
        assert (exists second);
        value firstLength = first.size;   //first is not null
        value secondLength = second.size; //second is not null
        ...
    }

## Enumerated subtypes

In object-oriented programming, it's usually considered bad practice to 
write long `switch` statements that handle all subtypes of a type. It 
makes the code less extensible. Adding a new subtype to the system causes 
the `switch` statements to break. So in object-oriented code, we usually 
try to refactor constructs like this to use an abstract method of the 
supertype that is refined as appropriate by subtypes.

However, there's a class of problems where this kind of refactoring isn't 
appropriate. In most object-oriented languages, these problems are usually 
solved using the "visitor" pattern. Unfortunately, a visitor class actually 
winds up more verbose than a `switch`, and no more extensible. There is, on
the other hand, one major advantage of the visitor pattern: the compiler 
produces an error if we add a new subtype and forget to handle it in one
of our visitors.

Ceylon gives us the best of both worlds. We can specify an *enumerated list
of subtypes* when we define a supertype:

<!-- try: -->
    abstract class Node() of Leaf | Branch {}

And we can write a `switch` statement that handles all the enumerated subtypes:

<!-- try:
    abstract class Node() of Leaf | Branch {}
    class Leaf() extends Node() {}
    class Branch() extends Node() {}

    Node node = Leaf() ;
    switch (node)
    case (is Leaf) { print("Leaf"); }
    case (is Branch) { print("Branch"); }
-->
    Node node = ... ;
    switch (node)
    case (is Leaf) { 
        //node is of type Leaf here
        print(node.leafValue); 
    }
    case (is Branch) {
        //node is of type Branch here
        doSomething(node.leftNode);
        doSomething(node.rightNode);
    }

Now, if we were to add a new subtype of `Node`, we would be forced to add the 
new subtype to the `of` clause of the declaration of `Node`, and the compiler 
would produce an error at every `switch` statement which doesn't handle the 
new subtype.

## Type aliases and type inference

Fully-explicit type declarations very often make difficult code much easier to
understand, and they're an invaluable aid to understanding the API of a library 
or framework. But there are plenty of occasions where the repetition of a verbose
generic type just detracts from the readability of the code. We've observed that:

1. explicit type annotations are of much less value for local declarations, and
2. repetition of a parameterized type with the same type arguments is common
   and extremely noisy in Java.

Ceylon addresses the first problem by allowing type inference for local 
declarations. For example:

<!-- try: -->
    value names = LinkedList { "Tom", "Dick", "Harry" };

<br/>

<!-- try: -->
    function sqrt(Float x) => x^0.5;

<br/>    

<!-- try: -->
    for (item in order.items) { ... }

On the other hand, for declarations which are accessible outside the compilation 
unit in which they are defined, Ceylon requires an explicit type annotation. We 
think this makes the code more readable, not less, and it makes the compiler more 
efficient and less vulnerable to stack overflows.

Type inference works somewhat better in Ceylon than in other languages with 
subtyping, because Ceylon has union and intersection types. Consider a map with 
a heterogeneous key type:

<!-- try: -->
    value numbers = HashMap { "one"->1.0, "zero"->0.0, 1->1.0, 0->0.0 };

The inferred type of `numbers` is `HashMap<String|Integer,Float>`.

Ceylon addresses the second problem via *type aliases*, which are very similar
to a `typedef` in C. A type alias can act as an abbreviation for a generic type
together with its type arguments:

<!-- try: -->
    interface Strings => List<String>;

We encourage the use of both these language features where - *and only where* -
they make the code more readable.

## Higher-order functions

Like most programming languages, Ceylon lets you pass a function to another 
function. 

A function which operates on other functions is called a *higher-order function*. 
For example:

<!-- try: -->
<!-- id:repeat -->
    void repeat(Integer times, 
            void iterate(Integer i)) {
        for (i in 1..times) {
            iterate(i);
        }
    } 

When invoking a higher-order function, we can either pass a reference to a named 
function:

<!-- try-pre:
    void repeat(Integer times, 
            void iterate(Integer i)) {
        for (i in 1..times) {
            iterate(i);
        }
    } 

-->
<!-- cat-id:repeat -->
<!-- cat: void m() { -->
    void printSqr(Integer i) {
        print(i^2);
    }
    
    repeat(5, printSqr);
<!-- cat: } -->

Or we can specify the argument function inline, either like this:

<!-- try-pre:
    void repeat(Integer times, 
            void iterate(Integer i)) {
        for (i in 1..times) {
            iterate(i);
        }
    } 

-->
<!-- cat-id:repeat -->
<!-- cat: void m() { -->
    repeat(5, (i) => print(i^2));
<!-- cat: } -->

Or, using a named argument invocation, like this:

<!-- try-pre:
    void repeat(Integer times, 
            void iterate(Integer i)) {
        for (i in 1..times) {
            iterate(i);
        }
    } 

-->
<!-- cat-id:repeat -->
<!-- cat: void m() { -->
    repeat {
        times = 5;
        void iterate(Integer i) {
            print(i^2);
        }
    };
<!-- cat: } -->

It's even possible to pass a member method or attribute reference to a 
higher-order function:

<!-- try: -->
    value names = { "Gavin", "Stef", "Tom", "Tako" };
    value uppercaseNames = names.map(String.uppercased);

Unlike other statically-typed languages with higher-order functions, Ceylon
has a single function type, the interface `Callable`. There's no need to
adapt a function to a single-method interface type, nor is there a menagerie
of function types `F`, `F1`, `F2`, etc, with some arbitrary limit of 24 
parameters or whatever. Nor are Ceylon's function types defined primitively. 

Instead, `Callable` accepts a tuple type argument that captures the parameter 
types of the function. Of course, there's also a single class `Tuple` that 
abstracts over all tuple types! This means that it's possible to write 
higher-order functions that abstract over functions with parameter lists of 
differing lengths.

## Tuples

A _tuple_ is a kind of linked list, where the static type of the list 
encodes the static type of each element of the list, for example:

<!-- try: -->
    [Float,Float,Float,String] origin = [0.0, 0.0, 0.0, "origin"];

We can access the elements of the list without needing to typecast:

<!-- try: -->
    [Float,Float,Float,String] xyzWithLabel = ... ;
    
    [Float,Float] xy = [xyzWithLabel[0], xyzWithLabel[1]];
    String label = xyzWithLabel[3];

Tuples are useful as a convenience, and they really come into play if you
want to take advantage of Ceylon's support for typesafe metaprogramming. For
example, you can take a tuple, and "spread" it across the parameters of a
function.

Suppose we have a nice function for formatting dates:

<!-- try: -->
    String formatDate(String format, 
                      Integer day, 
                      Integer|String month, 
                      Integer year) { ... }

And we have a date, held in a tuple:

<!-- try: -->
    [Integer,String,Integer] date = [25, "March", 2013];

Then we can print the date like this:

<!-- try: -->
    print(formatDate("dd MMMMM yyyy", *date));

Of course, Ceylon's support for tuples is just some syntax sugar over the
perfectly ordinary generic class `Tuple`.

## Comprehensions

Filtering and transforming streams of values is one of the main things 
computers are good at. Therefore, Ceylon provides a special syntax which makes 
these operations especially convenient. Anywhere you could provide a list of 
expressions (for example, a sequence instantiation, or a "vararg"), Ceylon 
lets you write a comprehension instead. For example, the following expression 
instantiates a sequence of names:

<!-- try: -->
    [ for (p in people) p.firstName + " " + p.lastName ]

This expression gives us a sequence of adults:

<!-- try: -->
    [ for (p in people) if (p.age>=18) p ]

This expression produces a `Map` of name to `Person`:

<!-- try: -->
    HashMap { for (p in people) p.firstName + " " + p.lastName -> p }

This expression creates a set of employers:

<!-- try: -->
    HashSet { for (p in people) for (j in p.jobs) j.organization }

Here, we're using a comprehension as a function argument to format and print 
the names:

<!-- try: -->
    print(", ".join { for (p in people) p.firstName + " " + p.lastName });

## Simplified generics with fully-reified types

Ceylon's type system is more powerful than Java's, but it's also simpler. 
The Ceylon compiler never even uses any kind of "non-denotable" type to reason 
about your code. And there's no wildcard capture, implicit constraints on type 
arguments, nor "raw" types. Compared to other languages, generics-related error 
messages are much more understandable to humans.

Furthermore, Ceylon's type system is _fully reified_ at runtime. In particular, 
generic type arguments are reified, eliminating many frustrations that result 
from type argument erasure in Java. For example, Ceylon lets us write 
`if (is Map<String,Object> map)`.

Finally, there's a cleaner, more regular syntax for generic type constraints. 
The syntax for declaring type constraints on a type parameter looks very similar
to a class or interface declaration.

<!-- try: -->
    shared Value sum<Value>({Value+} values) 
            given Value satisfies Summable<Value> { ... }

## Declaration-site and use-site variance

Ceylon supports two approaches to _variance_ of generic types:

- *declaration-site variance*, which is used throughout the Ceylon language module 
  and SDK, and is considered the idiomatic approach, and
- *use-site variance*, which is used mainly for interoperating with Java's generic
  types.

With use-site variance, a type _argument_ is marked covariant (`out`) or 
contravariant (`in`). Thus, this type is contravariant in its first argument,
and covariant in its second argument:

<!-- try: -->
    Map<in String, out Number<out Anything>>

(In Java, this type would be written `Map<? super String, ? extends Number<? extends Object>>`.)

With declaration-site variance, the system we strongly prefer in Ceylon, a 
type _parameter_ may be marked as covariant or contravariant by the class or 
interface that declares the type parameter. Consider:

<!-- try: -->
    shared interface Dictionary<in Key, out Item> {
         shared formal Item? get(Key key);
    }

Given this declaration of `Dictionary`:

- a `Dictionary<String,Integer>` is also a `Dictionary<String,Object>`, since `get()` 
  produces an `Integer`, which is also an `Object`, and 
- a `Dictionary<List<Character>,Integer>` is also a `Dictionary<String,Integer>`, 
  since `get()` accepts any key which is an `List<Character>`, and every `String` 
  is a `List<Character>`.

So code which uses the `Dictionary` interface doesn't have to worry about variance. 

## Operator polymorphism

Ceylon features a rich set of operators, including most of the operators supported 
by C and Java. True operator overloading is not supported. Sorry, you can't define 
the pope operator `<+|:-)` in Ceylon. And you can't redefine `*` to mean something 
that has nothing to do with numeric multiplication. However, each operator predefined 
by the language is defined to act upon a certain class or interface type, allowing 
application of the operator to any class which extends or satisfies that type. We 
call this approach *operator polymorphism*.

For example, the Ceylon language module defines the interface `Summable`.

<!-- try: -->
    shared interface Summable<Other> of Other
            given Other satisfies Summable<Other> {
        shared formal Other plus(Other that);
    }

And the `+` operation is defined for values which are assignable to `Summable`.
The following expression:

<!-- try: -->
    x+y

Is merely an abbreviation of:

<!-- try: -->
    x.plus(y)

Likewise, `<` is defined in terms of the interface `Comparable`, `*` in terms of
the interface `Numeric`, and so on.

## Typesafe metaprogramming and annotations

Ceylon provides sophisticated support for meta-programming, including a unique
typesafe metamodel. Generic code may invoke members reflectively without the
need for unsafe typecasts and string passing.

<!-- try: -->
    Class<Person,[Name]> personClass = `Person`;
    Person gavin = personClass(Name("Gavin", "King"));

Ceylon supports program element annotations, with a streamlined syntax. Indeed,
annotations are even used for language modifiers like `abstract` and `shared` -
which are not keywords in Ceylon - and for embedding API documentation for the 
documentation compiler:

<!-- try: -->
    "The user login action"
    by ("Trompon the Elephant")
    throws (`class DatabaseException`,
            "if database access fails")
    see (`function LogoutAction.logout`)
    scope (session)
    action { description="Log In"; url="/login"; }
    shared deprecated
    void login(Request request, Response response) {
        ...
    }

Well, that was a bit of an extreme example!

## Modularity

Ceylon features language-level package and module constructs, along with language-level 
access control via the `shared` annotation which can be used to express block-local, 
package-private, module-private, and public visibility for program elements. There's 
no equivalent to Java's `protected`. Dependencies between modules are specified in
the module descriptor:

<!-- try: -->
    "This module is just a silly example. You'll 
     find some proper modules in the community 
     repository [Ceylon Herd][Herd].
     
     [Herd]: http://modules.ceylon-lang.org
     
     Happy Herding!"
    module org.jboss.example "1.0.0" {         
        import ceylon.math "1.1.0";
        import ceylon.file "1.1.1";
    }

For execution on the Java Virtual Machine, the Ceylon compiler directly produces 
`.car` module archives in module repositories. You're never exposed to unpackaged 
`.class` files. The `.car` archives come with built-in metadata for the Ceylon 
module runtime, for OSGi containers, and for Maven.

At runtime, modules are loaded according to a peer-to-peer classloader architecture,
based upon the same module runtime that is used at the very core of JBoss AS 7.
Alternatively, Ceylon modules are compatible with OSGi, and with Vert.x.

For execution on JavaScript Virtual Machines, the Ceylon compiler produces CommonJS
modules, which are compatible with `node.js` and `require.js`.

[Ceylon Herd](http://modules.ceylon-lang.org) is a community module repository for
sharing open source modules.

## Interoperation with native Java and JavaScript

Code written in Ceylon interoperates elegantly with native code written for the 
platform. For example, we can make use of Java's collections, which are exposed 
to Ceylon code in the module `java.base`:

<!-- try: -->
    import java.util { HashMap }
    
    value javaHashMap = HashMap<String,Integer>();
    javaHashMap.put("zero", 0);
    javaHashMap.put("one", 1);
    javaHashMap.put("two", 2);
    print(javaHashMap.values());

Notice that basic types like `String` and `Integer` may be passed completely
transparently between the two languages. 

We can even call untyped native JavaScript APIs, inside a `dynamic` block:

<!-- try: -->
    dynamic {
        dynamic req = XMLHttpRequest();
        req.onreadystatechange = void () {
            if (req.readyState==4) {
                document.getElementById("greeting")
                        .innerHTML = req.status==200
                                then req.responseText
                                else "error";
            }
        };
        req.open("GET", "/sayHello", true);
        req.send();
    }

Try it!

    dynamic { alert("Hello, World!"); }

It's even possible for a cross-platform module to interoperate with native
Java _and_ JavaScript code, via use of the `native` annotation.

<!-- try: -->
    native void hello();
    
    native("jvm") void hello()
        => System.out.println("hello");
    
    native("js") void hello() {
        dynamic {
            console.log("hello");
        }
    }

## A real specification

The Ceylon language is defined by an exhaustive, but highly readable,
160-page [specification](../spec). The specification predates the compiler,
and functions as its foundation.

## Take the Tour

We're done with the introduction. Take the [tour of Ceylon](#{page.doc_root}/tour) 
for a full in-depth tutorial.
