---
layout: reference11
title_md: Types and type declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

## Usage 

A _type declaration_ introduces a new type or 
[type constructor](../type-parameters).

<!-- try: -->
    class MyClass(name) {
        shared String name;
    }

<!-- try: -->
    interface MyInterface {
        shared formal String name;
    }

<!-- try: -->
    object myObject {
        shared String name = "Trompon";
    }

## Description

Ceylon is a *statically typed* language. This means that the type of 
every expression is known at compile time and the compiler uses this 
information to prevent typing errors.

Moreover the type system is based on *principal types*, which means 
every expression has a unique, *most specific* type, expressible within 
the language.

In general, types are formed by supplying type argument lists, and recursively 
applying the _union_ and _intersection_ operations, to type declaration 
or type alias references.

For example, consider the classes

    class Simple() {
    }
    class Generic<Parameter>() {
    }
    
Then the expression `Simple()` (which creates an instance of 
the class `Simple`) has the type `Simple`. On the other hand
`Generic`, having the type parameter `Parameter`, requires 
a type argument before it has a type. Thus 
`Generic<Integer>()` has the type `Generic<Integer>` and
`Generic<String>()` has the type `Generic<String>`. 
`Generic` is therefore a type constructor 
(we can construct new types from it, by supplying different 
type arguments).

### Type declarations

In Ceylon, a *type declaration* is one of:

* A [`class` declaration](../class)
* An [`object` declaration](../object)
* An [`interface` declaration](../interface)

A [type parameter](../type-parameters) is also sometimes considered a
kind of type declaration. However, a type parameter may not declare
members.

Function and value declarations to not introduce new types or 
type constructors.

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

### Union types

Given type expressions `X` and `Y`, Ceylon lets you express the union of 
instances of those types using the notation `X|Y`. For example:

<!-- cat: void m() { -->
<!-- try: -->
    variable String|Integer x = "";
    x = 0;
<!-- cat: } -->

### Intersection types

Given type expressions `X` and `Y`, Ceylon lets you express the 
intersection of instances of those types using the notation `X&Y`.

### Enumerated types

Classes can [enumerate](../class#enumerated_classes) 
a list of their permitted subclasses. 

Interfaces can [enumerate](../interface#enumerated_subtypes) 
a list of their permitted subtypes. 

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
