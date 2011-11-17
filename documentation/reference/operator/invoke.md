---
layout: reference
title: `()` and `{}` (invoke) operators
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The left-associative, unary `()` and `{}` operators are used to invoke methods
and instantiate classes

## Usage

    print("hello, world!");       // positional style
    print{                        // named-arguments style
        line="hello, world";
    };
    MyClass instance = MyClass(); // invoking a class to get an instance

## Description

For detailed information see the reference documentation on 
[method invocation] _doc coming soon at_ (/documentation/reference/expression/method-invocation) and 
[class invocation] _doc coming soon at_ (/documentation/reference/expression/class-invocation).

### Definition

The `()` and `{}` operators are primitive.

### Polymorphism

The `()` and `{}` operators are not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [null-safe version](../nullsafe-invoke) of invoke.
* [spread invoke] _doc coming soon at_ (../spread-invoke) for calling a `Callable[]`
* [`Callable`] _doc coming soon at_ (../../ceylon.language/Callable)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

