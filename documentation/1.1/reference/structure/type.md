---
layout: reference11
title_md: Types and type declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

## Usage

The following are all type expressions:

    Human
    Human|Fish
    Human&Female
    List<Human|Fish>
    Set<Human&Female>
    HashSet<in Human&Female>
    HashSet<out Human|Fish>

## Description

### Types and type constructors

It is extremely important to understand that a [type *declaration*](../type-declaration/) 
such as 

    class Generic<Argument>(){
    }

does **not** introduce a new type. Instead it introduces a *type constructor*, 
called `Generic`, from which we can construct other types 
including
`Generic<String>`, `Generic<Integer>` and `Generic<Generic<Generic<Boolean>>>`. 
Those are called *applied types* (or *produced types*).

A non-generic class or interface declaration (one without type arguments) 
such as

    interface NonGeneric {
    }
    
does appear to introduce a type, simply because it requires no type arguments
so the expression `NonGeneric` is a valid type, but conceptually it is still 
a *type constructor*. 

Note that Ceylon doesn't allow *raw types* which allow a 
type constructor to be treated as a type.

### Union and intersection

Apart from producing types by applying type arguments to type constructors, 
Ceylon also allows us to produce types by forming intersections (using `&`)
and unions (using `|`) of other types.

    Human&Male
    Mammal|Reptile
    List<Mammal|Fish>
    Set<Human&Male>
    Male|Set<Human&Male>

### Subtypes

Ceylon supports *subtype polymorphism* (which just means inheritance)
in addition to *parameteric polymorphism* (which means having type constructors).
This means that as well as applying type arguments to type declarations, and 
producing unions and intersections of types, we can ask whether one type 
is a *subtype* of another. Being a subtype means all instances of the subtype 
must also be instances of the other type.

#### Subtypes of unions and intersections

Let's assume

    interface Human satisfies Mammal {
    }

So that `Human` is a subtype of `Mammal`. Then `Human` is also a subtype of
`Human|Fish` because every human is also a human or a fish. 
(`Fish` is also a subtype of `Human|Fish`). 
Generalizing we can say that any case of a union is trivially a 
subtype of that union.

With intersections it works the other way around. Every `Human&Male` is both a 
`Human` and a `Male`, so an intersection is trivially a subtype of all of 
its constituent types.

Be aware that the ceylon typechecker is quite powerful:

* it will simplify `Human|Mammal` to `Mammal` and `Human&Mammal` to `Human`
* it can often reason that an intersection type is `Nothing` 
  (which is does for things like `Integer&String`, for example).

This can be important when it comes to understanding compiler errors, 
because the type you wrote might not be the type the typechecker is 
using.

#### Subtypes and type constructors

Combining subtypes and type constructors, we can ask 
whether a `List<Mammal>` is a subtype of `List<Mammal|Fish>`.

It's not meaningful to 
start thinking "well `List` is a subtype of `List`" because `List` 
itself *isn't a type*, remember.

Instead we need to think about whether *every possible*
instance of `List<Mammal>` *must* also be an instance of 
`List<Mammal|Fish>`. The answer depends on how we use the list.

If we only "get elements out of the list", then from a 
`List<Mammal>` we might get a dog and a cat and a platypus and those 
would be perfectly good things to find in a `List<Mammal|Fish>` too. 
In other words in this "getting things out" case 
`List<Mammal>` is a subtype of `List<Mammal|Fish>`. And this 
turns out not to be limited to unions, so 
more generally if `X` is a subtype of `Y`
`Out<X>` is a subtype of `Out<Y>`. 
This is called *covariance* (the type parameter of `Out` is *convariant*).

Now, if we only "add elements to the list", then into a list of 
`List<Mammal|Fish>` we could add a dog and a cat and a shark, but 
we couldn't put all those things into a `List<Mammal>` 
(hint: a shark is not a mammal). So a 
`List<Mammal>` is *not* a subtype of `List<Mammal|Fish>`.

Now let's think about intersections.

Into a `List<Human>` we could add Alice, Bob and Carol, but into a 
`List<Human&Male>` we could only add Bob. So a 
`List<Human>` is a subtype of `List<Human&Male>` (which is the other 
way around from the type arguments, where `Human&Male` is a subtype of 
`Human`). In general in this "putting into" case we find that
if `X` is a subtype of `Y` then `In<Y>` is a subtype of In<X>`.
This is called *contravariance* (the type parameter of `In` is *contravariant*).

Sometimes you have an reference where you need to get things out 
*and* put them in. That's called *invariance*. 
In general if `X` is a strict subtype of `Y`
neither `Both<X>` not `Both<Y>` is a subtype of the other. 
This fact turns out to be rather inconvenient.

We want to be able to make use of the subtype relationships for 
`In` and `Out` types. To do this the typechecker needs to 
enforce that we don't go passing a reference 
to an "out thing" to something which wants to put things into the reference. 
Likewise passing a "in thing" to something which wants to 
get things out of the reference doesn't work either.

### Declaration-site variance

One way to do this is for the declaration of a type to say
it whether it is an "in thing" or an "out thing":

    interface Out<out Thing>{}
    interface In<in Thing>{}

The members of those interfaces then have to respect the 
`in` or `out` nature of `Thing`: We can't have a member of `In` 
which returns a `Thing` because that's a way of getting something 
out of an `In`. And we can't have a method which takes a `Thing` in an 
`Out` because that's a way to put something into an `Out`.

Using these `in` and `out` to label the type parameter of a declaration
is called *declaration-site variance* and it is the preferred way of 
handling variance in Ceylon.

There's a trick we can often use to get around the inconvenience 
of invariance. Suppose we want

    interface Both<Thing> {
        shared formal Thing getThing;
        shared formal Thing makeThing();
        shared formal void consumeThing(Thing thing);
    }

We can put all the `Thing`-producing operations in an `out` declaration
and all the `Thing`-consuming operations in a different `in` declaration and 
then combine them in a class:

    interface OutThings<out Thing>{
        shared formal Thing getThing;
        shared formal Thing makeThing();
    }
    interface InThings<in Thing>{
        shared formal void consumeThing(Thing thing);
    }
    class BothThings<Thing>()
            satisfies OutThings<Thing> & InThings<Thing> {
        // ...
    }

This trick starts to break down when there's a member which itself 
has `Thing` as a result type and parameter type:

    Thing transformThing(Thing thing);

We can declare

    interface TransformThing<out Output, in Input> {
        shared formal Output transformThing(Input thing);
    }
    
And then satisfy `TransformThing<Thing, Thing>`.

### Use-site variance

Ceylon has another way of expressing variance: At the place where we apply a type 
argument list to a type constructor. Reusing the invariant declaration `Both` 
we can write:

    Both<out Thing>
    
Every occurence of `Thing` as a return type in `Both` also has the type `Thing` in `Both<out Thing>`, as we might hope.

However, every occurence of `Thing` as a parameter type in `Both` has the type `Thing&Nothing` in `Both<out Thing>`. 
`Thing&Nothing` is the same as `Nothing`, and we know there are no instances of `Nothing`, so we can never
supply a valid argument to such a parameter. Thus we cannot call those members of `Both<out Thing>` which have a 
`Thing`-typed parameter.

Similar things happen with

    Both<in Thing>
    
Those members would return `Thing`-typed results `Both` return `Anything` in `Both<in Thing>`. 
    
Strictly, use-site variance is more powerful than declaration-side variance, but:

* it's also less intuitive for most people 
* we can end up constructing some extremely complicated type expressions.

For example the interface List has a method called partition.
The return type of partition() on a List<out Y> is 

    List<in List<in Y out Nothing> out List<in Nothing out Y>>

We we don't generally use it in Ceylon, except where we have to.

When is that?


## Usage 

Example *type declarations*:

<!-- try: -->
    class MyClass(name) {
        shared String name;
    }
    class MyGenericClass<Arg>(Arg arg) {
    }
    interface MyInterface {
        shared formal String name;
    }
    interface MyInterface<Arg> {
        shared formal Arg arg;
    }
    object myObject {
        shared String name = "Trompon";
    }
    
Example *type expressions*:

    MyClass
    MyGenericClass<Integer>
    MyInterface
    MyGenericInterface<MyClass>


## Description

### Types versus Type declarations

It is important the appreciate the difference between a 
*type declaration* (such as the declaration of a class) 
which introduces a *type constructor* and an
*applied type* (also called a *produced type*). 

Given the declaration of `MyGenericClass` above the expression 
`MyGenericClass` 
is not a *type* but a *type constructor*: It needs a *type argument*
to obtain an *applied type*. Given a non-generic type declaration 
such as `MyClass` the expression `MyClass` can be seen as both a 
type and a type constructor (because it 
needs no type arguments to construct a type).

Ceylon doesn't have "raw types", where a type constructor like 
`MyGenericClass` can be magically treated as a type.


### Type declarations

In Ceylon, a *type declaration* is one of:

* A [`class` declaration](../class)
* An [`interface` declaration](../interface)
* An [`object` declaration](../object)

All these declarations have *members*.

A [type parameter](../type-parameters) is also sometimes considered a
kind of type declaration. However, a type parameter does not declare
members.

Function and value declarations to not introduce new types or 
type constructors and do not have members.

#### Member declarations

A declaration that occurs directly in a type declaration is called a 
*member declaration*. Member [values](../value/) are called 
*attributes*. Member [functions](../function/) are called *methods*.
Member classes and interfaces do not have a different name.

#### Local declarations

A *local* (or *nested*) declaration is a declaration that is 
contained within another declaration or a statement.

#### Top-level declarations

A *top level* declaration is contained directly in a
[compilation unit](../compilation-unit) and not contained within any other
declaration. In other words a top level declaration is neither
a [member](#member_declarations) nor a [local](#local_declarations) declaration.

### Enumerated types

Classes can [enumerate](../class#enumerated_classes) 
a list of their permitted subclasses. 

Interfaces can [enumerate](../interface#enumerated_subtypes) 
a list of their permitted subtypes. 

The subtypes are called the cases of the class or interface. 

### Type aliases

To avoid having to repeat long type expressions, you can define a 
[type alias](../alias#type_alises) for a type using the `alias` 
keyword:

<!-- try: -->
    alias BasicType = String|Character|Integer|Float|Boolean;
    
    
### `Null`

[`Null`](#{site.urls.apidoc_1_1}/Null.type.html) is the type of 
[`null`](#{site.urls.apidoc_1_1}/index.html#null). 
If an expression permits `null` then it
needs `Null` as a supertype. This is usually expressed as using a 
[union type](#union_types) such as `T|Null`, which can be [abbreviated](../type-abbreviation]
as `T?`, and we may refer to it as an *optional type*.

### `Nothing`

[`Nothing`](#{site.urls.apidoc_1_1}/Nothing.type.html) 
is the intersection of *all* types. It is equivalent to the empty set.
Because `Nothing` is the intersection of all types it is assignable to 
all types. Similarly because it is the intersection of all types it can 
have no instances. It corresponds to the notion of an empty set in
mathematics.

There is a value called `nothing` in the language module, which 
has the type `Nothing`. At runtime trying to evaluate 
`nothing` (that is, get an instance of `Nothing`) will 
throw an exception.

### `Iterable`

[`Iterable`](#{site.urls.apidoc_1_1}/Iterable.type.html) 
is a type that produces instances of another type when iterated. 

There are two flavours of `Iterable`:

* the type `Iterable<T>`, usually [abbreviated](../type-abbreviation]  to `{T*}`,
  may contain zero or more elements (it is *possibly empty*),
* the type `Iterable<T,Nothing>`, usually [abbreviated](../type-abbreviation]  to `{T+}`,
  contains at least one element (it is *non-empty*)

### `Sequential`

[`Sequential`](#{site.urls.apidoc_1_1}/Sequential.type.html) 
is an enumerated type with subtypes 
[`Sequence`](#{site.urls.apidoc_1_1}/Sequence.type.html) and 
[`Empty`](#{site.urls.apidoc_1_1}/Empty.type.html). 
`Sequential<T>` is usually [abbreviated](../type-abbreviation] 
to `T[]` or `[T*]`.

### `Empty`

[`Empty`](#{site.urls.apidoc_1_1}/Empty.type.html) is the type 
of a [`Sequential`](#{site.urls.apidoc_1_1}/Sequential.type.html) 
which contains no elements. 

The expression `[]` (or alternatively the value `empty`) 
in the language module has the type `Empty`.

### `Sequence`

[`Sequence`](#{site.urls.apidoc_1_1}/Sequence.type.html) is the 
type of non-empty sequences.
`Sequence<T>` is usually [abbreviated](../type-abbreviation] to `[T+]`.

### `Tuple`

[`Tuple`](#{site.urls.apidoc_1_1}/Tuple.type.html) is a subclass 
of `Sequence` (and thus cannot be empty). It differs from `Sequence` 
in that it encodes the types of each of its elements individually.

<!-- try: -->
    [Integer, Boolean, String] t = [1, true, ""];
    Integer first = t[0];
    Boolean second = t[1];
    String last = t[2];

Tuples also have a notion of *variadicity*:

<!-- try: -->
    // A tuple of at least two elements
    // the first is an Integer and 
    // the rest are Boolean
    [Integer, Boolean+] t = [1, true, false];
    // A tuple of at least element
    // the first is an Integer and 
    // the rest are Boolean
    [Integer, Boolean*] t2 = t;

`Tuple` types may thus be used to represent the type of an argument or
parameter list, and are therefore used to encode function types.

Unabbreviated tuple types are extremely verbose, and therefore the 
[abbreviated](../type-abbreviation] form is always used. 

### Metamodel

There are two ways of modelling declarations at runtime mirroring 
the difference between a declaration and its type.

The package `ceylon.language.meta.declaration` contains interfaces
which model *declarations*. As such, those declarations have
type parameter lists. Supplying 
a type argument list for a declaration you can obtain an 
instance of a *model* from `ceylon.language.meta.model`.

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [method declaration](../function)
* [attribute declaration](../value)
* [type abbreviations](../type-abbreviation)
* [type parameters](../type-parameters)
