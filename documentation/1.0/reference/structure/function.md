---
layout: reference
title: Functions and methods
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A function is a callable block of code. When it is a member of a 
type is it called a method.

## Usage 

A trivial function declaration using a [*block*](#function_blocks) (or *body*) 
looks like this:

    void m() {
        /* method block: statements */
    }
    
Alternatively it is possible to declare a function using 
[*fat arrow* (`=>`)](#function_specifiers), like this:

<!-- cat: void anotherMethod(){} -->
    void m() => anotherMethod();

## Description

### Methods

A *method* is a function which is a *member* of a type. 
The term *function* can be used to mean all functions (including methods), or
just top-level and local functions (excluding methods). If it is not obvious 
from context we try to be explicit.

### Method receiver

Methods have a 
'receiver', which is the type instance the method is called on. Within the method
[*block*](#method_blocks) [this](../../expression/self-reference) refers to 
the receiving instance.

[Top level](../type#top_level_declarations) and 
[local](../type#local_declarations) functions
do not have a *reciever*.

### Return type

A function declaration always specifies the *return type* of the function, or the 
keyword `void` if the function has no return value.

The type system considers a `void` function identically to a function declared to 
return `Anything`. In particular a `void` method can actually 
be refined by a subtype to return a more specific type. The value actually 
returned from an unrefined `void` function is always `null`.

Function declarations often don't need to explictly declare a type, but can instead use 
[type inference](../type-inference) via the `function` keyword.

### Type parameters

A function declaration lists [type parameters](../type-parameters) with angle brackets (`<` and `>`) 
after the function name.

    void f<Z>(){
        /* method block: statements 
           type parameter Z treated as a type */
    }

Of course, methods may be members of types which themselves have
[type parameters](../type-parameters):

    class C<Z>() {
        void m(Z z) {
        }
    }

### Generic constraints

A method declaration may have a `given` clause for each declared type parameter 
to [constraint the permitted type argument](../type-parameters#constraints).

### Parameter list

A method declaration requires a [parameter list](../parameter-list)


### Exceptions

Celyon doesn't have 'checked' exceptions, so it is not necessary to declare 
what exceptions a method can [throw](../../statement/throw).

The `throws` annotation may be used to *document* thrown exceptions.

### Abstract methods

TODO

### Shared methods

TODO

### Formal and default methods

TODO

### Function blocks

The body of a function is composed of [statements](../../#statement) in a 
brace-delimited *block*.

The body of a non-`void` function must *definitely return*.

### Function specifiers

An alternative to providing a method block is to use *fat arrow* (`=>`) syntax 
and provide a single expression:

<!-- cat: void anotherFunction(){} -->
    Integer zero() => 0
    void callAnother() => anotherFunction();

Note that you can use this to *partially apply* a function (or any `Callable`):

    function zeroTo(Integer n) => Range(0, n);

### Type inference

The type of a [block local](TODO) method will be inferred by the compiler
if the keyword `function` is given in place of a type. 

### Invocation

See separate page on [method invocation](../../expression/invocation).

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
