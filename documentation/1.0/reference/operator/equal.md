---
layout: reference
title: `==` (equal) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `==` operator is used to test whether its operands 
are *equal*.

## Usage 

    Equality<T> x;
    T y;
    Boolean identical = x == y;

## Description

### Definition

The `==` operator is defined as follows:

    lhs.equals(rhs);

See the [language specification](#{site.urls.spec}#equalitycomparison) for more details.

### Polymorphism

The `==` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `==` depends on the 
[`Equality`](#{site.urls.apidoc}/ceylon/language/interface_Equality.html) interface.

### Meaning of *identical* for built-in types

TODO

## See also

* [`===` (identical)](../identical) operator
* API documentation for [`Equality`](#{site.urls.apidoc}/ceylon/language/interface_Equality.html)
* [equality in the language specification](#{site.urls.spec}#equalitycomparison)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

