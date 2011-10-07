---
layout: tour
title: Tour of Ceylon&#58; The language module
tab: documentation
author: Gavin King
---

# #{page.title}

This is the eleventh part of the Tour of Ceylon. The 
[previous leg](../named-arguments) looked at invoking functions
using named arguments. We're now going to learn about the 'language module'.

## An overview of the language module

The module `ceylon.language` contains classes and interfaces that are 
referred to in the language specification, other declarations *they* refer to,
and a number of related declarations. Let's meet the main characters.

Just like Java, Ceylon has a class named `Object`.

<!-- lang: ceylon -->
    shared abstract class Object()
            extends Void() {
             
        doc "A developer-friendly string representing the instance."
        shared formal String string;
         
        doc "Determine if this object belongs to the given Category
             or is produced by the iterator of the given Iterable
             object."
        shared Boolean element(Category|Iterable<Equality> category) {
            switch (category)
            case (is Category) {
                return category.contains(this);
            }
            case (is Iterable<Equality>) {
                if (is Equality self = this) {
                    for (Equality x in category) {
                        if (x==self) {
                            return true;
                        }
                    }
                    fail {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
        }
    }

In Ceylon, `Object` *isn't* the root of the type system. An expression of 
type `Object` has a definite, well-defined, non-`null` value. 
As we've seen, the Ceylon type system can also represent some more exotic 
types, for example `Nothing`, which is the type of `null`.

Therefore, Ceylon's `Object` has a superclass, named `Void`, which we already 
met in the [first part](../basics) of the tour. 
All Ceylon types are assignable to `Void`. Expressions of 
type `Void` aren't useful for very much, since `Void` has no members or 
operations. You can't even narrow an expression of type `Void` to a different 
type. The one useful thing you can do with `Void` is use it to represent the 
signature of a method when you don't care about the return type, since a 
method declared `void` is considered to have return type `Void`, as we saw in 
the [part about functions](../functions).

As we also saw in the [first part](../basics), the type `Nothing` directly 
extends `Void`. All types that represent well-defined values extend `Object`, 
including:

* user-written classes,
* all interfaces, and
* the types that are considered primitive in Java, such as `Integer`, 
  `Float` and `Character`.

Since an expression of type `Object` always evaluates to a definite, 
well-defined value, it's possible to obtain the runtime type of an 
`Object`, or narrow an expression of type `Object` to a more specific type.

## Equality and identity

On the other hand, since `Object` is a supertype of types like 
`Float` which are passed by value at the level of the Java Virtual Machine, 
you can't use the `===` operator to test the identity of two values of type 
`Object`. Instead, there is a subclass of `Object`, named `IdentifiableObject`, 
which represents a type which is always passed by reference. The `===` 
operator accepts expressions of type `IdentifiableObject`. It's possible for 
a user-written class to directly extend `Object`, but most of the classes 
you write will be subclasses of `IdentifiableObject`. All classes with 
variable attributes must extend `IdentifiableObject`.

<!-- lang: ceylon -->
    shared abstract class IdentifiableObject()
            extends Object()
            satisfies Equality {
     
        shared default actual Boolean equals(Equality that) {
            if (is IdentifiableObject that) {
                return this===that;
            }
            else {
                return false;
            }
        }
         
        shared default actual Integer hash {
            return identityHash(this);
        }
         
        shared default actual String string {
            ...
        }
             
    }

`IdentifiableObject` defines a default implementation of the interface 
`Equality`, which is very similar to the `equals()` and `hashCode()` methods 
defined by `java.lang.Object`.

<!-- lang: ceylon -->
    shared interface Equality {
         
        shared formal Boolean equals(Equality that);
         
        shared formal Integer hash;
         
    }

Just like in Java, you can refine this default implementation in your own 
classes. This is the normal way to get a customized behavior for the `==` 
operator, the only constraint being, that for subtypes of 
`IdentifiableObject`, `x===y` should imply `x==y` — equality should be 
consistent with identity.

Occasionally that's not what we want. For example, for numeric types, it 
doesn't matter whether a value is of class `Natural`, `Integer`, or `Whole` when 
comparing it to `0`. Fortunately, numeric types extend `Object` directly, and 
are not subject to the additional constraints defined by `IdentifiableObject`.

Thus, Ceylon is able to capture within the type system much of the behavior 
that Java introduces by fiat special-case rules in the language definition.

## Operator polymorphism

Ceylon discourages the creation of intriguing executable ASCII art. 
Therefore, true operator overloading is *not* supported by the language. 
Instead, almost every operator (every one except the primitive `.`, `()`, 
`is`, and `:=` operators) is considered a shortcut way of writing some more 
complex expression involving other operators and ordinary method calls. 
For example, the `<` operator is defined in terms of the interface 
`Comparable<Other>`, which we met in the [lesson on types](../types), 
and which has a method named `smallerThan()`, which is in turn defined in 
terms of another method named `compare()`.

<!-- lang: ceylon -->
    x<y

means, by definition,

<!-- lang: ceylon -->
    x.smallerThan(y)

The equality operator `==` is defined in terms of the interface `Equality`, 
which has a method named `equals()`.

<!-- lang: ceylon -->
    x==y

means, by definition,
<!-- lang: ceylon -->
    x.equals(y)

Therefore, it's easy to customize operators like `<` and `==` with specific 
behavior for our own classes, just by implementing or refining methods 
like `compare()` and `equals()`. Thus, we say that operators are polymorphic 
in Ceylon.

Apart from `Comparable` and `Equality`, which provide the underlying 
definition of comparison and equality operators, the following interfaces are 
also important in the definition of Ceylon's polymorphic operators:

* `Summable` supports the infix `+` operator,
* `Invertable` supports the prefix `+` and `-` operators,
* `Numeric` supports the other basic arithmetic operators,
* `Slots` supports bitwise operators,
* `Comparable` supports the comparison operators,
* `Correspondence` and `Sequence` support indexing and subrange operators, and
* `Boolean` is the basis of the logical operators.

Operator polymorphism is a little more flexible than you might imagine. 
Here's a quick example of this.

## The Slots interface

The interface Slots is an abstraction of the idea of a set of slots which may 
each hold `true` or `false`. The bitwise operators `&`, `|`, and `~` are 
defined in terms of this interface. The most obvious subtype of `Slots` would 
be a `Byte` class, where the slots are the eight binary digits.

But the interface `Set` from the `collections` module also extends `Slots`. 
The slots of a `Set` are values which may or may not belong to the set. A 
slot holds `true` if the value it represents belongs to the `Set`. The 
practical value of this is to allow the use of the operator `|` for set 
union, the operator `&` for set intersection, and the infix `~` operator for 
set complement.

<!-- lang: ceylon -->
    Set<Person> children = males|females ~ adults;

These aren't the traditional symbols representing these operations. 
But if you think carefully about the definition of these operations, you'll 
probably agree that these symbols are reasonable.

We could even define a `Permission` class that implements `Slots`, allowing us 
to write things like `permissions&(read|execute)`.

## Numeric types

As we've mentioned several times before, Ceylon doesn't have anything like 
Java's primitive types. The types that represent numeric values are just 
ordinary classes. Ceylon has fewer built-in numeric types than other C-like languages:

* `Natural` represents the unsigned integers and zero,
* `Integer` represents signed integers,
* `Float` represents floating point approximations to the real numbers,
* `Whole` represents arbitrary-precision signed integers, and
* `Decimal` represents arbitrary-precision and arbitrary-scale decimals.

`Natural`, `Integer` and `Float` have 64-bit precision by default. Eventually, 
you'll be able to specify that a value has 32-bit precision by annotating it 
`small`. But note that this annotation is really just a hint that the 
compiler is free to ignore (and it currently does).

## Numeric literals

There are only two kinds of numeric literals: literals for `Naturals`, and 
literals for `Floats`:

<!-- lang: ceylon -->
    Natural one = 1;
    Float oneHundredth = 0.01;
    Float oneMillion = 1.0E+6;

The digits of a numeric literal may be grouped using underscores. If the 
digits are grouped, then groups must contain exactly three digits.

<!-- lang: ceylon -->
    Natural twoMillionAndOne = 2_000_001;
    Float pi = 3.141_592_654;

A very large or small numeric literals may be qualified by one of the 
standard SI unit prefixes: m, u, n, p, f, k, M, G, T, P.

<!-- lang: ceylon -->
    Float red = 390.0n; //n (nano) means E-9
    Float galaxyDiameter = 900.0P; //P (peta) means E15
    Float hydrogenRadius = 25.0p; //p (pico) means E-12
    Float usGovDebt = 14.33T; //T (tera) means E12
    Float brainCellSize = 4.0u; //u (micro) means E-6
    Natural deathsUnderCommunism = 94M; //M (mega) means E6

## Numeric widening

As mentioned earlier, Ceylon doesn't have implicit type conversions, 
not even built-in conversions for numeric types. Assignment does not 
automatically widen (or narrow) numeric values. Instead, we need to call 
one of the operations (well, attributes, actually) defined by the interface 
`Number`.

<!-- lang: ceylon -->
    Whole zero = 0.whole; //explicitly widen from Natural
    Decimal half = 0.5.decimal; //explicitly widen from Float

Usefully, the unary prefix operators `+` and `-` always widen `Natural` 
to `Integer`:

<!-- lang: ceylon -->
    Integer negativeOne = -1;
    Integer three = +3;

You can use all the operators you're used to from other C-style languages 
with the numeric types. You can also use the `**` operator to raise a 
number to a power:

<!-- lang: ceylon -->
    Float diagonal = (length**2.0+width**2.0)**0.5;

Of course, if you want to use the increment `++` operator, decrement `--` 
operator, or one of the compound assignment operators such as `+=`, you'll 
have to declare the value variable.

Since it's quite noisy to explicitly perform numeric widening in numeric 
expressions, the numeric operators automatically widen their operands, 
so we could write the expression above like this:

<!-- lang: ceylon -->
    Float diagonal = (length**2+width**2)**(1.0/2);

The "built-in" widening conversions are the following:

* `Natural` to `Integer`, `Float`, `Whole`, or `Decimal`
* `Integer` to `Float`, `Whole`, or `Decimal`
* `Float` to `Decimal`
* `Whole` to `Decimal`

But these conversions aren't defined by special-case rules in the 
language specification.

## Numeric operator semantics

Operators in Ceylon are, in principle, just abbreviations for some 
expression involving a method call. So the numeric types all implement the 
`Numeric` interface, refining the methods `plus()`, `minus()`, `times()`, 
`divided()` and `power()`, and the `Invertable` interface, refining `inverse`. 
The numeric operators are defined in terms of these methods of `Numeric`. 
The numeric types also implement the interface `Castable`, which enables the 
widening conversions we just mentioned.

<!-- lang: ceylon -->
    shared interface Castable<in Types> {
        shared formal CastValue as<CastValue>()
            given CastValue satisfies Types;
    }

The type parameter `Types` uses a special trick. The argument to `Types` 
should be the union of all types to which the implementing type is castable.

For example, simplifying slightly the definitions in the language module:

<!-- lang: ceylon -->
    shared class Natural(...)
            extends Object()
            satisfies Castable<Natural|Integer|Float|Whole|Decimal> &
                      Numeric<Natural> &
                      Invertable<Integer> {
        ...
    }
    shared class Integer(...)
            extends Object()
            satisfies Castable<Integer|Float|Whole|Decimal> &
                      Numeric<Integer> &
                      Invertable<Integer> {
        ...
    }
    shared class Float(...)
            extends Object()
            satisfies Castable<Float|Decimal> &
                      Numeric<Float> &
                      Invertable<Float> {
        ...
    }

These declarations tell us that `Integer` can be widened to `Float`, `Whole`, 
or `Decimal`, but that `Float` can only be widened to `Decimal`. So we can 
infer that the expression `-1 * 0.4` is of type Float.

Therefore, the definition of a numeric operator like `*` can be represented, 
completely within the type system, in terms of `Numeric` and `Castable`:

<!-- lang: ceylon -->
    Result product<Left,Right,Result>(Left x, Right y)
            given Result of Left|Right satisfies Numeric<Result>
            given Left satisfies Castable<Result> & Numeric<Left>
            given Right satisfies Castable<Result> & Numeric<Right> {
        return x.castTo<Result>().times(y.castTo<Result>());
    }

Don't worry too much about the performance implications of all this — 
in practice, the compiler is permitted to optimize the types `Natural`, 
`Integer`, and `Float` down to the virtual machine's native numeric types.

The value of all this — apart from eliminating special cases in the language 
definition and type checker — is that a library can define its own 
specialized numeric types, without losing any of the nice language-level 
syntax support for numeric arithmetic and numeric widening conversions.

## There's more...

If you're interested, you can check out a complete list of Ceylon's operators 
along with a discussion of their precedence.

Next we're going to come back to the subject of [object 
initialization](../initialization), and deal with a subtle problem affecting 
languages like Java and C#.

