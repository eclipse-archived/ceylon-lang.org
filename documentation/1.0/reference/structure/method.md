---
layout: reference
title: Methods
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

A method is a callable block of code.

## Usage 

A trivial method declaration using a [*block*](#method_blocks) (or *body*) 
looks like this:

    void m() {
        /* method block: statements */
    }
    
Alternatively it is possible to declare a method using 
[*fat arrow* (`=>`)](#method_specifiers), like this:

<!-- cat: void anotherMethod(){} -->
    void m() => anotherMethod();

## Description

### Local methods

[Local](../type#top_level_and_local_declarations) methods have a 
'receiver', which is the object the method is call on. Within the method
[*block*](#method_blocks) [this](../../expression/self-reference) refers to 
the method receiver.

### Top level methods

[Top level](../type#top_level_and_local_declarations) methods 
(or *functions*) do not have a *reciever*.

### Return type

A method declaration always specifies the *return type* of the method, or the 
keyword `void` if the method has no return value.

The type system considers a `void` method identically to a method declared to 
return `Anything`. In particular a `void` member method can actually 
be refined by a subtype to return a more specific type. The value actually 
returned from an unrefined `void` method is always `null`.

Method declarations often don't need to explictly declare a type, but can instead use 
[type inference](../type-inference) via the `function` keyword.

### Type parameters

A method declaration lists [type parameters](../type-parameters) with angle brackets (`<` and `>`) 
after the method name.

    void m<Z>(){
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

### Method blocks

The body of a method is composed of [statements](../../#statement) in a 
brace-delimited *block*.

The body of a non-`void` method must *definitely return*.

### Method specifiers

An alternative to providing a method block is to use *fat arrow* (`=>`) syntax 
and provide a single expression:

<!-- cat: void anotherMethod(){} -->
    Integer zero() => 0
    void callAnother() => anotherMethod();

Note that you can use this to *partially apply* a method:

    function zeroTo(Integer n) => Range(0, n);

### Type inference

The type of a [block local](TODO) method will be inferred by the compiler
if the keyword `function` is given in place of a type. 

### Invocation

See separate page on [method invocation](../../expression/invocation).

### Interception

TODO

## See also

* [Compilation unit](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
