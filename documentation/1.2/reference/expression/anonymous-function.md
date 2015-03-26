---
layout: reference12
title_md: 'Anonymous functions'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An anonymous function is a function with no name, defined within 
an expression.

## Usage

<!-- try: -->
    // verbose
    function (Float x) => 2*x
    
    // less verbose
    (Float x) => 2*x 

    // void
    void (String name) => print("hello " + name)
    
    // with a block
    (String name) {
        String greeting = "hello " + name;
        print(greeting);
        return greeting;
    }
    

## Description

### Type

The type of an anonymous function is simply the 
[callable type](../../structure/function/#callable_type) of the
function.

### Function and void keywords

The keyword `function` is optional for an anonymous function that
returns a value. The keyword `void` is required for an anonymous
function that doesn't return a value, for example, if it calls a 
`void` method or function, or performs an assignment.

### Higher-order anonymous functions

Anonymous functions can, be higher order too. Here's one with 
[multiple parameter lists](../../structure/parameter-list/#multiple_parameter_lists):

<!-- try: -->
    value multiplier = (Float x)(Float y) => x*y;

### Advice

Try to avoid using anonymous functions as function results. The 
preferred form is to use a function with multiple parameter lists:

<!-- try: -->
    // A function f which returns an anonymous function
    // (difficult to read with all those =>)
    Float(Float) f(Float x) => (Float y) => x*y;
    
    // A function f with multiple parameters
    // (preferred)
    Float f(Float x)(Float y) => x*y;

Anonymous functions with blocks are rare. If your anonymous 
function doesn't fit in a single expression, consider refactoring:

- turn the anonymous function into an ordinary named function,
- use Extract Function to pull some of the functionality out
  of the anonymous function, or
- use a named argument list instead.

## See also

* [Functions and methods](../../structure/function)
* [Anonymous functions](#{site.urls.spec_current}#anonymousfunctions) 
  in the Ceylon language specification

