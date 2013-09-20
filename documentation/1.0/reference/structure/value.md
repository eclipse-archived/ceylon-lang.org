---
layout: reference
title: Values and attributes
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

A value can hold state. When it is a member of a 
type is it called an attribute.

## Usage 

A `variable` value declaration:

<!-- id:attr -->
<!-- try: -->
    variable String? firstName = "John";
    variable String? lastName = "Smith";

A value getter:

<!-- id:attr2 -->
<!-- cat-id: attr -->
<!-- try: -->
    // A getter with a block:
    shared String name {
        return (firstName ? "") + " " + (lastName ? "");
    }
    // A getter using 'fat arrow':
    shared String nameNormalized => name.normalized;
    
A value setter:

<!-- cat-id: attr -->
<!-- cat-id: attr2 -->
<!-- cat: String[] parseName(String? name) { throw; } -->
<!-- try: -->
    assign name {
        value parts = parseName(name);
        firstName = parts[0];
        lastName = parts[1];
    }
    

## Description

### Attributes

An *attribute* is a value that is a member of a type.

The term *value* can be used to mean all values (including attributes), or
just top-level and local values (excluding attributes). If it is not obvious 
from context we try to be explicit.

### Simple Values

Simple values are just holders of state. A simple attributes within a 
class body represents state associated with an instance of the class. A local 
value (that is, an attribute within a block) represents state associated 
with execution of that block.

If the value is annotated [`variable`](#{site.urls.apidoc_current}/index.html#variable) it can be 
[assigned](#{page.doc_root}/reference/operator/assign) more than once.
Otherwise it must be [specified](../../statement/specification) 
exactly once, moreover the specification must occur before its first use.

### Getters

A value getter is a value that is calculated when needed, rather than retrieved from memory.

From accessor's point of view it is impossible to know whether a value is a 
implemented as a simple value or as a getter. For example, it is possible to 
refine a simple attribute with a getter, or vice versa.

Like functions, you can either use a block of statements or the *fat arrow*
(`=>`) syntax if the value can be computed from a single expression.

### Setters

A value setter defines what to do when a `variable` value is assigned.

From accessor's point of view it is impossible to know whether a value is a 
implemented as a simple value or as a setter. For example, it is possible to 
refine a simple attribute with a getter/setter pair, or vice versa.

Every value setter must have a corresponding `variable` getter with the same name. 

The getter declaration must occur earlier in the body containing the setter 
declaration.

### Type inference

Value declarations often don't need to explictly declare a type, 
but can instead use 
[type inference](../type-inference) via the `value` keyword.

### `late` values

A value can be declared [`late`](../../annotation/late/) 
in which case the typechecker's
[definite specification](../../annotation/late/#description) checks are not performed. 

### Metamodel

Value declarations can be manipulated at runtime via their representation as
[`ValueDeclaration`](#{site.urls.apidoc_current}/meta/declaration/ValueDeclaration.type.html) 
instances. An *applied function* (i.e. with all type parameters specified) corresponds to 
either a 
[`Value`](#{site.urls.apidoc_current}/meta/model/Value.type.html) or 
[`Attribute`](#{site.urls.apidoc_current}/meta/model/Attribute.type.html) model instance.

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
