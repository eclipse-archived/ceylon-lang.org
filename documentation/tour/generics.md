---
layout: tour
title: Tour of Ceylon&#58; Generics
tab: documentation
author: Gavin King
---

# #{page.title}

## Defining generic types

We've seen plenty of parameterized types in this series of articles, but now 
let's explore a few more details.

Programming with generic types is one of the most difficult parts of Java. 
That's still true, to some extent, in Ceylon. But because the Ceylon language 
and SDK were designed for generics from the ground up, Ceylon is able to 
alleviate the most painful aspects of Java's bolted-on-later model.

Just like in Java, only types and methods may declare type parameters. Also 
just like in Java, type parameters are listed before ordinary parameters, 
enclosed in angle brackets.

<!-- lang: ceylon -->
    shared interface Iterator<out Element> { ... }
    class Array<Element>(Element... elements) satisfies Sequence<Element> { ... }
    shared Entries<Natural,Value> entries<Value>(Value... sequence) { ... }

As you can see, the convention in Ceylon is to use meaningful names for 
type parameters (in Java the convention is to use single letter names).

Unlike Java, we always do need to specify type arguments in a type declaration 
(there are no 'raw types' in Ceylon). The following will not compile:

<!-- lang: ceylon -->
    Iterator it = ...;   //error: missing type argument to parameter Element of Iterator

We always have to specify a type argument in a type declaration:

<!-- lang: ceylon -->
    Iterator<String> it = ...;

On the other hand, we shouldn't need to explicitly specify type arguments in 
most method invocations or class instantiations. In principle it's very 
often possible to infer the type arguments from the ordinary arguments. 
The following code should be possible, just like it is in Java:

<!-- lang: ceylon -->
    Array<String> strings = Array("Hello", "World");
    Entries<Natural,String> entries = entries(strings);

But we haven't yet figured out what exactly the type inference algorithm will 
be (probably something involving union types!) and so the Ceylon compiler 
currently requires that all type arguments be explicitly specified like this:

<!-- lang: ceylon -->
    Array<String> strings = Array<String>("Hello", "World");
    Entries<Natural,String> entries = entries<Natural,String>(strings);

On the other hand, the following code does already compile:

<!-- lang: ceylon -->
    value strings = Array<String>("Hello", "World");
    value entries = entries<Natural,String>(strings);

The root cause of very many problems when working with generic types in 
Java is *type erasure*. Generic type parameters and arguments are discarded 
by the compiler, and simply aren't available at runtime. So the following, 
perfectly sensible, code fragments just wouldn't compile in Java:

<!-- lang: ceylon -->
    if (is List<Person> list) { ... }
    if (is Element obj) { ... }

(Where `Element` is a generic type parameter.)

A major goal of Ceylon's type system is support for *reified generics*. Like 
Java, the Ceylon compiler performs erasure, discarding type parameters from 
the schema of the generic type. But unlike Java, type arguments are supposed 
to be reified (available at runtime). Of course, generic type arguments won't 
be checked for typesafety by the underlying virtual machine at runtime, but 
type arguments are at least available at runtime to code that wants to make 
use of them explicitly. So the code fragments above are supposed to compile 
and function as expected. You will even be able to use reflection to discover 
the type arguments of an instance of a generic type.

The bad news is we haven't implemented this yet ;-)

Finally, Ceylon eliminates one of the bits of Java generics that's really 
hard to get your head around: wildcard types. Wildcard types were Java's 
solution to the problem of *covariance* in a generic type system. Let's first 
explore the idea of covariance, and then see how covariance in Ceylon works.

## Covariance and contravariance

It all starts with the intuitive expectation that a collection of `Geeks` is a 
collection of `Persons`. That's a reasonable intuition, but especially in 
non-functional languages, where collections can be mutable, it turns out to be 
incorrect. Consider the following possible definition of `Collection`:

<!-- lang: ceylon -->
    shared interface Collection<Element> {
        shared formal Iterator<Element> iterator();
        shared formal void add(Element x);
    }

And let's suppose that `Geek` is a subtype of `Person`. Reasonable.

The intuitive expectation is that the following code should work:

<!-- lang: ceylon -->
    Collection<Geek> geeks = ... ;
    Collection<Person> people = geeks;    //compiler error
    for (Person person in people) { ... }

This code is, frankly, perfectly reasonable taken at face value. Yet in both 
Java and Ceylon, this code results in a compiler error at the second line, 
where the `Collection<Geek>` is assigned to a `Collection<Person>`. Why? 
Well, because if we let the assignment through, the following code would also 
compile:

<!-- lang: ceylon -->
    Collection<Geek> geeks = ... ;
    Collection<Person> people = geeks;    //compiler error
    people.add( Person("Fonzie") );

We can't let that code by — Fonzie isn't a `Geek`!

Using big words, we say that `Collection` is *nonvariant* in `Element`. Or, 
when we're not trying to impress people with opaque terminology, we say that 
`Collection` both produces — via the `iterator()` method — and consumes — 
via the `add()` method — the type `Element`.

Here's where Java goes off and dives down a rabbit hole, successfully using 
wildcards to squeeze a covariant or contravariant type out of a nonvariant 
type, but also succeeding in thoroughly confusing everybody. We're not going 
to follow Java down the hole.

Instead, we're going to refactor `Collection` into a pure producer interface 
and a pure consumer interface:

<!-- lang: ceylon -->
    shared interface Producer<out Output> {
        shared formal Iterator<Output> iterator();
    }
    shared interface Consumer<in Input> {
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

<!-- lang: ceylon -->
    shared interface Collection<Element>
            satisfies Producer<Element> & Consumer<Element> {}

Notice that `Collection` remains nonvariant in `Element`. If we tried to add a 
variance annotation to `Element` in `Collection`, a compile time error would 
result.

Now, the following code finally compiles:

<!-- lang: ceylon -->
    Collection<Geek> geeks = ... ;
    Producer<Person> people = geeks;
    for (Person person in people) { ... }

Which matches our original intuition.

The following code also compiles:

<!-- lang: ceylon -->
    Collection<Person> people = ... ;
    Consumer<Geek> geekConsumer = people;
    geekConsumer.add( Geek("James") );

Which is also intuitively correct — `James` is most certainly a `Person`!

There's two additional things that follow from the definition of covariance 
and contravariance:

* `Producer<Void>` is a supertype of `Producer<T>` for any type `T`, and
* `Consumer<Bottom>` is a supertype of `Consumer<T>` for any type `T`.

These invariants can be very helpful if you need to abstract over all 
`Producers` or all `Consumers`. (Note, however, that if `Producer` declared 
upper bound type constraints on `Output`, then `Producer<Void>` would not 
be a legal type.)

You're unlikely to spend much time writing your own collection classes, since 
the Ceylon SDK has a powerful collections framework built in. But you'll still 
appreciate Ceylon's approach to covariance as a user of the built-in collection 
types. The collections framework defines two interfaces for each basic kind of 
collection. For example, there's an interface `List<Element>` which represents 
a read-only view of a list, and is covariant in `Element`, and 
`OpenList<Element>`, which represents a mutable list, and is nonvariant in 
`Element`.


## Generic type constraints

Very commonly, when we write a parameterized type, we want to be able to 
invoke methods or evaluate attributes upon instances of the type parameter. 
For example, if we were writing a parameterized type `Set<Element>`, we would 
need to be able to compare instances of `Element` using `==` to see if a 
certain instance of `Element` is contained in the `Set`. Since `==` is only 
defined for expressions of type `Equality`, we need some way to assert that 
`Element` is a subtype of `Equality`. This is an example of a *type 
constraint* — in fact, it's an example of the most common kind of type 
constraint, an *upper bound*.

<!-- lang: ceylon -->
    shared class Set<out Element>(Element... elements)
            given Element satisfies Equality {
        ...
     
        shared Boolean contains(Object obj) {
            if (is T obj) {
                return obj in bucket(obj.hash);
            }
            else {
                return false;
            }
        }
     
    }

A type argument to `Element` must be a subtype of `Equality`.

<!-- lang: ceylon -->
    Set<String> set = Set("C", "Java", "Ceylon"); //ok
    Set<String?> set = Set("C", "Java", "Ceylon", null); //compile error

In Ceylon, a generic type parameter is considered a proper type, so a type 
constraint looks a lot like a class or interface declaration. This is another 
way in which Ceylon is more regular than some other C-like languages.

An upper bound lets us call methods and attributes of the bound, but it 
doesn't let us instantiate new instances of `Element`. Once we implement 
reified generics, we'll be able to add a new kind of type constraint to 
Ceylon. An *initialization parameter specification* lets us actually 
instantiate the type parameter.

<!-- lang: ceylon -->
    shared class Factory<out Result>()
            given Result(String s) {
     
        shared Result produce(String string) {
            return Result(string);
        }
     
    }

A type argument to `Result` of `Factory` must be a class with a single 
initialization parameter of type `String`.

<!-- lang: ceylon -->
    Factory<Hello> = Factory<PersonalizedHello>(); //ok
    Factory<Hello> = Factory<DefaultHello>(); //compile error

A third kind of type constraint is an *enumerated type bound*, which constrains 
the type argument to be one of an enumerated list of types. 
It lets us write an exhaustive switch on the type parameter:

<!-- lang: ceylon -->
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

This is one of the workarounds we mentioned earlier for Ceylon's lack of 
overloading.

Finally, the fourth kind of type constraint, which is much less common, and 
which most people find much more confusing, is a *lower bound*. A lower 
bound is the opposite of an upper bound. It says that a type parameter is 
a *supertype* of some other type. There's only really one situation where 
this is useful. Consider adding a `union()` operation to our `Set` interface. 
We might try the following:

<!-- lang: ceylon -->
    shared class Set<out Element>(Element... elements)
            given Element satisfies Equality {
        ...
         
        shared Set<Element> union(Set<Element> set) {   //compile error
            return ....
        }
         
    }

This doesn't compile because we can't use the covariant type parameter `T` 
in the type declaration of a method parameter. The following declaration 
would compile:

<!-- lang: ceylon -->
    shared class Set<out Element>(Element... elements)
            given Element satisfies Equality {
        ...
         
        shared Set<Object> union(Set<Object> set) {
            return ....
        }
         
    }

But, unfortunately, we get back a `Set<Object>` no matter what kind of 
set we pass in. A lower bound is the solution to our dilemma:

<!-- lang: ceylon -->
    shared class Set<out Element>(Element... elements)
            given Element satisfies Equality {
        ...
         
        shared Set<UnionElement> union(Set<UnionElement> set)
                given UnionElement abstracts Element {
            return ...
        }
         
    }

With type inference, the compiler chooses an appropriate type argument to 
`UnionElement` for the given argument to `union()`:

<!-- lang: ceylon -->
    Set<String> strings = Set("abc", "xyz") ;
    Set<String> moreStrings = Set("foo", "bar", "baz");
    Set<String> allTheStrings = strings.union(moreStrings);
    Set<Decimal> decimals = Set(1.2.decimal, 3.67.decimal) ;
    Set<Float> floats = Set(0.33, 22.0, 6.4);
    Set<Number> allTheNumbers = decimals.union(floats);
    Set<Hello> hellos = Set( DefaultHello(), PersonalizedHello(name) );
    Set<Object> objects = Set("Gavin", 12, true);
    Set<Object> allTheObjects = hellos.union(objects);

## There's more...

Next we're going to back up a bit and cover a [couple of topics that got 
kinda glossed over](../missing-pieces).

