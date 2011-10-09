---
layout: reference
title: `>=` (greater than or equal) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `>=` operator is used to test whether its left hand 
operand is *greater than or equal to* its right hand operand

    Comparable<T> x;
    T y;
    Boolean greaterOrEqual = x >= y;

## Description

### Polymorphism

The `>=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `>=` depends on the 
[`Comparable`](../../ceylon.language/Comparable) interface as follows:

    lhs.asLargeAs(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`Comparable`](../../ceylon.language/Comparable)
* [`>=` in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

