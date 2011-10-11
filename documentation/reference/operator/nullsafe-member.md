---
layout: reference
title: `?.` (null-safe member) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `?.` operator is used to access a member if
the owner of the member is not `null`:

    Number? num;
    Integer int = num?.positiveValue;

## Description

### Definition

The meaning of `?.` is defined as follows:

    if (exists lhs) lhs.member else null	

### Polymorphism

The `?.` operator is not polymorphic.

## See also

* [`?` (default)](../default) operator
* [`?.`](#{site.urls.spec}#nullvalues) in the language specification.
