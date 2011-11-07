---
layout: reference
title: `!` (not) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, unary `||` operator is used to compute the 
logical *not* of its operand.

## Usage 

    Boolean true_ = !false;

## Description

### Definition

The `!` operator is defined as:

    if (rhs) false else true

See the [language specification](#{site.urls.spec}#logical) for 
more details.

### Polymorphism

The `!` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [logical operators](#{site.urls.spec}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

