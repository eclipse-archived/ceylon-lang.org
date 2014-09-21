---
layout: reference11
title_md: '`-` (unary minus) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, unary prefix `-` operator is used to invert the sign of its operand

## Usage 

<!-- try: -->
    Integer minusOne = -1;

## Description

### Definition

The `-` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    rhs.negativeValue;

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The unary `-` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `-` depends on 
[`Invertible`](#{site.urls.apidoc_current}/Invertible.type.html) interface

### Type

The result type of the `-` operator is the same as the `Invertible` type of its operand.

### Meaning of unary minus for built-in types

For the built in numeric types
[`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_current}/Float.type.html), `-` 
just changes the sign.

## See also

* [`+` (unary plus)](../unary_plus) which does not change the sign of its 
  operand
* API documentation for [`Invertible`](#{site.urls.apidoc_current}/Invertible.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon


