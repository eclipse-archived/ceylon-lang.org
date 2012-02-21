---
layout: reference
title: `<=>` (compare) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `<=>` operator is used to *compare* the order of 
its operands.

## Usage 

    Comparable<T> x;
    T y;
    Comparison cmp = x <=> y;

## Description

### Definition

The `<=>` operator is defined as follows:

    lhs.compare(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `<=>` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `<=>` depends on the 
[`Comparable`](#{page.doc_root}/api/ceylon/language/interface_Comparable.html) interface 

## See also

* API documentation for [`Comparable`](#{page.doc_root}/api/ceylon/language/interface_Comparable.html)
* [compare in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

