---
layout: reference
title: `&&=` (and assign) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The right-associative, binary `&&=` operator is used to compute the 
logical *and* of two operands, assigning the result to the left hand operand. 
For example:

    variable Boolean a = true;
    Boolean b = false;
    a &&= b; // a becomes false

## Description

### Polymorphism

The `&&=` operator is defined as:

    if (lhs) lhs:=rhs else false

See the [language specification](#{site.urls.spec}#logicaloperators) for 
more details.

## See also

* [logical operators](#{site.urls.spec}#logicaloperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

