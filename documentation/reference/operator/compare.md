---
layout: reference
title: `<=>` (compare) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The non-associating, binary `<=>` operator is used to *compare* its operands:

    Comparable<T> x;
    T y;
    Comparison cmp = x <=> y;

## Description

### Polymorphism

The `<=>` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `<=>` depends on the 
[`Comparable`](../../ceylon.language/Comparable) interface as follows:

    lhs.compare(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`Comparable`](../../ceylon.language/Comparable)
* [compare in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

