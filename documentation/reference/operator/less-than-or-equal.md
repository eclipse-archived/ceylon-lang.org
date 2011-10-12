---
layout: reference
title: `<=` (less than or equal) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `<=` operator is used to test whether its left-hand 
operand is *less than or equal to* its right-hand operand.

## Usage 

    Comparable<T> x;
    T y;
    Boolean lessOrEqual = x <= y;

## Description

### Definition

The `<=` operator is defined as follows:

    lhs.asSmallAs(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

### Polymorphism

The `<=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `<=` depends on the 
[`Comparable`](../../ceylon.language/Comparable) interface.

## See also

* [`Comparable`](../../ceylon.language/Comparable)
* [`<=` in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

