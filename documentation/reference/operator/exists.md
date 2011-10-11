---
layout: reference
title: `exists` operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, unary `exists` operator is used to test its operand for 
nullness.

    Natural? num;
    Boolean haveNum = num exists;

## Description

### Polymorphism

The `exists` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `exists` is defined as follows:

    if (exists lhs) true else false

## See also

* [`exists`](#{site.urls.spec}#nullvalues) in the language specification.
