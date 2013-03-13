---
layout: reference
title: Attributes
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

An attribute holds state.

## Usage 


A `variable` attribute declaration:

<!-- id:attr -->
    variable String? firstName = "John";
    variable String? lastName = "Smith";

An attribute getter:

<!-- id:attr2 -->
<!-- cat-id: attr -->
    // A getter with a block:
    shared String name {
        return (firstName ? "") + " " + (lastName ? "");
    }
    // A getter using 'fat arrow':
    shared String nameNormalized => name.normalized;
    
An attribute setter:

<!-- cat-id: attr -->
<!-- cat-id: attr2 -->
<!-- cat: String[] parseName(String? name) { throw; } -->
    assign name {
        value parts = parseName(name);
        firstName = parts[0];
        lastName = parts[1];
    }
    

## Description

### Simple Attributes

Simple attributes are just holders of state. A simple attribute within a 
class body represents state associated with an instance of the class. A local 
attribute (that is, an attribute within a block) represents state associated 
with execution of that block.

If the attribute is annotated `shared` it can be 
[assigned](#{page.doc_root}/reference/operator/assign) more than once.
Otherwise it must be [specified](#{page.doc_root}/reference/statement/specification) 
exactly once, moreover the specification must occur before its first use.

### Attribute Getters (derived attributes)

An attribute getter defines how the value of a derived attribute is obtained. 
Like methods, you can either use a block of statements or the *fat arrow*
(`=>`) syntax if the attribute value can be computed from a single expression.

### Attribute Setters

An attribute setter defines how the value of a derived attribute is assigned.
Every attribute setter must have a corresponding getter with the same name. 
The getter declaration must occur earlier in the body containing the setter 
declaration.

### Type inference

Attribute declarations often don't need to explictly declare a type, 
but can instead use 
[type inference](../type-inference) via the `value` keyword.

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
