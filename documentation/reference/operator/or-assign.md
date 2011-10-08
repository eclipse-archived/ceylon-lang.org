---
layout: reference
title: `||=` (or assign) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `||=` operator is used to compute the 
logical *or* of two operands, assigning the result to the left hand operand. 
For example:

    variable Boolean a = false;
    Boolean b = true;
    a ||= b; // a becomes true

## Description

### Polymorphism

The `||=` operator is defined as:

    if (lhs) true else lhs:=rhs

See the [language specification](#{site.urls.spec}#logicaloperators) for 
more details.

## See also

* [logical operators](#{site.urls.spec}#logicaloperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

