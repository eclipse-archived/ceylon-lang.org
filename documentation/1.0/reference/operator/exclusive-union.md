---
layout: reference
title: `^` (exclusive union) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `^` operator is used to compute the 
*exclusive union* of two operands.

## Usage

    void m(Set<Integer> odds, Set<Integer> evens) {
        Set<Integer> integers = odds ^ evens;
    }

## Description

### Definition

The `^` operator is defined as follows:

<!-- no-check -->
    lhs.exclusiveUnion(rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#sets) for 
more details.

### Polymorphism

The `^` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `^` depends on the 
[`Sets`](#{page.doc_root}/api/ceylon/language/interface_Set.html) interface 

## See also

* API documentation for [`Sets`](#{page.doc_root}/api/ceylon/language/interface_Set.html)
* [set operators](#{page.doc_root}/#{site.urls.spec_relative}#sets) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

