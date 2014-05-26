---
layout: reference
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
    interface MyInterface() {
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

Types are formed by supplying type argument lists, and recursively 
applying the _union_ and _intersection_ operations, to type declaration 
or type alias references.

### Type declarations

In Ceylon, a *type declaration* is one of:

* A [`class` declaration](../class)
* An [`object` declaration](../object)
* An [`interface` declaration](../interface)

A [type parameter](../type-parameters) is also sometimes considered a
kind of type declaration. However, a type parameter may not declare
members.

#### Member declarations

A declaration that occurs directly in a type declaration is called a 
*member declaration*. Member [values](../value/) are called 
*attributes*. Member [functions](../function/) are called *methods*.

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

[`Null`](#{site.urls.apidoc_current}/Null.type.html) is the type of 
[`null`](#{site.urls.apidoc_current}/index.html#null). 
If an expression permits `null` then it
needs `Null` as a supertype. This is usually expressed as using a 
[union type](#union_types) such as `T|Null`, which can be abbreviated 
as `T?`.

### `Nothing`

[`Nothing`](#{site.urls.apidoc_current}/Nothing.type.html) 
is the intersection of *all* types. It is equivalent to the empty set.
Because `Nothing` is the intersection of all types it is assignable to 
all types. Similarly because it is the intersection of all types it can 
have no instances. It corresponds to the notion of an empty set in
mathematics.

### `Iterable`

[`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) 
is a type that produces instances of another type when iterated. 
`Iterable<T>` is usually abbreviated to `{T*}`.

### `Sequential`

[`Sequential`](#{site.urls.apidoc_current}/Sequential.type.html) 
is an enumerated type with subtypes 
[`Sequence`](#{site.urls.apidoc_current}/Sequence.type.html) and 
[`Empty`](#{site.urls.apidoc_current}/Empty.type.html). 
`Sequential<T>` is usually abbreviated to `T[]` or `[T*]`.

### `Empty`

[`Empty`](#{site.urls.apidoc_current}/Empty.type.html) is the type 
of the expression `[]`. 

### `Sequence`

[`Sequence`](#{site.urls.apidoc_current}/Sequence.type.html) is the 
type of non-empty sequences.
`Sequence<T>` is usually abbreviated to `[T+]`.

### `Tuple`

[`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html) is a subclass 
of `Sequence` (and thus cannot be empty). It differs from `Sequence` 
in that it encodes the types of each of its elements individually.

<!-- try: -->
    [Integer, Boolean, String] t = [1, true, ""];
    Integer first = t[0];
    Boolean second = t[1];
    String last = t[2];

Tuples also have a notion of 'variadicity':

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
abbreviated form is always used. 

### Metamodel

TODO

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [method declaration](../function)
* [attribute declaration](../value)
* [type abbreviations](../type-abbreviation)
* [type parameters](../type-parameters)
