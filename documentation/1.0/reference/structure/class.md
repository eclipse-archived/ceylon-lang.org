---
layout: reference
title: Class
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

A class is a stateful type that can be 
[instantiated](../../expression/instantiation).

## Usage 

A trivial class declaration looks like this:

    class C() {
        /* declarations of class members */
    }

## Description

### Initializer

The class *initializer* executes when instances of the class are created
(also known as [*class instantiation*](../../expression/instantiation)). 
The parameters to the initializer are specified in parenthesis after the 
name of the class in the `class` declaration.

### Extending classes

A class `S` is declared as a subclass of another class `C` using the `extends` 
keyword like this:

    class S() extends C() {
        /* declarations of class members */
    }

If a class is declared without using the `extends` keywords it is a subclass of
[`IdentifiableObject`](TODO).

Note that the arguments to the superclasses [initializer](#initializer) are 
specified in parenthesis after the name of the superclass in the `extends` 
clause. 

### Satisfying interfaces

A class can satisfy zero or more [interfaces](../interface) using the 
`satisfies` keyword. If the class `C` is to satisfy interfaces `I1` and `I2` the 
declaration looks like this:

    class C() satisfies I1 & I2 {
        /* declarations of class members */
    }

`&` is used as the separator between satisfied interfaces because `C` is 
satisfying a type, the 
[intersection type](../type#intersection_types) `I1&I2`.

### Abstract classes

A class declaration may be annotated `abstract`, like this:

    abstract class C() {
        /* declarations of class members */
    }

Abstract classes cannot be [instantiated](../../expression/instantiation).

### Shared classes

A class declaration may be annotated `shared`,like this:

    shared class C() {
        /* declarations of class members */
    }



### Formal and default classes

Toplevel classes may not be annotated `formal` or `default`.

### Enumerated classes

The subclasses of a class can be constrained to a list of named classes
using the `of` clause. If the class `C` is permitted only two direct 
subclasses `S1` and `S2` its declaration would look like this:

    class C() of S1 | S2 {
        /* declarations of class members */
    }
    
### Type parameters

A 

### Aliases

A class alias is a class declaration that specifies another class, like this:

    class C() = B;

The specified class may be parameterized by types:

    class C() = D<E>;

This is similar to [method specifiers](../method#method_specifiers).

The [`import` statement](../../statement/import) permits aliasing in a 
similar way.

### Members

The permitted members of classes are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
[attributes](../attribute)
and [`object`s](../object).

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
