---
layout: reference
title: `==` (equal) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The non-associating, binary `==` operator is used to test whether its operands 
are *equal*:

    Equality<T> x;
    T y;
    Boolean identical = x == y;

## Description

### Polymorphism

The `==` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `==` depends on the 
[`Equality`](../../ceylon.language/Equality) interface as follows:

    lhs.equals(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

### Meaning of *identical* for built-in types

TODO

## See also

* [`===` (identical)](../identical) operator
* [`Equality`](../../ceylon.language/Equality)
* [equality in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

