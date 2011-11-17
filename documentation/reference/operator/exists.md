---
layout: reference
title: `exists` operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, unary `exists` operator is used to test its operand for 
nullness.

## Usage 

    Natural? num;
    Boolean haveNum = num exists;

## Description

### Definition

The meaning of `exists` is defined as follows:

    if (exists lhs) true else false

### Polymorphism

The `exists` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [`exists`](#{site.urls.spec}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
