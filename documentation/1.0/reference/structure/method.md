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

<!-- cat: void anotherMethod(){} -->
    void m() = anotherMethod;

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
keyword `void` if the method has no return type.

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

### Parameter lists

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
that parameter. Parameters with default values may be called 
*optional* parameters, simiarly parameters without default values may be called
*required* parameters.

Syntactically default values are [expressions](../../#expression) separated from the 
parameter name with the equals specifier.

For example a method `m` declared like this

<!-- id:m -->
    void m(Integer i = 0) {
        /* method body: statements */
    }

can be [invoked](../../expression/invocation) without supplying an argument 
for the parameter `i`, like this:

<!-- cat-id:m -->
<!-- cat: void m2() { -->
    m();
<!-- cat: } -->

To avoid ambiguity, defaulted parameters are only permitted after all the 
non-defaulted parameters in the parameter list.

#### Sequenced parameter

A method may have a *sequenced parameter* (just one) as the last parameter 
in the parameter list. This allows the method to be 
[invoked](../../expression/invocation) with the caller specifying zero or 
more arguments after the next-to-last argument.

Syntactically sequenced parameters are declared as a type name followed by 
ellipsis (`...`) followed by the parameter name.

For example a method `m` declared like this

<!-- id:m -->
    void m(String s, Integer... i) {
        /* method body: statements 
           parameter i treated as an Integer[] */
    }

can be [invoked](../../expression/invocation) supplying a zero or more 
expressions for `i`, like this:

<!-- cat-id:m -->
    m("hello");
    m("hello", 1);
    m("hello", 1, 2);
    m("hello", 1, 2, 3);

Within the method block a sequenced parameter declared as `T...` has 
type [`T[]`](../type#Sequence).

#### Multiple parameter lists

TODO

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

The body of a method is composed of [statements](../../#statement).

The body of a non-`void` method must (*definitely return*)[TODO].

### Method specifiers

An alternative to providing a method block is to specify a callable 
expression using `=`:

<!-- cat: void anotherMethod(){} -->
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
