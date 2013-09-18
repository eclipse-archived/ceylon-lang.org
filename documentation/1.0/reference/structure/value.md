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
    variable String? firstName = "John";
    variable String? lastName = "Smith";

A value getter:

<!-- id:attr2 -->
<!-- cat-id: attr -->
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

If the value is annotated `variable` it can be 
[assigned](#{page.doc_root}/reference/operator/assign) more than once.
Otherwise it must be [specified](#{page.doc_root}/reference/statement/specification) 
exactly once, moreover the specification must occur before its first use.

### Getters (derived values)

A value getter is a value that is calculated when needed, rather than retrieved from memory.

From accessor's point of view it is impossible to know whether a value is a 
implemented as a simple value or as a getter. For example, it is possible to 
refine a simple attribute with a getter, or vice versa.

Like functions, you can either use a block of statements or the *fat arrow*
(`=>`) syntax if the value can be computed from a single expression.

### Attribute Setters

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

A value can be declared `late` in which case the typechecker's
definite specification checks are not performed. Instead code is generated 
which performs a runtime check for accessing the value when it hasn't 
been initialized (and re-initializing a
non-`variable` value that has already been initialized). 

This is intended to permit cyclic references between values, for example:

    class Child() {
        shared late Parent parent;
    }
    class Parent(children) {
        shared Child* children;
        for (child in children) {
            child.parent = this;
        }
    }

Only simple values may be annotated `late` 
(it doesn't make sense for value getters). 

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
