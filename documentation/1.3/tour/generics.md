---
layout: tour13
title: Generics
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the ninth part of the Tour of Ceylon. The [previous leg](../types)
covered intersection types, union types, and enumerated types. In this part 
we're looking at *generic* types. 

[Inheritance and subtyping](../inheritance) are a powerful tool for abstracting 
over types. But this tool has its limitations. It can't help us express generic 
container types like collections. For this problem we need parameterized types. 
We've seen plenty of parameterized types already&mdash;for example, 
[iterables, sequences, and tuples](../sequences)&mdash;but now let's explore a 
few more details.

## Generic types

Programming with generic types is one of the most difficult parts of Java. 
That's still true, to some extent, in Ceylon. But because the Ceylon language 
and SDK were designed for generics from the ground up, Ceylon is able to 
alleviate the most painful aspects of Java's bolted-on-later model.

There are two kinds of things which may be generic:

- a class, interface, or type alias, or
- a function.

### Type parameters

Just like in Java, only types and methods may declare type parameters. Also 
just like in Java, type parameters are listed before ordinary parameters, 
enclosed in angle brackets.

<!-- try: -->
    shared interface Iterator<out Element> { ... }

<br/>

<!-- try: -->
    shared class Singleton<out Element>(Element element)
            extends Object()
            satisfies [Element+]
            given Element satisfies Object { ... }

<br/>

<!-- try: -->
    shared Value sum<Value>({Value+} values) 
            given Value satisfies Summable<Value> { ... }

<br/>

<!-- try: -->
    shared <Key->Item>[] zip<Key,Item>({Key*} keys, {Item*} items)
            given Key satisfies Object
            given Item satisfies Object { ... }

As you can see, the convention in Ceylon is to use meaningful names for type 
parameters (in other languages the usual convention is to use single letter 
names).

### Type arguments

Unlike Java, we always do need to specify type arguments in a type declaration 
(there are no _raw types_ in Ceylon). The following will not compile:

    value strings = {"hello", "world"};
    Iterator it = strings.iterator();   //error: missing type argument to parameter Element of Iterable

Instead, we have to provide a type argument like this:

    value strings = {"hello", "world"};
    Iterator<String> it = strings.iterator();

On the other hand, it would be very annoying if we always had to specify all
type arguments explicitly everywhere.

### Type argument inference 

Fortunately, we don't need to explicitly specify type arguments in most method 
invocations or class instantiations. We don't usually need to write:

<!-- check:none -->
    Array<String> strings = Array<String> { "Hello", "World" };
    {String|Integer*} things = interleave<String|Integer,Null>(strings, 0..2);

Instead, it's very often possible to infer the type arguments from the ordinary 
arguments.

<!-- check:none -->
    value strings = Array { "Hello", "World" }; // type Array<String>
    value things = interleave(strings, 0..2); // type {String|Integer*}

The generic type argument inference algorithm is slightly involved, so you
should refer to the [language specification][type argument inference] 
for a complete definition. But essentially what happens is that Ceylon 
infers a type argument by combining the types of corresponding arguments 
using union in the case of a covariant type parameter, or intersection
in the case of a contravariant type parameter.

<!--try:
    class Polar(Float angle, Float radius) { }
    class Cartesian(Float x, Float y) { }

    value points = Array { Polar(0.7854, 0.5), Cartesian(-1.0, 2.5) }; // type Array<Polar|Cartesian>
    value things = zipEntries(1..points.size, points); // type {<Integer->Polar|Cartesian>*}
-->
<!-- check:none -->
    value points = Array { Polar(pi/4, 0.5), Cartesian(-1.0, 2.5) }; // type Array<Polar|Cartesian>
    value entries = zipEntries(1..points.size, points); // type {<Integer->Polar|Cartesian>*}

There's one more way to avoid having to write in type arguments explicitly.

[type argument inference]: #{site.urls.spec_current}#typeargumentinference

### Default type arguments

A type parameter may have a default argument.

<!-- try: -->
    shared interface Iterable<out Element, out Absent=Null> ...

If a type parameter has a default argument, we're allowed to leave out the
type argument to that type parameter when we supply a type argument list.
Therefore:

- `Iterable<String>` means `Iterable<String,Null>`, and
- `Iterable<>` means `Iterable<Anything,Null>`.

Note that we needed to explicitly specify the pointy brackets
in `Iterable<>`.

### Gotcha!

Default type arguments are always ignored when type arguments are inferred.

Suppose I have a generic class with a default argument:

<!-- try: -->
    class Container<out Element=Anything>(Element* elements) {}

Let's instantiate this class without any arguments:

<!-- try-pre:
   class Container<out Element=Anything>(Element* elements) {}
-->
    value container = Container();

You might imagine that this instantiation would produce a
`Container<Anything>`, since `Anything` is the default type 
argument for `Element`. But that's not correct. In fact, the
instantiation produces a `Container<Nothing>`, according to the
usual rules for type argument inference of a covariant type 
parameter. To get a `Container<Anything>`, we could need to 
write:

<!-- try-pre:
    class Container<out Element=Anything>(Element* elements) {}
-->
    value container = Container<>();

Where the pointy brackets act to disable type inference.

## Covariance and contravariance

Ceylon eliminates, [mostly](../interop/#wildcards), one of the bits of Java 
generics that's hardest to get your head around: wildcard types. Wildcard 
types were Java's solution to the problem of *covariance* in a generic type 
system. Let's meet the idea of covariance, and then see how covariance works 
in Ceylon.

### Variant and invariant generic types

It all starts with the intuitive expectation that a collection of `Geek`s is 
a collection of `Person`s. That's a reasonable intuition, but, if collections 
are be mutable, it turns out to be incorrect. Consider the following possible 
definition of `Collection`:

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

We can't let that code by—Fonzie isn't a `Geek`!

Using big words, we say that `Collection` is *invariant* in `Element`. Or, when 
we're not trying to impress people with opaque terminology, we say that 
`Collection` both:

- _produces_ `Element`s, via the `iterator()` method, and 
- _consumes_ `Element`s, via the `add()` method.

Now, in Java, we can use a _wildcard_ to obtain:

- a covariant type, for example, `Collection<? extends Person>`, one that only 
  produces `Element`s, or
- a contravariant type, for example, `Collection<? super Geek>`, one that only 
  consumes `Element`s.

Ceylon also has wildcard types, though with a [much nicer syntax](#wildcard_types),
but they're mainly used for interoperation with Java. In pure Ceylon code, we
use a different approach to produce covariance or contravariance.

### Using declaration-site variance

We're going to refactor `Collection` into a pure producer interface and a pure 
consumer interface:

<!-- check:none -->
    interface Producer<out Output> {
        shared formal Iterator<Output> iterator();
    }
    interface Consumer<in Input> {
        shared formal void add(Input x);
    }

Notice that we've annotated the type parameters of these interfaces.

- The `out` annotation specifies that `Producer` is covariant in `Output`; 
  that it produces instances of `Output`, but never consumes instances of `Output`.
- The `in` annotation specifies that `Consumer` is contravariant in `Input`; 
  that it consumes instances of `Input`, but never produces instances of `Input`.

The Ceylon compiler validates the schema of the type declaration to ensure 
that the variance annotations are satisfied. If you try to declare an `add()` 
method on `Producer`, a compilation error results. If you try to declare an 
`iterate()` method on `Consumer`, you get a similar compilation error.

Now, let's see what that buys us:

- Since `Producer` is covariant in its type parameter `Output`, and since 
  `Geek` is a subtype of `Person`, Ceylon lets you assign `Producer<Geek>` to 
  `Producer<Person>`.
- Furthermore, since `Consumer` is contravariant in its type parameter `Input`, 
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

Which is also intuitively correct—`James` is most certainly a `Person`!

There's two additional things that follow from the definition of covariance 
and contravariance:

- `Producer<Anything>` is a supertype of `Producer<T>` for any type `T`, and
- `Consumer<Nothing>` is a supertype of `Consumer<T>` for any type `T`.

These invariants can be very helpful if you need to abstract over all 
`Producer`s or all `Consumer`s.

You're unlikely to spend much time writing your own collection classes, since 
the Ceylon SDK has a powerful collections framework built in. But you'll still 
appreciate Ceylon's approach to covariance as a user of the built-in collection 
types.

### Gotcha!

Sadly, declaration site variance doesn't help us when we interoperate with
native Java code, where all generic classes and interfaces are invariant, and
_wildcards_ are used to recover covariance or contravariance in method 
signatures.

Therefore, you'll sometimes need to use wildcards when interoperating with 
Java libraries.

### Wildcard types

We don't recommend the use of wildcard types in pure Ceylon code, but you 
still need to be aware of their existence if you ever plan to call native
Java classes from Ceylon.

This Java method signature:

<!-- try: -->
    //Java
    void java(Map<? super String, ? extends Widget> map) { ... }

Would be written like this in Ceylon:

<!-- try: -->
    //Ceylon
    void java(Map<in String, out Widget> map) { ... }

Here, we see a wildcarded type:

<!-- try: -->
    Map<in String, out Widget>

The wildcards `in String` and `out Widget` make the following
code well-typed:

<!-- try: -->
    //assigns a Map<Object,MoveableWidget> to Map<in String, out Widget>
    java(HashMap<Object,MoveableWidget>());

Since `Object` is a supertype of `String` and `MoveableWidget` is a subtype
of `Widget`, `Map<Object,MoveableWidget>` is assignable to the wildcard type
`Map<in String, out Widget>`.

If you didn't follow this section, don't worry. You might not ever even 
need to use a wildcard type in Ceylon. We have bigger fish to fry.

### Covariance and contravariance with unions and intersections

There's a couple of interesting relationships that arise when we introduce
union and intersection types into the picture.

First, consider a covariant type like `Producer<Element>`. Then for any types 
`X` and `Y`:

- `Producer<X>|Producer<Y>` is a subtype of `Producer<X|Y>` , and
- `Producer<X>&Producer<Y>` is a supertype of `Producer<X&Y>`.

Next, consider a contravariant type like `Consumer<Element>`. Then for any 
types `X` and `Y`:

- `Consumer<X>|Consumer<Y>` is a subtype of `Consumer<X&Y>` , and
- `Consumer<X>&Consumer<Y>` is a supertype of `Consumer<X|Y>`.

It's worth coming back to this section later, and trying to develop some 
intuition about exactly why these relationships are correct and what they 
mean. But don't waste time on that now. We've got bigger fish to fry!


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

We say that Ceylon features _principal instantiation inheritance_. 
Even the following code is legal:

<!-- try: -->
    interface ListOfSomething 
            satisfies List<Something> {}
            
    interface ListOfSomethingElse 
            satisfies List<SomethingElse> {}
            
    class MyList() satisfies 
            ListOfSomething & ListOfSomethingElse { ... }

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
[`Object`](#{site.urls.apidoc_1_3}/Object.type.html),
we need some way to assert that `Element` is a subtype of `Object`. This is 
an example of a *type constraint*—in fact, it's an example of the most 
common kind of type constraint, an *upper bound*.

### Upper bound type constraints

An upper bound type constraint restricts the arguments of a type parameter
to subtypes of a certain type.

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

Now, a type argument to `Element` must be a subtype of `Object`.

<!-- try-pre:
    class Set<out Element>(Element* elements)
            given Element satisfies Object { }

-->
<!-- check:none: Demos error -->
    Set<String> set1 = Set("C", "Java", "Ceylon"); //ok
    Set<String?> set2 = Set("C", "Java", "Ceylon", null); //compile error

### Enumerated bound type constraints

A second kind of type constraint is an *enumerated bound*, which 
constrains the type argument to be one of an enumerated list of types. 
It lets us write an exhaustive switch on the type parameter:

<!-- try: pre
    function sqrt(Float x) => x^0.5;
-->
<!-- try: post

    print(sqrt(3));
    print(sqrt(9.0));
-->
    Float sqr<Value>(Value x, Value y)
            given Value of Float | Integer {
        switch (x)
        case (is Float) {
            assert (is Float y);
            return sqrt(x^2+y^2);
        }
        case (is Integer) {
            assert (is Integer y);
            return sqrt((x^2+y^2).float);
        }
    }

This is one of the workarounds we [mentioned earlier](../classes/#living_without_overloading) 
for Ceylon's lack of overloading.

### Gotcha!

An enumerated bound like `given Value of Float|Integer` doesn't make
`Value` a _subtype_ of the union type `Float|Integer`. However, the
union type does _cover_ the type parameter `Value`. So you can assign
`Value` to `Float|Integer` with the help of the `of` operator:

<!-- try: -->
    void fun<Value>(Value val) 
            given Value of Float|Integer {
        Float|Integer floatOrInteger 
                = val of Float|Integer;
        ...
    }

This is the same thing we've [already seen](../types/#coverage_and_the_of_operator)
for other enumerated types.

### Multiple type constraints

When we declare multiple constraints on a type parameter, we must declare
them as part of the same `given` declaration:

<!-- try: -->
    given Value of Float | Integer satisfies Ordinal<Value> & Comparable<Value>

In Ceylon, a generic type parameter is considered a perfectly normal type, 
so a type constraint declaration looks a lot like an interface declaration, 
with the same syntax for the `of` and `satisfies` clauses. This is another 
way in which Ceylon is more regular than some other C-like languages.

<!--
Finally, the fourth kind of type constraint, which is much less common, and 
which most people find much more confusing, is a *lower bound*. A lower 
bound is the opposite of an upper bound. It says that a type parameter is 
a *supertype* of some other type. There's only really one situation where 
this is useful. Consider adding a `union()` operation to our `Set` interface. 
We might try the following:
-->
<!-- check:none --><!--
    shared class Set<out Element>(Element* elements)
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
    shared class Set<out Element>(Element* elements)
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
    shared class Set<out Element>(Element* elements)
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
    Set<Number<out Anything>> allTheNumbers = decimals.union(floats);
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
Ceylon compiler performs erasure, discarding type parameters from the schema 
of the generic type. On the JavaScript platform, types are discarded when 
producing JavaScript source. But unlike Java, type arguments are _reified_ 
(available at runtime). Types are even reified when executing on a JavaScript 
virtual machine!

So the code fragments above compile and function as expected on both 
platforms. Via the metamodel, you're even able to use reflection to discover 
the type arguments of an instance of a generic type at runtime.

Now of course, generic type arguments aren't checked for typesafety by the 
underlying virtual machine at runtime, but that's just not really strictly 
necessary since the compiler has already checked and proved the soundness 
of the code. They _are_, however, checked at runtime whenever you use a type 
`assert`ion to narrow the type of a value.


## There's more...

Now we're ready to look at a really important feature of the language: 
[modularity](../modules).

