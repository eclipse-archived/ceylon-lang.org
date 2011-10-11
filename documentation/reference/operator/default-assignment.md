---
layout: reference
title: `?=` (default assignment) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `?=` operator is used to specify a *default* value.

    Natural? num;
    num ?= 0;

## Description

### Definition

The meaning of `?=` is defined as follows:

    if (exists lhs) lhs else lhs:=rhs	

### Polymorphism

The `?=` operator is not polymorphic.

## See also

* [`?.` (null-safe member)](../default) operator
* [`?`](#{site.urls.spec}#nullvalues) in the language specification.
