---
layout: reference
title: `&&` (and) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The left-associative, binary `&&` operator is used to compute the 
logical *and* of two operands

## Usage 

    Boolean false_ = true && false;

## Description

### Definition

The `&&` operator is defined as:

    if (lhs) rhs else false

See the [language specification](#{site.urls.spec}#logicaloperators) for 
more details.

### Polymorphism

The `&&` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism).

## See also

* [logical operators](#{site.urls.spec}#logicaloperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

