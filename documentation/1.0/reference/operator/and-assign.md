---
layout: reference
title: `&&=` (and assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, binary `&&=` operator is used to compute the 
logical *and* of two operands, assigning the result to the left-hand operand. 

## Usage 

    variable Boolean a = true;
    Boolean b = false;
    a &&= b; // a becomes false

## Description

### Definition

The `&&=` operator is defined as:

    if (lhs) lhs:=rhs else false

See the [language specification](#{site.urls.spec}#logical) for 
more details.

### Polymorphism

The `&&` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism).

## See also

* [logical operators](#{site.urls.spec}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

