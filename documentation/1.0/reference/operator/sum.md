---
layout: reference
title: '`+` (sum) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `+` operator is used to *sum* two operands.

## Usage 

    Integer three = 1 + 2;
    String concatenated = "foo" + "bar";

## Description

### Definition

The `+` operator is defined as follows:

<!-- check:none -->
    lhs.plus(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `+` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `+` depends on the 
[`Summable`](#{site.urls.apidoc_current}/ceylon/language/interface_Summable.html) interface.

### Meaning of `+` for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/ceylon/language/class_Integer.html) and
[`Float`](#{site.urls.apidoc_current}/ceylon/language/class_Float.html),
`+` performs normal mathematical addition, subject to the limitations
of the relevant type.

For [`String`](#{site.urls.apidoc_current}/ceylon/language/class_String.html), `+` performs concatenation.


## See also

* API documentation for [`Summable`](#{site.urls.apidoc_current}/ceylon/language/interface_Summable.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
