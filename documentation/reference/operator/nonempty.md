---
layout: reference
title: `nonempty` operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, unary `nonempty` operator is used to test its operand for 
emptiness.

## Usage 

    Natural[] nums;
    Boolean haveNums = nums nonempty;

## Description

### Definition

The meaning of `exists` is defined as follows:

    if (nonempty lhs) true else false

See the [`language specification`](#{site.urls.spec}#nullvalues) for more details.

### Polymorphism

The `nonempty` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [`nonempty`](#{site.urls.spec}#nullvalues) in the language specification.
