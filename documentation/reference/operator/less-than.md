---
layout: reference
title: `<` (less than) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `<` operator is used to test whether its left hand 
operand is *less than* its right hand operand

    Comparable<T> x;
    T y;
    Boolean less = x < y;

## Description

### Polymorphism

The `<` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `<` depends on the 
[`Comparable`](../../ceylon.language/Comparable) interface as follows:

    lhs.smallerThan(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`Comparable`](../../ceylon.language/Comparable)
* [`<` in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

