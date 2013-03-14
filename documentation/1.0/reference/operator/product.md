---
layout: reference
title: '`*` (product) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `*` operator is used to compute the *product* of 
two operands.

## Usage 

    Integer six = 3 * 2;

## Description

### Definition

The `*` operator is defined as follows:

<!-- check:none -->
    lhs().times(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `*` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `*` depends on the 
[`Numeric`](#{site.urls.apidoc_current}/ceylon/language/interface_Numeric.html) interface.

### Meaning of product for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/ceylon/language/class_Integer.html) and 
[`Float`](#{site.urls.apidoc_current}/ceylon/language/class_Float.html),
`*` performs normal mathematical multiplication, subject to the limitations
of the relevant type.

## See also

* API documentation for [`Numeric`](#{site.urls.apidoc_current}/ceylon/language/interface_Numeric.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
