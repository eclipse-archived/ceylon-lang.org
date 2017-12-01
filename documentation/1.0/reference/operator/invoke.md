---
layout: reference
title_md: '`()` and `{}` (invoke) operators'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, unary `()` and `{}` operators are used to invoke methods
and instantiate classes

## Usage

<!-- cat: class MyClass() {} -->
<!-- cat: void m() { -->
<!-- try: -->
    print("hello, world!");       // positional style
    print{                        // named-arguments style
        line="hello, world";
    };
    MyClass instance = MyClass(); // invoking a class to get an instance
<!-- cat: } -->

## Description

For detailed information see the reference documentation on 
[method invocation] _doc coming soon at_ (#{page.doc_root}/reference/expression/method-invocation) and 
[class invocation] _doc coming soon at_ (#{page.doc_root}/reference/expression/class-invocation).

### Definition

The `()` and `{}` operators are primitive.

### Polymorphism

The `()` and `{}` operators are not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the invocation operator expressions is the return type of the callable type of the left hand operand.

## See also

* [spread invoke] _doc coming soon at_ (../spread-invoke) for calling a `Callable[]`
* API documentation for [`Callable`] _doc coming soon at_ (../../ceylon.language/Callable)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

