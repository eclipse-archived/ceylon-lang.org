---
layout: reference
title: '`..` (spanned range) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *spanned range* operator creates a `Range` from its endpoints.

## Usage 

    Range<Integer> ten = 1..10;

## Description


### Definition

The `..` operator is defined as follows:

<!-- check:none -->
    Range(lhs, rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#constructors) for 
more details.

### Polymorphism

The `..` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `..` depends on the 
[`Range`](#{site.urls.apidoc_current}/class_Range.html) 
class.

## See also

* [`:` (segmented range)](../segmented-range)
* [object creation operators](#{page.doc_root}/#{site.urls.spec_relative}#constructors) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

