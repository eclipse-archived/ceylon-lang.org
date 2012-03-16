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
    
Alternatively it is possible to declare a method using a 
[*specifier*](#method_specifiers), like this:

    void m() = anotherMethod;

## Description

### Return type

A method declaration always specifies the *return type* of the method, or the 
keyword `void` if the method has no return type.

### Type Parameters

Methods, like types, may be declared with type parameters:

    void m<X,Y>(){
    }

Of course, methods may be members of types which themselves have type 
parameters:

    class C<Z>() {
        void m(Z) {
        }
    }

### Parameters

Methods may have zero or more *parameters* (called *arguments* when the method is 
[invoked](../../expression/invocation)). Syntactically the method parameters 
are a comma separated list enclosed in parenthses following 
the [type parameters](#type_parameters). Each parameter is composed of a 
type expression and a name. 

For example a method taking an Integer parameter `i` and a parameter `b` 
whose type is a type parameter `<Z>` looks like this:

    void m<Z>(Integer i, Z b) {
        /* method body: statements */
    }


#### Defaulted parameters

A default value for a parameter may be specified. This allows the method to 
be [invoked](../../expression/invocation) without passing an argument for 
that parameter.

For example a method `m` declared like this

    void m(Integer i = 0) {
        /* method body: statements */
    }

can be called without suppliying an argument for the parameter `i`, like this:

    m();

Default values are [expressions](../../#expression) separated from the 
parameter name with the equals specifier.

#### Sequenced parameters

TODO

#### Multiple parameter lists

TODO

### Exceptions

Celyon doesn't have 'checked' exceptions, so it is not necessary to declare 
what exceptions a method can [throw](../../statement/throw).

The `throws` annotation may be used to *document* thrown exceptions.

### Method blocks

The body of a method is composed of [statements](../../#statement).

The body of a non-`void` method must (*definitely return*)[TODO].

### Method specifiers

An alternative to providing a method block is to specify a callable 
expression using `=`:

    void m() = anotherMethod;

This is similar to [class alises](../class#aliases).

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
