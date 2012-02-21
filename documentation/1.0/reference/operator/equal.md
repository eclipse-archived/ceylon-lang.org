---
layout: reference
title: `==` (equal) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `==` operator is used to test whether its operands 
are *equal*.

## Usage 

    Equality<T> x;
    T y;
    Boolean identical = x == y;

## Description

### Definition

The `==` operator is defined as follows:

    lhs.equals(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `==` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `==` depends on the 
[`Equality`](#{page.doc_root}/api/ceylon/language/interface_Equality.html) interface.

### Meaning of *identical* for built-in types

TODO

## See also

* [`===` (identical)](../identical) operator
* API documentation for [`Equality`](#{page.doc_root}/api/ceylon/language/interface_Equality.html)
* [equality in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

