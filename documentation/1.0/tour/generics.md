---
layout: tour
title: Tour of Ceylon&#58; Generics
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the eight part of the Tour of Ceylon. The [previous leg](../types)
covered intersection types, union types, and enumerated types. In this part 
we're looking at *generic* types. 

[Inheritance and subtyping](../inheritance) are a powerful tool for abstracting 
over types. But this tool has its limitations. It can't help us express generic 
container types like collections. For this problem we need parameterized types. 
We've seen plenty of parameterized types already&mdash;for example, 
[sequences](../sequences)&mdash;but now let's explore a few more details.


## Defining generic types

Programming with generic types is one of the most difficult parts of Java. 
That's still true, to some extent, in Ceylon. But because the Ceylon language 
and SDK were designed for generics from the ground up, Ceylon is able to 
alleviate the most painful aspects of Java's bolted-on-later model.

Just like in Java, only types and methods may declare type parameters. Also 
just like in Java, type parameters are listed before ordinary parameters, 
enclosed in angle brackets.

<!-- try: -->
<!-- check:none -->
    shared interface Iterator<out Element> { ... }

    class Array<Element>(Element* elements) 
            satisfies Sequence<Element> { ... }

    shared Entries<Integer,Element> entries<Element>(Element* sequence) { ... }

As you can see, the convention in Ceylon is to use meaningful names for 
type parameters (in Java the convention is to use single letter names).

Unlike Java, we always do need to specify type arguments in a type declaration 
(there are no _raw types_ in Ceylon). The following will not compile:

<!-- try:
    Iterable it = {};   //error: missing type argument to parameter Element of Iterable
-->
<!-- check:none:Demoing error -->
    Iterable it = ...;   //error: missing type argument to parameter Element of Iterable

We always have to specify a type argument in a type declaration:

<!-- try:
    Iterable<String> it = {};
-->
<!-- check:none -->
    Iterable<String> it = ...;

On the other hand, we don't need to explicitly specify type arguments in most 
method invocations or class instantiations. We don't usually need to write:

<!-- check:none -->
    Array<String> strings = array<String>("Hello", "World"); 
    Iterable<Entry<Integer,String>> things = entries<String>(strings);

Instead, it's very often possible to infer the type arguments from the ordinary 
arguments.

<!-- check:none -->
    value strings = array("Hello", "World"); // type Array<String>
    value things = entries(strings); // type Iterable<Entry<Integer,String>>

The generic type argument inference algorithm is slightly involved, so you
should refer to the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#typeargumentinference) 
for a complete definition. But essentially what happens is that Ceylon 
infers a type argument by combining the types of corresponding arguments 
using union in the case of a covariant type parameter, or intersection
in the case of a contravariant type parameter.

<!--try:
    class Polar(Float angle, Float radius) { }
    class Cartesian(Float x, Float y) { }

    value points = array(Polar(0.7854, 0.5), Cartesian(-1.0, 2.5)); // type Array<Polar|Cartesian>
    value things = entries(points...); // type Iterable<Entry<Integer,Polar|Cartesian>>
-->
<!-- check:none -->
    value points = Array(Polar(pi/4, 0.5), Cartesian(-1.0, 2.5)); // type Array<Polar|Cartesian>
    value entries = entries(points); // type Entries<Integer,Polar|Cartesian>

Finally, Ceylon eliminates one of the bits of Java generics that's really 
hard to get your head around: wildcard types. Wildcard types were Java's 
solution to the problem of *covariance* in a generic type system. Let's first 
meet the idea of covariance, and then see how covariance works in Ceylon.


## Covariance and contravariance

It all starts with the intuitive expectation that a collection of `Geeks` is a 
collection of `Persons`. That's a reasonable intuition, but especially in 
non-functional languages, where collections can be mutable, it turns out to be 
incorrect. Consider the following possible definition of `Collection`:

<!-- check:none -->
    interface Collection<Element> {
        shared formal Iterator<Element> iterator();
        shared formal void add(Element x);
    }

And let's suppose that `Geek` is a subtype of `Person`. Reasonable.

The intuitive expectation is that the following code should work:

<!-- try: -->
<!-- check:none -->
    Collection<Geek> geeks = ... ;
    Collection<Person> people = geeks;    //compiler error
    for (person in people) { ... }

This code is, frankly, perfectly reasonable taken at face value. Yet in both 
Java and Ceylon, this code results in a compile-time error at the second line, 
where the `Collection<Geek>` is assigned to a `Collection<Person>`. Why? 
Well, because if we let the assignment through, the following code would also 
compile:

<!-- try: -->
<!-- check:none -->
    Collection<Geek> geeks = ... ;
    Collection<Person> people = geeks;    //compiler error
    people.add( Person("Fonzie") );

We can't let that code by — Fonzie isn't a `Geek`!

Using big words, we say that `Collection` is *invariant* in `Element`. Or, 
when we're not trying to impress people with opaque terminology, we say that 
`Collection` both produces — via the `iterator()` method — and consumes — 
via the `add()` method — the type `Element`.

Here's where Java goes off and dives down a rabbit hole, successfully using 
wildcards to wrangle a covariant or contravariant type out of an invariant 
type, but also succeeding in thoroughly confusing everybody. We're not going 
to follow Java down the hole.

Instead, we're going to refactor `Collection` into a pure producer interface 
and a pure consumer interface:

<!-- check:none -->
    interface Producer<out Output> {
        shared formal Iterator<Output> iterator();
    }
    interface Consumer<in Input> {
        shared formal void add(Input x);
    }

Notice that we've annotated the type parameters of these interfaces.

* The `out` annotation specifies that `Producer` is covariant in `Output`; 
  that it produces instances of `Output`, but never consumes instances of `Output`.
* The `in` annotation specifies that `Consumer` is contravariant in `Input`; 
  that it consumes instances of `Input`, but never produces instances of `Input`.

The Ceylon compiler validates the schema of the type declaration to ensure 
that the variance annotations are satisfied. If you try to declare an `add()` 
method on `Producer`, a compilation error results. If you try to declare an 
`iterate()` method on `Consumer`, you get a similar compilation error.

Now, let's see what that buys us:

* Since `Producer` is covariant in its type parameter `Output`, and since 
  `Geek` is a subtype of `Person`, Ceylon lets you assign `Producer<Geek>` to 
  `Producer<Person>`.
* Furthermore, since `Consumer` is contravariant in its type parameter `Input`, 
  and since `Geek` is a subtype of `Person`, Ceylon lets you assign 
  `Consumer<Person>` to `Consumer<Geek>`.

We can define our `Collection` interface as a mixin of `Producer` with `Consumer`.

<!-- try-pre:
    interface Producer<out Output> {
        shared formal Iterator<Output> iterator();
    }
    interface Consumer<in Input> {
        shared formal void add(Input x);
    }

-->
<!-- check:none -->
    interface Collection<Element>
            satisfies Producer<Element> & Consumer<Element> {}

Notice that `Collection` remains invariant in `Element`. If we tried to add a 
variance annotation to `Element` in `Collection`, a compile time error would 
result, because the annotation would contradict the variance annotation of 
either `Producer` or `Consumer`.

Now, the following code finally compiles:

<!-- try: -->
<!-- check:none -->
    Collection<Geek> geeks = ... ;
    Producer<Person> people = geeks;
    for (person in people) { ... }

Which matches our original intuition.

The following code also compiles:

<!-- try: -->
<!-- check:none -->
    Collection<Person> people = ... ;
    Consumer<Geek> geekConsumer = people;
    geekConsumer.add( Geek("James") );

Which is also intuitively correct — `James` is most certainly a `Person`!

There's two additional things that follow from the definition of covariance 
and contravariance:

* `Producer<Anything>` is a supertype of `Producer<T>` for any type `T`, and
* `Consumer<Nothing>` is a supertype of `Consumer<T>` for any type `T`.

These invariants can be very helpful if you need to abstract over all 
`Producers` or all `Consumers`. (Note, however, that if `Producer` declared 
upper bound type constraints on `Output`, then `Producer<Anything>` would not 
be a legal type.)

You're unlikely to spend much time writing your own collection classes, since 
the Ceylon SDK will soon have a powerful collections framework built in. But 
you'll still appreciate Ceylon's approach to covariance as a user of the 
built-in collection types.


## Generics and inheritance

Consider the following classes:

<!-- try: -->
    class LinkedList() 
            satisfies List<Object> { ... }
    
    class LinkedStringList() 
            extends LinkedList() 
            satisfies List<String> { ... }

This kind of inheritance is illegal in Java. A class can't inherit the
same type more than once, with different type arguments. We say that 
Java supports only _single instantiation inheritance_.

Ceylon is less restrictive here. The above code is perfectly legal if
(and only if) the interface `List<Element>` is covariant in its type
parameter `Element`, that is, if it's declared like this:

<!-- try:
    interface List<out Element> { }

    class LinkedList() 
            satisfies List<Object> { }
    
    class LinkedStringList() 
            extends LinkedList() 
            satisfies List<String> { }

-->
    interface List<out Element> { ... }

We say that Ceylon supports _principal instantiation inheritance_. 
Even the following code is legal:

<!-- try: -->
    interface ListOfSomething satisfies List<Something> {}
    interface ListOfSomethingElse satisfies List<SomethingElse> {}
    class MyList() satisfies ListOfSomething & ListOfSomethingElse { ... }

Then the following is legal and well-typed:

<!-- try-pre:
    interface Something {}
    interface SomethingElse {}
    interface List<out Element> { }
    interface ListOfSomething satisfies List<Something> {}
    interface ListOfSomethingElse satisfies List<SomethingElse> {}
    class MyList() satisfies ListOfSomething & ListOfSomethingElse {}

-->
    List<Something&SomethingElse> list = MyList();

Please pause here, and take the  time to notice how ridiculously 
awesome this is. We never actually explicitly mentioned that 
`MyList()` was a `List<Something&SomethingElse>`. The compiler just 
figured it out for us.

Note that when you inherit the same type more than once, you might
need to refine some of its members, in order to satisfy all inherited 
signatures. Don't worry, the compiler will notice and force you to do 
it.


## Generic type constraints

Very commonly, when we write a parameterized type, we want to be able to 
invoke methods or evaluate attributes upon instances of the type parameter. 
For example, if we were writing a parameterized type `Set<Element>`, we would 
need to be able to compare instances of `Element` using `==` to see if a 
certain instance of `Element` is contained in the `Set`. Since `==` is 
defined for expressions of type 
[`Object`](#{site.urls.apidoc_current}/ceylon/language/class_Object.html),
we need some way to assert that `Element` is a subtype of `Object`. This is 
an example of a *type constraint* — in fact, it's an example of the most 
common kind of type constraint, an *upper bound*.

<!-- try: -->
<!-- check:none -->
    shared class Set<out Element>(Element* elements)
            given Element satisfies Object {
        ...
     
        shared Boolean contains(Object obj) {
            if (is Element obj) {
                return obj in bucket(obj.hash);
            }
            else {
                return false;
            }
        }
     
    }

A type argument to `Element` must be a subtype of `Object`.

<!-- try-pre:
    class Set<out Element>(Element... elements)
            given Element satisfies Object { }

-->
<!-- check:none: Demos error -->
    Set<String> set1 = Set("C", "Java", "Ceylon"); //ok
    Set<String?> set2 = Set("C", "Java", "Ceylon", null); //compile error

In Ceylon, a generic type parameter is considered a proper type, so a type 
constraint looks a lot like a class or interface declaration. This is 
another way in which Ceylon is more regular than some other C-like languages.

Future versions of Ceylon, after the 1.0 release, will almost certainly
introduce support for several additional kinds of generic type constraint.
You can find out more details in the [language specification](../../spec).

<!--
An upper bound lets us call methods and attributes of the bound, but it 
doesn't let us instantiate new instances of `Element`. Once we implement 
reified generics, we'll be able to add a new kind of type constraint to 
Ceylon. An *initialization parameter specification* lets us actually 
instantiate the type parameter.
-->

<!-- check:none:Parameter bounds not yet supported --><!--
    shared class Factory<out Result>()
            given Result(String s) {
     
        shared Result produce(String string) {
            return Result(string);
        }
     
    }

A type argument to `Result` of `Factory` must be a class with a single 
initialization parameter of type 
[`String`](#{site.urls.apidoc_current}/ceylon/language/class_String.html).

A second kind of type constraint is an *enumerated type bound*, which 
constrains the type argument to be one of an enumerated list of types. 
It lets us write an exhaustive switch on the type parameter:
-->
<!-- check:none:Requires ceylon.math --><!--
    Value sqrt<Value>(Value x)
            given Value of Float | Decimal {
        switch (Value)
        case (satisfies Float) {
            return sqrtFloat(x);
        }
        case (satisfies Decimal) {
            return sqrtDecimal(x);
        }
    }

This is one of the workarounds we [mentioned earlier](../classes/#living_without_overloading) 
for Ceylon's lack of overloading.

Finally, the fourth kind of type constraint, which is much less common, and 
which most people find much more confusing, is a *lower bound*. A lower 
bound is the opposite of an upper bound. It says that a type parameter is 
a *supertype* of some other type. There's only really one situation where 
this is useful. Consider adding a `union()` operation to our `Set` interface. 
We might try the following:
-->
<!-- check:none --><!--
    shared class Set<out Element>(Element... elements)
            given Element satisfies Object {
        ...
         
        shared Set<Element> union(Set<Element> set) {   //compile error
            return ....
        }
         
    }

This doesn't compile because we can't use the covariant type parameter `T` 
in the type declaration of a method parameter. The following declaration 
would compile:
-->
<!-- check:none --><!--
    shared class Set<out Element>(Element... elements)
            given Element satisfies Object {
        ...
         
        shared Set<Object> union(Set<Object> set) {
            return ....
        }
         
    }

But, unfortunately, we get back a `Set<Object>` no matter what kind of 
set we pass in. A lower bound is the solution to our dilemma:
-->
<!-- check:none --><!--
    shared class Set<out Element>(Element... elements)
            given Element satisfies Object {
        ...
         
        shared Set<UnionElement> union(Set<UnionElement> set)
                given UnionElement abstracts Element {
            return ...
        }
         
    }

With type inference, the compiler chooses an appropriate type argument to 
`UnionElement` for the given argument to `union()`:
-->
<!-- check:none --><!--
    Set<String> strings = Set("abc", "xyz") ;
    Set<String> moreStrings = Set("foo", "bar", "baz");
    Set<String> allTheStrings = strings.union(moreStrings);
    Set<Decimal> decimals = Set(1.2.decimal, 3.67.decimal) ;
    Set<Float> floats = Set(0.33, 22.0, 6.4);
    Set<Number> allTheNumbers = decimals.union(floats);
    Set<Point> points = Set( Polar(pi,3.5), Cartesian(1.0, -2.0) );
    Set<Object> objects = Set("Gavin", 12, true);
    Set<Object> allTheObjects = points.union(objects);
-->

## Fully reified generic types

The root cause of very many problems when working with generic types in 
Java is *type erasure*. Generic type parameters and arguments are discarded 
by the compiler, and simply aren't available at runtime. So the following, 
perfectly sensible, code fragments just wouldn't compile in Java:

<!-- try: -->
<!-- check:none -->
    if (is List<Person> list) { ... }
    if (is Element obj) { ... }

(Where `Element` is a generic type parameter.)

Ceylon's type system has *reified generic type arguments*. Like Java, the 
Ceylon compiler performs erasure, discarding type parameters from the 
schema of the generic type. But unlike Java, type arguments are _reified_ 
(available at runtime). Of course, generic type arguments won't be checked 
for typesafety by the underlying virtual machine at runtime, but type 
arguments are at least available at runtime to code that wants to make use 
of them explicitly. So the code fragments above are supposed to compile and 
function as expected. You will even be able to use reflection to discover the 
type arguments of an instance of a generic type.

## There's more...

Now we're ready to look at a really important feature of the language: 
[modularity](../modules).

