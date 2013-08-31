---
layout: reference
title: Types
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Usage 

Types are explicit in Ceylon source code at every declaration that is not
[inferred](#type_inference).

## Description

Ceylon is a *statically typed* language. This means that the type of 
every expression is known at compile time and the compiler uses this 
information to prevent typing errors.

Moreover the type system is based on 
*principal types*, which means every expression has a unique, *most specific* 
type.

### Type declarations

In Ceylon, a *type declaration* is one of:

* A [`class` declaration](../class)
* An [`object` declaration](../object)
* An [`interface` declaration](../interface)

#### Local declarations

A *local* (or *nested*) declaration is a declaration that is 
contained within another declaration or a statement.

#### Top-level declarations

A *top level* declaration is contained directly in a
[compilation unit](../compilation-unit) and not contained within any other
declaration. In other words a top level declaration is not 
a [local](#local_declarations) declaration.

### Union types

Given type expressions `X` and `Y`, Ceylon lets you express the union of 
instances of those types using the notation `X|Y`. For example:

<!-- cat: void m() { -->
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

You can define an alias for a type using the `alias` keyword:

    alias BasicType = String|Character|Integer|Float|Boolean;
    
It is also possible to define [class aliases](../class#aliases)
 and [interface aliases](../interface#aliases) 
 using an assignment, for example:

    interface Strings = Collection<String>;

    
### `Null`

`Null` is the type of `null`. If an expression permits `null` then it
needs `Null` as a supertype. This is usually expressed as using a 
[union type](#union_types) such as `T|Null`, which can be abbreviated 
as `T?`.

### `Nothing`

`Nothing` is the intersection of *all* types. It is equivalent to the empty set.
Because `Nothing` is the intersection of all types it is assignable to 
all types. Similarly because it is the intersection of all types it can have 
no instances.

### `Sequential`

`Sequential` is an enumerated type with subtypes `Sequence` and `Empty`
`Sequential<T>` is usually abbreviated to `T[]`.

### `Empty`

`Empty` is the type of the 
[expression `[]`](../../expression/sequence-instantiation). 

### `Sequence`

`Sequence` is the type of non-empty 
[sequences](../../expression/sequence-instantiation).

### `Tuple`

`Tuple` is a subclass of `Sequence` (and thus cannot be empty). It differs from 
`Sequence` in that the typechecker knows types of each of its elements 
individually.

    [Integer, Boolean, String] t = [1, true, ""];
    Integer first = t[0];
    Boolean second = t[1];
    String last = t[2];

Tuples also have a notion of 'variadicity':

    // A tuple of at least two elements
    // the first is an Integer and 
    // the rest are Boolean
    [Integer, Boolean+] t = [1, true, false];
    // A tuple of at least element
    // the first is an Integer and 
    // the rest are Boolean
    [Integer, Boolean*] t2 = t;

`Tuple`s thus have the same assignability rules as do 
positional argument list and parameter lists.

Unabreviated tuple types are extremely verbose, and therefore the abbreviated 
form is strongly preferred. 

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [method declaration](../method)
* [attribute declaration](../attribute)
* [type abbreviations](../type-abbreviation)
* [type parameters](../type-parameters)
