---
layout: reference
title: `nonempty` operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, unary `nonempty` operator is used to test its operand for 
emptiness.

    Natural[] nums;
    Boolean haveNums = nums nonempty;

## Description

### Polymorphism

The `nonempty` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `exists` is defined as follows:

    if (nonempty lhs) true else false

## See also

* [`nonempty`](#{site.urls.spec}#nullvalues) in the language specification.
