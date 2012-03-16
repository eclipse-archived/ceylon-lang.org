---
layout: reference
title: Types
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
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

#### Top-level and local declarations

A *top level* declaration is contained directly in a
[compilation units](../compilation unit) and not contained within any other
declaration. 

A *local* (or *nested*) declaration is a declaration that is 
contained within another declaration or a statement.

### Union types

Given type expressions `X` and `Y`, Ceylon lets you express the union of 
instances of those types using the notation `X|Y`. For example:

    variable String|Integer x:= "";
    x:= 0;

### Intersection types

Given type expressions `X` and `Y`, Ceylon lets you express the 
intersection of instances of those types using the notation `X&Y`.

### Enumerated types

TODO 

### `Bottom`

`Bottom` in the intersection of *all* types. It is equivalent to the empty set.
Because `Bottom` is the intersection of all types it is assignable to 
all types. Similarly because it is the intersection of all types it can have 
no instances.

### `Nothing`

`Nothing` is the type of `null`. If an expression permits `null` then its 
needs `Nothing` as a supertype. This is usually expressed as using a 
[union type](#union_types) such as `T|Nothing`, which can be abbreviated 
as `T?`.

### Type inference

Local declarations don't need to explictly declare a type, they can let the 
compiler infer the type from the expression. Because the type system is based 
on *principal types* there is only one type the compiler can infer.

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
