---
layout: reference
title: `||` (or) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The left-associative, binary `||` operator is used to compute the 
logical *or* of two operands, for example:

    Boolean true_ = true || false;

## Description

### Polymorphism

The `||` operator is defined as:

    if (lhs) true else rhs

See the [language specification](#{site.urls.spec}#logicaloperators) for 
more details.

## See also

* [logical operators](#{site.urls.spec}#logicaloperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

