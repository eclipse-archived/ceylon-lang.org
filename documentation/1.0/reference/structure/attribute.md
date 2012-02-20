---
layout: reference
title: Attributes
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

An attribute holds state outside of a method.

## Usage 

    // in Foo.ceylon
    
    // A top level attribute declaration
    variable String firstName := "John";
    variable String lastName := "Doe";

    // An attribute getter
    shared String name {
        return firstName + " " + lastName;
    }
    
    // An attribute setter
    assign name {
        parts = name.split;
        firstName := parts.head;
        lastName = parts.tail;
    }

    

## Description

### Simple Attributes

Simple attributes are just holders of state. A simple attribute within a 
class body represents state associated with an instance of the class. A local 
attribute (that is, an attribute within a block) represents state associated 
with execution of that block.

If the attribute is annotated `shared` it can be 
[assigned](/documentation/reference/operator/assignment) more than once.
Otherwise it must be [specified](/documentation/reference/statement/specification) 
exactly once, moreover the specification must occur before its first use.

### Attribute Getters (derived attributes)

An attribute getter defines how the value of a derived attribute is obtained.

### Attribute Setters

An attribute setter defines how the value of a derived attribute is assigned.
Every attribute setter must have a corresponding getter with the same name. 
The getter declaration must occur earlier in the body containing the setter 
declaration.

### Type inference

The type of a [block local](TODO) attribute will be inferred by the compiler
if the keyword `value` is given in place of a type. In the example below the
`name` attribute's type is inferred to be `Name`:

    value name { 
        return Name(firstName, initial, lastName);
    }

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
