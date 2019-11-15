---
layout: reference13
title_md: Function and method declarations
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
    void trivialBlock() {
        /* method block: statements */
    }
    
Alternatively it's possible to declare a function using 
[fat arrow](#function_specifiers), `=>`, like this:

<!-- try: -->
    void trivialSpecifier() => anotherMethod();

The general form of a function declaration looks like either of these:

<!-- lang:none -->
    ANNOTATIONS
    TYPE exampleBlock
            <TYPE-PARAMETERS>
            PARAMETER-LISTS
            given TYPE-PARAMETER-CONSTRAINTS {
        FUNCTION-BODY
    }
    // or
    ANNOTATIONS
    TYPE exampleSpecifier
            <TYPE-PARAMETERS>
            PARAMETER-LISTS
            given TYPE-PARAMETER-CONSTRAINTS 
        => EXPRESSION;

Where:

* `ANNOTATIONS` is a list of function [annotations](../annotation)
* `TYPE` is a [type expression](../type) for the reference returned from 
  the function when it is invoked (or `void`).
* `TYPE-PARAMETERS` is a `,`-separated list of 
  [type parameters](../#type_parameters)
* `PARAMETER-LISTS` is one or more `,`-separated list of 
  [value parameters](../parameter-list), each list enclosed in parentheses
* `TYPE-PARAMETER-CONSTRAINTS` is a list of 
  [constraints on type parameters](../type-parameters#constraints) 
  declared in the type parameter list
* `FUNCTION-BODY` is [block](#function_blocks) of statements
* `EXPRESSION` is [specified result](#function_specifiers) of the function

## Description

### Method receiver

Method invocations have a _receiver_, an instance of the type that declares 
the method. Within the method [body](#method_blocks), the expression 
[`this`](../../expression/this) refers to this receiving instance.

A [top level](../type-declaration#top_level_declarations) function does not 
have a receiver. 

### Return type

A non-local function declaration always specifies the *return type* of the 
function, or the keyword `void` if the function has no specific return value. 

The type system considers a `void` function identical to a function declared 
to return [`Anything`](#{site.urls.apidoc_1_3}/Anything.type.html). In 
particular, a `void` method may be refined by a subtype to return a more 
specific type. The value actually returned from an unrefined `void` function 
is always `null`:

    class Top() {
        shared default void m() {}
    }
    class Sub() extends Top() {
        shared actual Boolean m() => true
    }
    void example() {
        Anything topM = Top().m(); // topM is null
        Boolean subM = Sub().m();
    }
    
#### Type inference

Local function declarations often don't need to explictly declare a type, 
but can instead use [type inference](../type-inference) via the `function` 
keyword.

<!-- try: -->
    class C() {
        function f() => 0; //inferred type Integer
    }

If the local function doesn't return a value `void` is used instead of 
`function`.

### Type parameters

A function declaration may have a list of 
[type parameters](../type-parameters) enclosed in angle brackets 
(`<` and `>`) after the function name.

<!-- try: -->
    void generic<Foo, Bar>(){
        /* method block: statements 
           type parameter Foo and Bar are treated as a type */
    }

Of course, methods may be members of types which themselves have
[type parameters](../type-parameters):

<!-- try: -->
    class Generic<Foo>() {
        void method(Foo z) {
        }
    }

A function declaration with type parameters may have a `given` 
clause for each declared type parameter to 
[constrain the argument types](../type-parameters#constraints).

### Parameter list

A function declaration must have one or more 
[parameter lists](../parameter-list).

Most commonly just one parameter list is required, but 
higher order functions can use two or more:

    String url(String host)(String path) => "http://``host````path``";
    String(String) ceylonUrl = url("ceylon-lang.org");
    String ceylonBlog = ceylonUrl("/blog);

### Function blocks

The body of a function may be composed of [statements](../../#statement) 
in a brace-delimited *block*.

The body of a non-`void` function must *definitely return* a value 
using the [return statement](../../statement/return/). The 
following code will be rejected by the compiler:

    String fun(Boolean bool) {
        if (bool) {
            return "hello";
        }
        // error: missing return
    }
    
Similarly a `void` function must only use the form of `return` which 
lacks an expression.

### Function specifiers

A block with a return statement is unnecessarily verbose for a function 
that just evaluates a single expression and returns its result. In this 
case, we prefer to use the *fat arrow* (`=>`) syntax:

<!-- cat: void anotherFunction(){} -->
<!-- try: -->
    Integer addTen(Integer i) => i+10;

Note that you can use this to *partially apply* a function (or any other 
instance of `Callable`):

    function zeroTo(Integer n) => Range(0, n);

### Callable type

The *callable type* of a function expresses, in terms of the 
[`Callable`](#{site.urls.apidoc_1_3}/Callable.type.html) interface, is the 
function's return type and parameter types. For example, the callable type 
of:

<!-- try: -->
    String stringExample(Integer i, Boolean b) => "";
    
is `String(Integer, Boolean)`, and the callable type of:

<!-- try: -->
    void voidExample() {}
    
is `Anything()`.


### Exceptions

Ceylon doesn't have _checked exceptions_, so it's never necessary to declare 
what exceptions a method can [throw](../../statement/throw).

The [`throws` annotation](../../annotation/throws) may be used to *document* 
thrown exceptions.

### Different kinds of method

#### `formal` and `default` methods

A method declaration may be annotated [`formal`](../../annotation/formal)
or [`default`](../../annotation/default). A formal or default method must 
also be annotated `shared`.

A formal method does not specify an implementation. A formal method must
be refined by concrete classes which inherit the containing class or 
interface. 

A `default` method may be refined by types which inherit the containing 
class or interface. 

#### `shared` functions

A toplevel function declaration, or a function declaration nested inside 
the body of a containing class or interface, may be annotated 
[`shared`](../../annotation/shared).

- A toplevel `shared` function is visible wherever the package that contains 
  it is visible.
- A `shared` function nested inside a class or interface is visible wherever 
  the containing class or interface is visible.


### Metamodel

Function declarations can be manipulated at runtime via their representation as
[`FunctionDeclaration`](#{site.urls.apidoc_1_3}/meta/declaration/FunctionDeclaration.type.html) 
instances. An *applied function* (i.e. with all type parameters specified) 
corresponds to either a 
[`Function`](#{site.urls.apidoc_1_3}/meta/model/Function.type.html) or 
[`Method`](#{site.urls.apidoc_1_3}/meta/model/Method.type.html) model instance.

## See also

* [Method invocation](../../expression/invocation)
* [Compilation unit](../compilation-unit)
* [`class` declaration](../class)
* [`interface` declaration](../interface)
* [`object` declaration](../object)
* [Functions](#{site.urls.spec_current}#classes) in the Ceylon language spec

