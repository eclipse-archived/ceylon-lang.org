---
layout: reference
title: `in` (containment) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The non-associating, binary `in` operator is used to test whether its left hand 
operand is *contained in* its right hand operand

    Object x;
    Category y;
    Boolean contained = x in y;

## Description

### Polymorphism

The `in` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `in` depends on the 
[`Category`](../../ceylon.language/Category) interface as follows:

    lhs.contained(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`Category`](../../ceylon.language/Category)
* [`in` in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

