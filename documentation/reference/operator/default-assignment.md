---
layout: reference
title: `?=` (default assignment) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, binary `?=` operator is used to specify a *default* value.

## Usage 

    Integer? num;
    num ?= 0;

## Description

### Definition

The meaning of `?=` is defined as follows:

    if (exists lhs) lhs else lhs:=rhs	

See the [language specification](#{site.urls.spec}#nullvalues) for more details.

### Polymorphism

The `?=` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism).

## See also

* [`?.` (null-safe member)](../default) operator
* [`?`](#{site.urls.spec}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
