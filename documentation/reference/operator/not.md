---
layout: reference
title: `!` (not) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, unary `||` operator is used to compute the 
logical *not* of its operand, for example:

    Boolean true_ = !false;

## Description

### Polymorphism

The `!` operator is defined as:

    if (rhs) false else true

See the [language specification](#{site.urls.spec}#logicaloperators) for 
more details.

## See also

* [logical operators](#{site.urls.spec}#logicaloperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification

