---
layout: reference
title: '`<=` (less than or equal) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `<=` operator is used to test whether its left-hand 
operand is *less than or equal to* its right-hand operand.

## Usage 

    void m<T>(T x, T y) 
      given T satisfies Comparable<T> {
        Boolean lessOrEqual = x <= y;
    }

## Description

### Definition

The `<=` operator is defined as follows:

<!-- check:none -->
    lhs.compare(rhs)!=larger;

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `<=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `<=` depends on the 
[`Comparable`](#{site.urls.apidoc_current}/interface_Comparable.html) interface.

## See also

* API documentation for [`Comparable`](#{site.urls.apidoc_current}/interface_Comparable.html)
* [`<=` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

