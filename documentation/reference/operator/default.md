---
layout: reference
title: `?` (default) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `?` operator is used to specify a *default* value.

    Natural? num;
    Natural value = num ? 0;

## Description

### Definition

The meaning of `?` is defined as follows:

    if (exists lhs) lhs else rhs

### Polymorphism

The `?` operator is not polymorphic.

## See also

* [`?`](#{site.urls.spec}#nullvalues) in the language specification.
