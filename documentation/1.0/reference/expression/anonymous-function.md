---
layout: reference
title: 'Anonymous functions'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

An anonymous function is a function with no name that's defined within an expression.

## Usage

<!-- try: -->
    // Specify a Callable value using an anonymous function
    value doubler = function (Float x) => 2*x;


## Description

### Type

The type of an anonymous function is simply the callable type of the 
function.

### Function and void keywords

The above [example](#usage) shows an anonymous function declared using 
the `function` keyword (you can use `void` instead of `function` if 
the anonymous function doesn't return anything). 

However, the `function` or `void` keyword is optional in this context. 
You don't have to use `=>` either, you can also use a 
[block](../../statement/block/). 
So you could also write:

<!-- try: -->
    value tripler = (Float x) {
        return 3*x;
    };

### Higher-order functions

Anonymous functions can, be higher order too. Here's one using 
[multiple parameter lists](../../structure/parameter-list/#multiple_parameter_lists):

<!-- try: -->
    value multiplier = (Float x)(Float y) 
        => x*y;

### Advice

Try to avoid using anonymous functions as function results. 
The preferred form is to use a function with multiple parameter lists:

<!-- try: -->
    // A function f which returns an anonymous function
    // (difficult to read with all those =>)
    Float(Float) f(Float x) => (Float y) => x*y;
    
    // A function f with multiple parameters
    // (preferred)
    Float f(Float x)(Float y) => x*y;
    

## See also

