---
layout: reference
title_md: Functions and methods
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A _function_ accepts _arguments_ and returns a value.

When a function is a member of a type is it called a _method_.

## Usage 

A trivial function declaration using a [block](#function_blocks) 
looks like this:

<!-- try: -->
    void m() {
        /* method block: statements */
    }
    
Alternatively it's possible to declare a function using 
[fat arrow](#function_specifiers), `=>`, like this:

<!-- cat: void anotherMethod(){} -->
<!-- try: -->
    void m() => anotherMethod();

## Description

### Method receiver

Method invocations have a 'receiver', an instance of the type that declares 
the method. Within the method [body](#method_blocks), the expression 
[`this`](../../expression/this) refers to this receiving instance.

A [top level](../type#top_level_declarations) function does not have a 
receiver. 

### Return type

A function declaration always specifies the *return type* of the function, 
or the keyword `void` if the function has no specific return value.

The type system considers a `void` function identical to a function declared 
to return [`Anything`](#{site.urls.apidoc_1_0}/Anything.type.html). 
In particular, a `void` method may be refined by a subtype to return a more 
specific type. The value actually returned from an unrefined `void` function 
is always `null`.

### Callable type

The *callable type* of a function expresses, in terms of the 
[`Callable`](#{site.urls.apidoc_1_0}/Anything.type.html) interface, the 
function's return type and parameter types. For example, the callable type 
of:

<!-- try: -->
    String stringExample(Integer i, Boolean b) => "";
    
is `String(Integer, Boolean)`, and the callable type of:

<!-- try: -->
    void voidExample() {}
    
is `Anything()`.

### Type parameters

A _generic_ function declaration lists [type parameters](../type-parameters) 
in angle brackets (`<` and `>`) after the function name.

<!-- try: -->
    void f<Z>(){
        /* method block: statements 
           type parameter Z treated as a type */
    }

Of course, methods may be members of types which themselves have
[type parameters](../type-parameters):

<!-- try: -->
    class C<Z>() {
        void m(Z z) {
        }
    }

A function declaration with type parameters may have a `given` clause 
for each declared type parameter to 
[constrain the argument types](../type-parameters#constraints).

### Parameter list

A function declaration must have one or more 
[parameter lists](../parameter-list).

### Exceptions

Ceylon doesn't have _checked exceptions_, so it's never necessary to declare 
what exceptions a method can [throw](../../statement/throw).

The [`throws` annotation](../../annotation/throws) may be used to *document* 
thrown exceptions.

### `formal` and `default` methods

A method declaration may be annotated [`formal`](../../annotation/formal)
or [`default`](../../annotation/default). A formal or default method must 
also be annotated `shared`.

A formal method does not specify an implementation. A formal method must
be refined by concrete classes which inherit the containing class or 
interface. 

A `default` method may be refined by types which inherit the containing 
class or interface. 

### `shared` functions

A toplevel function declaration, or a function declaration nested inside the 
body of a containing class or interface, may be annotated 
[`shared`](../../annotation/shared).

- A toplevel `shared` function is visible wherever the package that contains 
  it is visible.
- A `shared` function nested inside a class or interface is visible wherever 
  the containing class or interface is visible.

### Function blocks

The body of a function may be composed of [statements](../../#statement) in a 
brace-delimited *block*.

The body of a non-`void` function must *definitely return* a value. The 
following code will be rejected by the compiler:

    String fun(Boolean bool) {
        if (bool) {
            return "hello";
        }
    }

### Function specifiers

A block with a return statement is unnecessarily verbose for a function that
just evaluates an expression. In this case, we prefer to use the *fat arrow* 
(`=>`) syntax:

<!-- cat: void anotherFunction(){} -->
<!-- try: -->
    Integer zero() => 0
    void callAnother() => anotherFunction();

Note that you can use this to *partially apply* a function (or any `Callable`):

    function zeroTo(Integer n) => Range(0, n);

### Type inference

Local function declarations often don't need to explictly declare a type, 
but can instead use [type inference](../type-inference) via the `function` 
keyword.

<!-- try: -->
    class C() {
        function f() => 0; //inferred type Integer
    }

### Metamodel

Function declarations can be manipulated at runtime via their representation as
[`FunctionDeclaration`](#{site.urls.apidoc_1_0}/meta/declaration/FunctionDeclaration.type.html) 
instances. An *applied function* (i.e. with all type parameters specified) corresponds to 
either a 
[`Function`](#{site.urls.apidoc_1_0}/meta/model/Function.type.html) or 
[`Method`](#{site.urls.apidoc_1_0}/meta/model/Method.type.html) model instance.

## See also

* [Method invocation](../../expression/invocation)
* [Compilation unit](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [Functions](#{site.urls.spec_current}#classes) in the Ceylon language spec

