---
layout: reference
title: `<=>` (compare) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `<=>` operator is used to *compare* the order of 
its operands.

## Usage 

    Comparable<T> x;
    T y;
    Comparison cmp = x <=> y;

## Description

### Definition

The `<=>` operator is defined as follows:

    lhs.compare(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

### Polymorphism

The `<=>` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `<=>` depends on the 
[`Comparable`](../../ceylon.language/Comparable) interface 

## See also

* [`Comparable`](../../ceylon.language/Comparable)
* [compare in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

