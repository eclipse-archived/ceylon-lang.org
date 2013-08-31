---
layout: reference
title: '`-` (unary minus) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, unary `-` operator is used to invert the sign of its operand

## Usage 

    Integer minusOne = -1;

## Description

### Definition

The `-` operator is defined as follows:

<!-- check:none -->
    rhs.negativeValue;

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The unary `-` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `-` depends on 
[`Invertable`](#{site.urls.apidoc_current}/interface_Invertable.html) interface

### Meaning of unary minus for built-in types

For the built in numeric types
[`Integer`](#{site.urls.apidoc_current}/class_Integer.html) and
[`Float`](#{site.urls.apidoc_current}/class_Float.html), `-` 
just changes the sign.

## See also

* [`+` (unary plus)](../unary_plus) which does not change the sign of its 
  operand
* API documentation for [`Invertable`](#{site.urls.apidoc_current}/interface_Invertable.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon


