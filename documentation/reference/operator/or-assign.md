---
layout: reference
title: `||=` (or assign) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, binary `||=` operator is used to compute the 
logical *or* of two operands, assigning the result to the left-hand operand. 

## Usage 

    variable Boolean a = false;
    Boolean b = true;
    a ||= b; // a becomes true

## Description

### Definition

The `||=` operator is defined as:

    if (lhs) true else lhs:=rhs

See the [language specification](#{site.urls.spec}#logical) for 
more details.

### Polymorphism

The `||` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [logical operators](#{site.urls.spec}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

