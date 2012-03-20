---
layout: tour
title: Tour of Ceylon&#58; The language module
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the twelfth part of the Tour of Ceylon. The 
[previous leg](../named-arguments) looked at invoking functions
using named arguments. We're now going to learn about the 'language module'.

## An overview of the language module

The module [`ceylon.language`](#{site.urls.apidoc_current}/ceylon/language/) 
contains classes and interfaces that are 
referred to in the language specification, other declarations *they* refer to,
and a number of related declarations. Let's meet the main characters.

Just like Java, Ceylon has a class named 
[`Object`](#{site.urls.apidoc_current}/ceylon/language/class_Object.html).

<!-- check:none:decl from ceylon.language -->
    doc "The abstract supertype of all types representing 
         definite values."
    shared abstract class Object()
            extends Void() {

        shared formal Boolean equals(Object that);

        shared formal Integer hash;

        doc "A developer-friendly string representing the 
             instance."
        shared formal String string;
        
    }

In Ceylon, `Object` *isn't* the root of the type system. An expression of 
type `Object` has a definite, well-defined, non-`null` value. 
As we've seen, the Ceylon type system can also represent some more exotic 
types, for example 
[`Nothing`](#{site.urls.apidoc_current}/ceylon/language/class_Nothing.html), 
which is the type of `null`.

Therefore, Ceylon's `Object` has a superclass, named 
[`Void`](#{site.urls.apidoc_current}/ceylon/language/class_Void.html).

<!-- check:none:decl from ceylon.language -->
    doc "The abstract supertype of all types. A value of type 
         `Void` may be a definite value of type `Object`, or it 
         may be the `null` value. A method declared `void` is 
         considered to have the return type `Void`."
    shared abstract class Void() 
            of Object | Nothing {}

All Ceylon types are assignable to `Void`. Expressions of type `Void` aren't 
useful for very much, since `Void` has no members or operations. You can't 
even narrow an expression of type `Void` to a different type. The one useful 
thing you can do with `Void` is use it to represent the signature of a method 
when you don't care about the return type, since a method declared `void` is 
considered to have return type `Void`, as we saw in the 
[part about functions](../functions).

The class `Nothing` also directly extends `Void`. 

<!-- check:none:decl from ceylon.language -->
    doc "The type of the `null` value. Any union type of form 
         `Nothing|T` is considered an optional type, whose values
         include `null`. Any type of this form may be written as
         `T?` for convenience."
    shared abstract class Nothing() 
            of nothing
            extends Void() {}

The object `null` is the only instance of this class.

All types that represent well-defined values extend `Object`, including:

* user-written classes,
* all interfaces, and
* the types that are considered primitive in Java, such as 
  [`Integer`](#{site.urls.apidoc_current}/ceylon/language/class_Integer.html),
  [`Float`](#{site.urls.apidoc_current}/ceylon/language/class_Float.html) and 
  [`Character`](#{site.urls.apidoc_current}/ceylon/language/class_Character.html).

Since an expression of type `Object` always evaluates to a definite, 
well-defined value, it's possible to obtain the runtime type of an 
`Object`, or narrow an expression of type `Object` to a more specific 
type.


## Equality and identity

On the other hand, since `Object` is a supertype of types like `Float` which 
are passed by value at the level of the Java Virtual Machine, you can't use 
the `===` operator to test the identity of two values of type `Object`. 
Instead, there is a subclass of `Object`, named 
[`IdentifiableObject`](#{site.urls.apidoc_current}/ceylon/language/class_IdentifiableObject.html), 
which represents a type which is always passed by reference. The `===` operator 
accepts expressions of type `IdentifiableObject`. It's possible for a 
user-written class to directly extend `Object`, but most of the classes you 
write will be subclasses of `IdentifiableObject`. All classes with variable 
attributes must extend `IdentifiableObject`.

<!-- check:none:decl from ceylon.language -->
    shared abstract class IdentifiableObject()
            extends Object() {
     
        shared default actual Boolean equals(Object that) {
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
            return className(this) + "@" + hash.string;
        }
             
    }

`IdentifiableObject` implements the `hash` attribute and `equals()` method of
`Object`, which are very similar to the `equals()` and `hashCode()` methods 
defined by `java.lang.Object`.

Just like in Java, you can refine this default implementation in your own 
classes. This is the normal way to get a customized behavior for the `==` 
operator, the only constraint being, that for subtypes of 
`IdentifiableObject`, `x===y` should imply `x==y`— equality should be 
consistent with identity.

Thus, Ceylon is able to capture within the type system much of the behavior 
that Java introduces by fiat special-case rules in the language definition.

## Operator polymorphism

Ceylon discourages the creation of intriguing executable ASCII art. 
Therefore, true operator overloading is *not* supported by the language. 
Instead, almost every operator (every one except the primitive `.`, `()`, 
`is`, and `:=` operators) is considered a shortcut way of writing some more 
complex expression involving other operators and ordinary method calls. 
For example, the `<` operator is defined in terms of the interface 
[`Comparable<Other>`](#{site.urls.apidoc_current}/ceylon/language/interface_Comparable.html), 
which we met in the [lesson on types](../types), 
and which has a method named `compare()`.

<!-- check:none -->
    x<y

means, by definition,

<!-- check:none -->
    x.compare(y) === smaller

The equality operator `==` is defined in terms of the class `Object`, 
which has a method named `equals()`.

<!-- check:none -->
    x==y

means, by definition,

<!-- check:none -->
    x.equals(y)

Therefore, it's easy to customize operators like `<` and `==` with specific 
behavior for our own classes, just by implementing or refining methods 
like `compare()` and `equals()`. Thus, we say that operators are polymorphic 
in Ceylon.

Apart from `Comparable` and `Object`, which provide the underlying 
definition of comparison and equality operators, the following interfaces are 
also important in the definition of Ceylon's polymorphic operators:

* [`Summable`](#{site.urls.apidoc_current}/ceylon/language/interface_Summable.html) 
  supports the infix `+` operator,
* [`Invertable`](#{site.urls.apidoc_current}/ceylon/language/interface_Invertable.html) 
  supports the prefix `+` and `-` operators,
* [`Ordinal`](#{site.urls.apidoc_current}/ceylon/language/interface_Ordinal.html) 
  supports the unary `++` and `--` operators,
* [`Numeric`](#{site.urls.apidoc_current}/ceylon/language/interface_Numeric.html) 
  supports the other basic arithmetic operators,
* [`Comparable`](#{site.urls.apidoc_current}/ceylon/language/interface_Comparable.html) 
  supports the comparison operators,
* [`Correspondence`](#{site.urls.apidoc_current}/ceylon/language/interface_Correspondence.html) 
  supports the index operator, 
* [`Boolean`](#{site.urls.apidoc_current}/ceylon/language/class_Boolean.html)
  is the basis of the logical operators, and
* [`Set`](#{site.urls.apidoc_current}/ceylon/language/interface_Set.html) 
  is the basis of the set operators.


## Numeric types

As we've mentioned several times before, Ceylon doesn't have anything like 
Java's primitive types. The types that represent numeric values are just 
ordinary classes. Ceylon has fewer built-in numeric types than other C-like 
languages:

* [`Integer`](#{site.urls.apidoc_current}/ceylon/language/class_Integer.html) 
  represents signed integers,
* [`Float`](#{site.urls.apidoc_current}/ceylon/language/class_Float.html) 
  represents floating point approximations to the real numbers,

The number of bits or precision on these types depends on whether
you're compiling Ceylon code for Java or for JavaScript. When compiling for 
Java they have 64-bit precision by default. Eventually, you'll 
be able to specify that a value has 32-bit precision by annotating it 
`small`. But note that this annotation is really just a hint that the compiler 
is free to ignore (and it currently does).

## Numeric literals

In their simplest form the literals for `Integer`s, and 
literals for `Float`s look as you might expect from other languages:

    Integer one = 1;
    Float oneHundredth = 0.01;
    Float oneMillion = 1.0E+6;

However they can be a bit more sophistocated. The digits of a numeric literal 
may be grouped using underscores. If the 
digits are grouped, then groups must contain exactly three digits.

    Integer twoMillionAndOne = 2_000_001;
    Float pi = 3.141_592_654;

A very large or small numeric literals may be qualified by one of the 
standard SI unit prefixes: m, u, n, p, f, k, M, G, T, P.

    Float red = 390.0n; // n (nano) means E-9
    Float galaxyDiameter = 900.0P; // P (peta) means E+15
    Float hydrogenRadius = 25.0p; // p (pico) means E-12
    Float usGovDebt = 14.33T; // T (tera) means E+12
    Float brainCellSize = 4.0u; // u (micro) means E-6
    Integer deathsUnderCommunism = 94M; // M (mega) means E+6

## Numeric widening

As mentioned earlier, Ceylon doesn't have implicit type conversions, 
not even built-in conversions for numeric types. Assignment does not 
automatically widen (or narrow) numeric values. Instead, we need to call 
one of the operations (well, attributes, actually) defined by the interface 
[`Number`](#{site.urls.apidoc_current}/ceylon/language/interface_Number.html).

    Float zero = 0.float; // explicitly widen from Integer

You can use all the operators you're used to from other C-style languages 
with the numeric types. You can also use the `**` operator to raise a 
number to a power:

<!-- cat: void m(Float length, Float width) { -->
    Float diagonal = (length**2.0+width**2.0)**0.5;
<!-- cat: } -->

Of course, if you want to use the increment `++` operator, decrement `--` 
operator, or one of the compound assignment operators such as `+=`, you'll 
have to declare the value `variable`.

Since it's quite noisy to explicitly perform numeric widening in numeric 
expressions, the numeric operators automatically widen their operands, 
so we could write the expression above like this:

<!-- cat: void m(Float length, Float width) { -->
    Float diagonal = (length**2+width**2)**(1.0/2);
<!-- cat: } -->

Because `ceylon.language` only has two numeric types the only "built-in" 
widening conversion is from `Integer` to `Float`. But this 
conversions isn't defined by special-case rules in the 
language specification.


## Numeric operator semantics

Operators in Ceylon are, in principle, just abbreviations for some 
expression involving a method call. So the numeric types all implement the 
`Numeric` interface, refining the methods `plus()`, `minus()`, `times()`, 
`divided()` and `power()`, and the `Invertable` interface, refining `negativeValue`
and `positiveValue`. 
The numeric operators are defined in terms of these methods of `Numeric`. 
The numeric types also implement the interface 
[`Castable`](#{site.urls.apidoc_current}/ceylon/language/interface_Castable.html), 
which enables the widening conversions we just mentioned.

<!-- check:none:decl from ceylon.language -->
    shared interface Castable<in Types> {
        shared formal CastValue castTo<CastValue>()
            given CastValue satisfies Types;
    }

The type parameter `Types` uses a special trick. The argument to `Types` 
should be the union of all types to which the implementing type is castable.

For example, simplifying slightly the definitions in the language module:

<!-- check:none:decl from ceylon.language -->
    shared abstract class Integer()
            extends Object()
            satisfies Castable<Integer|Float> &
                      Integral<Integer> &
                      Numeric<Integer> {
        ...
    }
    
<!-- check:none:decl from ceylon.language -->
    shared abstract class Float()
            extends Object()
            satisfies Castable<Float> &
                      Numeric<Float> {
        ...
    }

These declarations tell us that `Integer` can be widened to `Float`, but that 
`Float` cannot be widened to anything. So we can 
infer that the expression `-1 * 0.4` is of type `Float`.

Therefore, the definition of a numeric operator like `*` can be represented, 
completely within the type system, in terms of `Numeric` and `Castable`:

<!-- check:none:pedagogical -->
    Result product<Left,Right,Result>(Left x, Right y)
            given Result of Left|Right satisfies Numeric<Result>
            given Left satisfies Castable<Result> & Numeric<Left>
            given Right satisfies Castable<Result> & Numeric<Right> {
        return x.castTo<Result>().times(y.castTo<Result>());
    }

Don't worry too much about the performance implications of all this — 
in practice, the compiler is permitted to optimize the types `Integer`, 
`Integer`, and `Float` down to the virtual machine's native numeric types.

The value of all this — apart from eliminating special cases in the language 
definition and type checker — is that a library can define its own 
specialized numeric types, without losing any of the nice language-level 
syntax support for numeric arithmetic and numeric widening conversions.


## There's more...

Next we're going to come back to the subject of [object initialization](../initialization), 
and deal with a subtle problem affecting languages like Java and C#.

