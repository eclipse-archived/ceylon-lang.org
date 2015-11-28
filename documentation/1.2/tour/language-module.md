---
layout: tour12
title: The language module
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the fourteenth part of the Tour of Ceylon. The [previous part](../comprehensions)
introduced comprehensions. We're now going to learn about Ceylon's 
_language module_ and some of the basic types it defines.

The language module is special, because it is referred to by the language
specification, and some language-level constructs are defined in terms of
the types it declares. Therefore, you can think of it as forming part of 
the language definition. In practice, the language module is implemented
in a mix of Ceylon and native (Java and JavaScript) code. Of course, we've
already met quite a few of the inhabitants of the language module, 
especially in [this chapter](../sequences).

## An overview of the language module

The module [`ceylon.language`](#{site.urls.apidoc_1_2}/index.html) 
contains classes and interfaces that are referred to in the language 
specification, other declarations *they* refer to, and a number of 
related useful functions and types. Let's meet the main characters.

Just like Java, Ceylon has a class named 
[`Object`](#{site.urls.apidoc_1_2}/Object.type.html).

<!-- try: -->
<!-- check:none:decl from ceylon.language -->
    "The abstract supertype of all types representing 
     definite values..."
    see (`class Basic`, `class Null`)
    shared abstract class Object() 
            extends Anything() {
        
        "Determine if two values are equal..."
        shared formal Boolean equals(Object that);
        
        "The hash value of the value..."
        shared formal Integer hash;
        
        "A developer-friendly string representing the 
         instance..."
        shared default String string
                => className(this) + "@" + hash.string;
        
    }

Ceylon's, `Object` *isn't* the root of the type system. An expression 
of type `Object` has a definite, well-defined, non-`null` value. As 
we've seen, Ceylon type system also has the class 
[`Null`](#{site.urls.apidoc_1_2}/Null.type.html), 
which is the type of `null`.

<!-- try: -->
<!-- check:none:decl from ceylon.language -->
    "The type of the [[null]] value. Any union type of form 
     `Null|T` is considered an _optional_ type, whose values
     include `null`. Any type of this form may be written as
     `T?` for convenience..."
    see (`value null`)
    shared abstract class Null() 
            of null
            extends Anything() {}

The object `null` is the only instance of this class.

Therefore, `Object` and `Null` share a superclass, named 
[`Anything`](#{site.urls.apidoc_1_2}/Anything.type.html).

<!-- try: -->
<!-- check:none:decl from ceylon.language -->
    "The abstract supertype of all types. A value of type 
     `Anything` may be a definite value of type [[Object]], or 
     it may be the [[null]] value. A method declared `void` is 
     considered to have the return type `Anything`..."
    shared abstract class Anything() 
            of Object | Null {}

All Ceylon types are assignable to `Anything`. Expressions of type `Anything` 
aren't useful for very much, since `Anything` has no members or operations. 
The one useful thing you can do with `Anything` is represent the signature of 
a method when you don't care about the return type, since a method declared 
`void` is considered to have return type `Anything`, as we saw in the 
[part about functions](../functions).

All types that represent well-defined values extend `Object`, including:

* user-written classes,
* all interfaces, including, 
* function types, and even
* the types that are considered primitive in Java, such as 
  [`Boolean`](#{site.urls.apidoc_1_2}/Boolean.type.html),
  [`Integer`](#{site.urls.apidoc_1_2}/Integer.type.html),
  [`Float`](#{site.urls.apidoc_1_2}/Float.type.html),
  [`Byte`](#{site.urls.apidoc_1_2}/Byte.type.html), and  
  [`Character`](#{site.urls.apidoc_1_2}/Character.type.html).

Since an expression of type `Object` always evaluates to a definite, 
well-defined value, it's possible to obtain the runtime type of an 
`Object`, or narrow an expression of type `Object` to a more specific 
type.

## Equality and identity

On the other hand, since `Object` is a supertype of types like `Float` 
which are passed by value at the level of the virtual machine, you 
can't use the `===` operator to test the identity of two values of type 
`Object`. The following is not allowed: 

    Integer x = 1;
    assert (x===1); //compile error: Integer is not Identifiable 

Instead, `===` is defined to act on instances of the interface 
[`Identifiable`](#{site.urls.apidoc_1_2}/Identifiable.type.html).
`Integer`, `Float`, `Character`, and `String` _don't_ satisfy this
interface, but most classes do.

<!-- try: -->
<!-- check:none:decl from ceylon.language -->
    "The abstract supertype of all types with a well-defined
     notion of identity. Values of type `Identifiable` may 
     be compared using the `===` operator to determine if 
     they are references to the same object instance..."
    shared interface Identifiable {
        
        "Identity equality comparing the identity of the two 
         values..."
        shared default actual Boolean equals(Object that) {
            if (is Identifiable that) {
                return this===that;
            }
            else {
                return false;
            }
        }
        
        "The system-defined identity hash value of the 
         instance..."
        see (`function identityHash`)
        shared default actual Integer hash => identityHash(this);
        
    }

`Identifiable` implements the `hash` attribute and `equals()` method of
`Object`, which are very similar to the `equals()` and `hashCode()` methods 
defined by `java.lang.Object`.

Just like in Java, you can refine this default implementation in your own 
classes. This is the normal way to get a customized behavior for the `==` 
operator, the only constraint being, that for subtypes of `Identifiable`, 
`x===y` should imply `x==y`— equality should be consistent with identity.

By default, a user-written class extends the class 
[`Basic`](#{site.urls.apidoc_1_2}/Basic.type.html), 
which extends `Object` and satisfies `Identifiable`. It's possible for a 
user-written class to directly extend `Object`, but most of the classes 
you write will be subclasses of `Basic`. All classes with `variable` 
attributes must extend `Basic`.

<!-- try: -->
<!-- check:none:decl from ceylon.language -->
    "The default superclass when no superclass is explicitly
     specified using `extends`..."
    shared abstract class Basic() 
            extends Object() satisfies Identifiable {}

## Operator polymorphism

Ceylon discourages the creation of intriguing executable ASCII art. 
Therefore, true operator overloading is *not* supported by the language. 
Instead, almost every operator (every one except the primitive `.`, `()`, 
`is`, `=`, `===`, and `of` operators) is considered a shortcut way of 
writing some more complex expression involving other operators and ordinary 
function calls.
 
For example, the `<` operator is defined in terms of the interface 
[`Comparable`](#{site.urls.apidoc_1_2}/Comparable.type.html), 
which has a method named `compare()`. The operator expression

<!-- try: -->
<!-- check:none -->
    x<y

means, by definition,

<!-- try: -->
<!-- check:none -->
    x.compare(y) === smaller

The equality operator `==` is defined in terms of the class `Object`, 
which has a method named `equals()`. So

<!-- try: -->
<!-- check:none -->
    x==y

means, by definition,

<!-- try: -->
<!-- check:none -->
    x.equals(y)

Therefore, it's easy to customize operators like `<` and `==` with specific 
behavior for our own classes, just by implementing or refining methods like 
`compare()` and `equals()`. Thus, we say that operators are _polymorphic_ 
in Ceylon.

Apart from `Comparable` and `Object`, which provide the underlying 
definition of comparison and equality operators, the following interfaces 
are also important in the definition of Ceylon's polymorphic operators:

* [`Summable`](#{site.urls.apidoc_1_2}/Summable.type.html) 
  supports the infix `+` operator,
* [`Invertible`](#{site.urls.apidoc_1_2}/Invertible.type.html) 
  supports the prefix and infix `-` operators,
* [`Ordinal`](#{site.urls.apidoc_1_2}/Ordinal.type.html) 
  supports the unary `++` and `--` operators,
* [`Numeric`](#{site.urls.apidoc_1_2}/Numeric.type.html) 
  supports the infix `*` and `/` operators,
* [`Exponentiable`](#{site.urls.apidoc_1_2}/Exponentiable.type.html) 
  supports the power operator `^`,
* [`Comparable`](#{site.urls.apidoc_1_2}/Comparable.type.html) 
  supports the comparison operators `<`, `>`, `<=`, `>=`, and `<=>`,
* [`Enumerable`](#{site.urls.apidoc_1_2}/Enumerable.type.html) 
  supports the range operators `..` and `:`,
* [`Correspondence`](#{site.urls.apidoc_1_2}/Correspondence.type.html) 
  supports the index operator, 
* [`Ranged`](#{site.urls.apidoc_1_2}/Ranged.type.html) 
  supports the subrange operators, 
* [`Boolean`](#{site.urls.apidoc_1_2}/Boolean.type.html)
  is the basis of the logical operators `&&`, `||`, `!`, and
* [`Set`](#{site.urls.apidoc_1_2}/Set.type.html) 
  is the basis of the set operators `|`, `&`, and, `~`.

## Comparison operators

In addition to the traditional `<`, `>`, `<=`, and `>=` operators, which 
evaluate to `Boolean`, there is a `<=>` operator, which produces an instance
of the enumerated type 
[`Comparison`](#{site.urls.apidoc_1_2}/Comparison.type.html).

<!-- try: -->
    switch(x<=>0)
    case (smaller) {
        return sqrt(-x);
    }
    case (equal) {
        return 0;
    }
    case (larger) {
        return sqrt(x);
    }

Two `<` or `<=` operators may be combined to determine if a value falls withing
a range:

<!-- try: -->
    assert(0<quantity<=100);

## Set operators

The operators `|` and `&` represent set union and intersection when they appear in a
value expression. But, as we've already seen, when they appear in a type expression 
they represent _type_ union and intersection! Indeed, there is a relationship between
the two kinds of union/intersection:

<!-- try: -->
    Set<Integer> integers = ... ;
    Set<Float> floats = ... ;
    Set<Float|Integer> numbers = integers | floats;

<br/>

<!-- try: -->
    Set<Foo> foos = ... ;
    Set<Bar> bars = ... ;
    Set<Foo&Bar> foobars = foos & bars;

The binary `~` operator represents complement (set subtraction).

## Indexed operations

We can access an element of a `Correspondence` by using the index operator. Both
`List`s and `Map`s are instances of `Correspondence`:

<!-- try: -->
    "string must start with a \""
    assert (exists ch = text[0], ch=='"');

All `List`s are also instances of `Ranged`. We can produce a subrange of a `Ranged` 
by providing two endpoints:

<!-- try: -->
    if (text[i..i]=="/") {
        [String,String] split = [text[...i-1], text[i+1...]];
        //...
    }

We can also produce a subrange of a `Ranged` by providing a starting point and a 
length.

<!-- try: -->
    String selectedText = text[selection.offset:selection.length];

Please take careful note the difference between `..` and `:`, they have quite distinct
purposes:

    print("hello"[2..2]); //prints "l"
    print("hello"[2:2]);  //prints "ll"

    print("hello"[2..0]); //prints "leh"
    print("hello"[2:0]);  //prints ""

## Characters and character strings

We've already met the class `String`, way back in 
[the first leg of the tour](../basics/#string_literals). Ceylon strings are composed of 
[`Character`](#{site.urls.apidoc_1_2}/Character.type.html)s&mdash;indeed, 
a `String` is a [`List`](#{site.urls.apidoc_1_2}/List.type.html)
of `Character`s.

A character literal is written between single quotes.

    Character[] latinLetters = concatenate('a'..'z', 'A'..'Z');
    Character newline = '\n';
    Character pi = '\{#0001D452}';

An instance of `Character` represents a 32-bit Unicode character, not a
Java-style UTF-16 `char`. However, under the covers, Ceylon strings are
implemented using a Java `char[]` array (in fact, they are implemented
using a Java string). So some operations on Ceylon strings are much
slower than you might expect, since they must take four-byte characters
into account. This includes `size` and `item()`. We think it's much better
that these operations be slow, like in Ceylon, than that they sometimes
give the wrong answer, like in Java. And
[remember](../sequences/#sequence_gotchas_for_java_developers), it's 
never correct to iterate a list using `size` and `item()` in Ceylon!

To avoid the cost of calling `size()`, try to use the more efficient
`empty`, `longerThan()` and `shorterThan()` when the string might be 
very long.

## Numeric types

As we've mentioned several times before, Ceylon doesn't have anything like 
Java's primitive types. The types that represent numeric values are just 
ordinary classes. Ceylon has fewer built-in numeric types than other C-like 
languages:

* [`Integer`](#{site.urls.apidoc_1_2}/Integer.type.html)
  represents signed integers, and
* [`Float`](#{site.urls.apidoc_1_2}/Float.type.html)
  represents floating point approximations to the real numbers.

However, the compiler magically eliminates these classes, wherever possible,
in order to take advantage of the high performance of the platform's native
primitive types.

Therefore, the precision of these types depends on whether you're running 
your code on the JVM or on a JavaScript virtual machine. 

- When compiling for Java both types have 64-bit precision by default. 
  Eventually, you'll be able to specify that a value has 32-bit precision 
  by annotating it `small`. But note that this annotation is really just a 
  hint that the compiler is free to ignore (as it currently does).
- When compiling for JavaScript, `Float`s have 64-bit precision and
  `Integer`s have 53-bit precision.

Overflow (on the JVM), or loss of precision (in JavaScript) occurs silently.

## Numeric literals

In their simplest form the literals for `Integer`s, and 
literals for `Float`s look as you might expect from other languages:

    Integer one = 1;
    Float oneHundredth = 0.01;
    Float oneMillion = 1.0E+6;

However they can be a bit more sophisticated. The digits of a numeric literal 
may be grouped using underscores. If the digits are grouped, then groups must 
contain exactly three digits.

    Integer twoMillionAndOne = 2_000_001;
    Float pi = 3.141_592_654;

A very large or small numeric literal may be qualified by one of the standard 
SI unit prefixes: `m`, `u`, `n`, `p`, `f`, `k`, `M`, `G`, `T`, `P`.

    Float red = 390.0n;                  // n (nano) means E-9
    Float galaxyDiameter = 900.0P;       // P (peta) means E+15
    Float hydrogenRadius = 25.0p;        // p (pico) means E-12
    Float usGovDebt = 14.33T;            // T (tera) means E+12
    Float brainCellSize = 4.0u;          // u (micro) means E-6
    Integer deathsUnderCommunism = 94M;  // M (mega) means E+6

A hexadecimal integer is written using a prefix `#`. Digits may be grouped 
into groups of two or four digits.

    Integer white = #FF_FF_FF;

A binary integer is written with a prefix `$`. Digits may be grouped into
groups of four digits.

    Integer sixtyNine = $0100_0101;

## Arbitrary precision numeric types

The platform module `ceylon.math` defines the types 

- [`Whole`](#{site.urls.apidoc_current_math}/whole/Whole.type.html) and 
- [`Decimal`](#{site.urls.apidoc_current_math}/decimal/Decimal.type.html), 

which represent arbitrary precision integers and arbitrary precision 
decimals. Both classes are subtypes of `Numeric`, so you can use all the 
usual numeric operators with them:

<!-- try: -->
    Decimal num = ... ;
    Decimal denom = ... ;
    Decimal ratio = num / denom;

Note that `ceylon.math` is currently JVM-only.

## Abstracting over numeric types

Since all numeric types are subtypes of `Numeric`, it's possible to write
generic code that treats numeric values polymorphically.

    Value ratio<Value>(Value num, Value denom) 
            given Value satisfies Numeric<Value>
            => num/denom;

You can pass `Float`s, `Integer`s, `Whole`s, `Decimal`s or any other numeric
type to `ratio()`. 

### Gotcha!

Since polymorphic numeric functions can't be optimized to use VM-level 
primitive types, when executed on the JVM, the generic function above is 
likely to be _much_ slower than a function which accepts two `Float`s or two 
`Integer`s. (On a JavaScript VM, you can expect a much smaller performance
penalty.)

## Numeric widening

As mentioned earlier, Ceylon doesn't have implicit type conversions, not even 
built-in conversions for numeric types. Assignment does not automatically 
widen (or narrow) numeric values. Instead, we usually need to call one of the 
operations (well, attributes, actually) defined by the interface 
[`Number`](#{site.urls.apidoc_1_2}/Number.type.html).

    Float zero = 0.float; // explicitly widen from Integer

You can use all the operators you're used to from other C-style languages 
with the numeric types. You can also use the `^` operator to raise a 
number to a power:

<!-- try-pre:
    Float length = 2.0;
    Float width = 1.5;
-->
<!-- cat: void m(Float length, Float width) { -->
    Float diagonal = (length^2.0+width^2.0)^0.5;
<!-- cat: } -->

Of course, if you want to use the increment `++` operator, decrement `--` 
operator, or one of the compound assignment operators such as `+=`, you'll 
have to declare the value `variable`.

Since it's quite noisy to explicitly perform numeric widening in numeric 
expressions, the numeric operators _do_ automatically widen their operands, 
so we could write the expression above like this:

<!-- try-pre:
    Float length = 2.0;
    Float width = 1.5;
-->
<!-- cat: void m(Float length, Float width) { -->
    Float diagonal = (length^2+width^2)^(1.0/2);
<!-- cat: } -->

Since `ceylon.language` only has two numeric types the only automatic 
widening conversion is from `Integer` to `Float`. This is the one and
only thing approaching an implicit type conversion in the whole language.

## Bytes

The class [`Byte`](#{site.urls.apidoc_1_2}/Byte.type.html) is very different 
from `byte`s in Java, C#, or C. A `Byte` is considered to represent a 
[congruence class](http://en.wikipedia.org/wiki/Modular_arithmetic) of 
integers modulo 256. That is to say, a `Byte` doesn't represent just one 
integer value, but a whole infinite set of them!

Therefore:

- the arithmetic operations on `Byte` are explicitly understood to be the 
  operations of modular arithmetic, not of ordinary integer arithmetic,
- there is no order for `Byte`s (they aren't `Comparable`), and
- it doesn't even make sense to ask if a `Byte` is signed or unsigned!

However, `Byte` has two very useful attributes: 

- `unsigned`, which returns a positive `Integer` in the range `0..255`, 
  and
- `signed`, which returns an `Integer` in the range `-128..127`. 

You'll need to use either `signed` or `unsigned` if you want to treat a
`Byte` value as an integer with integer arithmetic and integer ordering.

`Byte` is optimized by the compiler to a Java `byte` on the JVM, where
possible.

## Collections

The language module includes several interfaces that represent container
types:

- [`Collection`](#{site.urls.apidoc_1_2}/Collection.type.html),
- [`List`](#{site.urls.apidoc_1_2}/List.type.html),
- [`Map`](#{site.urls.apidoc_1_2}/Map.type.html), and
- [`Set`](#{site.urls.apidoc_1_2}/Set.type.html).

You might be disappointed to discover that there are no general-purpose 
implementations of these interfaces in the language module itself. In fact,
they're only declared here so that `String`, `Sequential`, 
[`Array`](#{site.urls.apidoc_1_2}/Array.type.html), and
[`Tuple`](#{site.urls.apidoc_1_2}/Tuple.type.html)
can be subtypes of `List`.

You might be even more disappointed when you look at these interfaces and
discover that they're missing half the useful operations you're used to 
seeing on a collection: they have no operations at all for building or
mutating the collection. Actually, there's a couple of good reasons for this:

- It's usually best for an API to return an obviously read-only collection
  to clients, instead of leaving the client scratching his head wondering
  whether mutating this collection results in mutation of the internal data 
  structures held by the API, and whether this is safe.
- Making these interfaces read-only means they can be declared 
  [covariant](../generics/#covariance_and_contravariance) in their type 
  parameters.  

The module `ceylon.collection` contains general-purpose implementations of
these interfaces, along with APIs for building and mutating collections:
[`MutableList`](#{site.urls.apidoc_current_collection}/MutableList.type.html), 
[`MutableMap`](#{site.urls.apidoc_current_collection}/MutableMap.type.html), 
and [`MutableSet`](#{site.urls.apidoc_current_collection}/MutableSet.type.html).

## There's more...

The language module isn't by itself a platform for building applications.
It's a minimal set of basic types that form part of the language definition
itself. The Ceylon SDK provides a set of platform modules&mdash;basic building
blocks for all sorts of programs&mdash;including
[ceylon.collection](https://herd.ceylon-lang.org/modules/ceylon.collection), 
[ceylon.file](https://herd.ceylon-lang.org/modules/ceylon.file),
[ceylon.process](https://herd.ceylon-lang.org/modules/ceylon.process),
[ceylon.dbc](https://herd.ceylon-lang.org/modules/ceylon.dbc),
[ceylon.json](https://herd.ceylon-lang.org/modules/ceylon.json),
[ceylon.math](https://herd.ceylon-lang.org/modules/ceylon.math),
[ceylon.unicode](https://herd.ceylon-lang.org/modules/ceylon.unicode),
[ceylon.net](https://herd.ceylon-lang.org/modules/ceylon.net),
[ceylon.logging](https://herd.ceylon-lang.org/modules/ceylon.logging),
[ceylon.test](https://herd.ceylon-lang.org/modules/ceylon.test),
[ceylon.time](https://herd.ceylon-lang.org/modules/ceylon.time),
[ceylon.regex](https://herd.ceylon-lang.org/modules/ceylon.regex),
[ceylon.transaction](https://herd.ceylon-lang.org/modules/ceylon.transaction),
[ceylon.promise](https://herd.ceylon-lang.org/modules/ceylon.promise), and
[ceylon.locale](https://herd.ceylon-lang.org/modules/ceylon.locale). 

Next we're going to come back to the subject of [object initialization](../initialization), 
and deal with a subtle problem affecting languages like Java and C#.
