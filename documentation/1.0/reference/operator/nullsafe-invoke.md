---
layout: reference
title: `()` or `{}` (null-safe invoke) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, unary null-safe version of the invoke 
`()` and `{}` operators are used to invoke methods on possibly `null`
primaries.

## Usage 

    void m(Integer? num){
        Integer? int = num?.positiveValue;
    }

## Description

Visually the null-safe invoke operators look identical to their
[invoke operator](../invoke) counterparts, the difference is in the
types of their operands.

### Definition

The meaning of null-safe `()` invoke is defined as follows:

<!-- check:none -->
    if (exists lhs) lhs(x,y,z) else null

With the named-argument version entirely analogous only using `{}` in the 
invocation.

### Polymorphism

This operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* Ordinary [`()` and `{}` (invoke)](../invoke) operator
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
