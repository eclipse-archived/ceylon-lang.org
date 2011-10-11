---
layout: reference
title: `()` and `{}` (invoke) operators
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The left-associative, unary `()` and `{}` operators are used to invoke methods, 
functions and instantiate classes:

    print("hello, world!");       // positional style
    print{                        // named-arguments style
        line="hello, world";
    };
    MyClass instance = MyClass(); // invoking a class to get an instance

## Description

For detailed information see the reference documentation on 
[method invocation](/documentation/reference/expression/method-invocation) and 
[class invocation](/documentation/reference/expression/class-invocation).

### Polymorphism

The `()` and `{}` operators are not [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 

## See also

* [`Callable`](../../ceylon.language/Callable)

