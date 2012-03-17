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
[instantiated](../../expression/class-instantiation).

## Usage 

A trivial class declaration looks like this:

<!-- id:c -->
    class C() {
        /* declarations of class members */
    }


## Description

### Initializer

The class *initializer* executes when instances of the class are created
(also known as [*class instantiation*](../../expression/class-instantiation)). 
The parameters to the initializer are specified in parenthesis after the 
name of the class in the `class` declaration.

### Extending classes

A class `S` is declared as a subclass of another class `C` using the `extends` 
keyword like this:

<!-- cat-id:c -->
    class S() extends C() {
        /* declarations of class members */
    }

If a class is declared without using the `extends` keywords it is a subclass of
[`IdentifiableObject`](#{site.urls.apidoc_current}/ceylon/language/class_IdentifiableObject.html).

Note that the arguments to the superclasses [initializer](#initializer) are 
specified in parenthesis after the name of the superclass in the `extends` 
clause. 

### Satisfying interfaces

A class can satisfy zero or more [interfaces](../interface) using the 
`satisfies` keyword. If the class `C` is to satisfy interfaces `I1` and `I2` the 
declaration looks like this:

<!-- cat: interface I1 {} interface I2 {} -->
    class C() satisfies I1 & I2 {
        /* declarations of class members */
    }

`&` is used as the separator between satisfied interfaces because `C` is 
satisfying a type, the 
[intersection type](../type#intersection_types) `I1&I2`.

### Enumerated classes

The subclasses of an `abstract` class can be constrained to a list of named 
classes or toplevel anonymous classes using the `of` clause. 
If the class `C` is permitted only two direct 
subclasses `S1` and `S2` its declaration would look like this:

    abstract class C() of S1 | S2 {
        /* declarations of class members */
    }
<!-- cat: class S1() extends C() {} -->
<!-- cat: class S2() extends C() {} -->

### Type parameters

A class declaration lists [type parameters](../type-parameters) with angle brackets (`<` and `>`) 
after the class name. 

    class C<Z>() {
        /* declarations of class members 
           type parameter Z treated as a type */
    }

A class declaration with type parameters may have a `given` clause for each declared type parameter 
to [constraint the permitted type argument](../type-parameters#constraints).

### Concrete classes

A class that can be [instantiated](../../expression/class-instantiation) is 
*concrete*. It follows that `abstract` or `formal` classes are not concrete.

### Abstract classes

A class declaration may be annotated `abstract`, like this:

    abstract class C() {
        /* declarations of class members */
    }

Abstract classes cannot be [instantiated](../../expression/class-instantiation).

Abstract classes may have `formal` members. 

### Shared classes

A class declaration may be annotated `shared`,like this:

    shared class C() {
        /* declarations of class members */
    }

A top-level `shared` class is visible wherever the package that contains it is 
visible.

A member `shared` class is visible wherever the class or interface that 
contains it is visible.

### Formal classes

Toplevel classes may not be annotated `formal`.

Formal classes cannot be [instantiated](../../expression/class-instantiation).

A `formal` class may have `formal` members.

A block local class may not be annotated `formal`.

### Default classes

A class may be annotated `default` is it is contained in a concrete `shared` 
class or interface.

A block local class may not be annotated `formal`.

### Members

The permitted members of classes are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
[attributes](../attribute)
and [`object`s](../object).

### Aliases

A *class alias* is a class declaration that specifies another class, like this:

<!-- cat: class B() {} -->
    class C() = B;

The specified class may have type arguments:

<!-- cat: class D<X>() {} -->
    class C() = D<String>;

This is similar to [method specifiers](../method#method_specifiers).

The [`import` statement](../../statement/import) permits aliasing in a 
similar way.

## See also


