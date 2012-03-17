---
layout: reference
title: `..` (range) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *range* operator creates a `Range` from its endpoints.

## Usage 

    Range<Integer> ten = 1..10;

## Description


### Definition

The `..` operator is defined as follows:

<!-- no-check -->
    Range(lhs, rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#constructors) for 
more details.

### Polymorphism

The `[].` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [object creation operators](#{page.doc_root}/#{site.urls.spec_relative}#constructors) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

