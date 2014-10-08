---
layout: reference11
title_md: Types and type declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

This page is about types and type expressions.
There is a separate page about [type declarations](../type-declaration) 
in general and further pages about [class declarations](../class) and
[interface declarations](../interface) in particular.

## Usage

The following are all *type expressions*:

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

does **not** introduce a new *type*. Instead it introduces a *type constructor*, 
called `Generic`, from which we can construct other types 
such as

    Generic<String>
    Generic<Integer>
    Generic<Generic<Generic<Boolean>>>
    
These are called *applied types* (or *produced types*), because we're applying 
a list of *type arguments* to the type constructor to 
create a type.

A non-generic [class](../class/) or [interface](../interface/) 
declaration (one without type arguments) such as

    interface NonGeneric {
    }
    
does appear to introduce a type, simply because it requires no type arguments
so the expression `NonGeneric` is a valid type expression, but conceptually it is still 
a *type constructor*. 

Note that Ceylon doesn't allow *raw types* which allow a 
type constructor to be treated as a type.

This might seem like pedantry, but understanding the difference between the 
declaration of a type (i.e. a type constructor) and the types which are 
produced from it will prove helpful.

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

*Subtype polymorphism* means that as well as applying type arguments to 
type declarations, and 
producing unions and intersections of types, we can ask whether one type 
is a *subtype* of another. Being a subtype means all instances of the subtype 
must also be instances of the other type.

In particular Ceylon supports *declarative subtyping*. That means
the [declaration of a type](../type-declaration#declarative_subtyping) 
includes listing what are the supertypes of types produced 
from the declaration.

It's worth mentioning two important types at this point:

* [`Anything`](../type-declaration#anything) is the supertype of all types; you can't do anything with an instanceof `Anything` 
  except narrow it to some more useful type,
* [`Nothing`](../type-declaration#nothing) is a subtype of all types; there are no instances of `Nothing`.

### Subtypes of unions and intersections

Assume that

    interface Human satisfies Mammal {
    }

So that the type `Human` is a subtype of the type `Mammal`. 
Then `Human` is also a subtype of
`Human|Fish` because every human is also a human or a fish. 
(`Fish` is also a subtype of `Human|Fish`). 
Generalizing, we can say that any case of a union is trivially a 
subtype of that union:

    X and Y are both subtypes of X|Y

With intersections it works the other way around. Every `Human&Male` is both a 
`Human` and a `Male`, so an intersection is trivially a subtype of all of 
its constituent types:

    X&Y is a subtype of both X and Y

Be aware that the ceylon typechecker is quite powerful in dealing with
unions and intersections:

* it will simplify `Human|Mammal` to `Mammal` and `Human&Mammal` to `Human`
* it can often reason that an intersection type is `Nothing` 
  (which is does for things like `Integer&String`, for example).

This can be important when it comes to understanding compiler errors, 
because the type you wrote might not be the type the typechecker is 
using.

### Subtypes and type constructors

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
`List<Mammal>` is a subtype of `List<Mammal|Fish>`. 

Now, if we only "add elements to the list", then into a list of 
`List<Mammal|Fish>` we could add a dog and a cat and a shark, but 
we couldn't put all those things into a `List<Mammal>` 
(hint: a shark is not a mammal). So a 
`List<Mammal>` is *not* a subtype of `List<Mammal|Fish>`. 

It
turns out that this rule for "out" not to be limited to unions, so 
more generally 

> if `X` is a subtype of `Y` then `Out<X>` is a subtype of `Out<Y>`. 

This is called *covariance* (the type parameter of `Out` is *covariant*).

Now let's think about intersections.

Into a `List<Human>` we could add Alice, Bob and Carol, but into a 
`List<Human&Male>` we could only add Bob. So a 
`List<Human>` is a subtype of `List<Human&Male>` (which is the other 
way around from the type arguments, where `Human&Male` is a subtype of 
`Human`). In general in this "putting into" case we find that

> if `X` is a subtype of `Y` then `In<Y>` is a subtype of `In<X>`

This is called *contravariance* (the type parameter of `In` is *contravariant*).

Sometimes you have an reference where you need to get things out 
*and* put them in. That's called *invariance*. 
In general if `X` is a strict subtype of `Y`
neither `Both<X>` not `Both<Y>` is a subtype of the other. 
This fact turns out to be rather inconvenient.

There are formal rules for what constitutes "in" and "out", but 
the simplest and most commonly needed one is:

* If a type parameter appears just in attribute and method return types
  it's "out" (covariant).
* If a type parameter appears just in method and member class 
  parameter types, it's "in" (contravariant).
* If a type parameter appears on both places it's invariant.

We want to be able to make use of the subtype relationships for 
`In` and `Out` types. To do this the typechecker needs to 
enforce that we don't go passing a reference 
to an "out thing" to something which wants to put things into the reference. 
Likewise passing a "in thing" to something which wants to 
get things out of the reference doesn't work either.

### Declaration-site variance

One way to do this is for the [declaration of a type](../type-declaration) 
to say
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
    
And then satisfy `TransformThing<Thing, Thing>`, but this 
starts to get cumbersome.

### Use-site variance

Ceylon has another way of expressing variance: At the place where we apply a type 
argument list to a type constructor. Reusing the invariant declaration `Both` 
we can write:

    Both<out Mammal>
    
Every occurence of `Thing` as a return type in `Both` then has the type `Mammal` in `Both<out Mamma>`, as we might hope.

However, every occurence of `Thing` as a parameter type in `Both` has the type `Nothing` in `Both<out Mammal>`. 
We know there are no instances of `Nothing`, so we can never
supply a valid argument to such a parameter. Thus we cannot call those members of `Both<out Mammal>` which have a 
`Thing`-typed parameter.

Similar things happen with

    Both<in Mammal>
    
Those members would return `Thing`-typed results `Both` return `Anything` in `Both<in Mammal>`: We can obtain a 
result, but can't do much with it.
    
Strictly, use-site variance is more powerful than declaration-side variance, but:

* it's also less intuitive for most people 
* we can end up constructing some extremely complicated type expressions.

An example of such an "extremely complicated type expression"
is the type of the `partition()` of `List<out Y>`. Technically 
this is 

    List<in List<in Y out Nothing> out List<in Nothing out Y>>

But Ceylon doesn't actually support `in` and `out` type arguments
(each type argument must be just `in` or just `out`), because 
thinking about this stuff is just too hard for most programmers.

So, in general, we avoid using use-site variance in Ceylon.

## See also

* [type declarations](../type-declaration)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [type abbreviations](../type-abbreviation)
* [type parameters](../type-parameters)
