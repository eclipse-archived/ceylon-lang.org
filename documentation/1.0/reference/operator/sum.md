---
layout: reference
title: '`+` (sum) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
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

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `+` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `+` depends on the 
[`Summable`](#{site.urls.apidoc_current}/Summable.type.html) interface.

### Meaning of `+` for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_current}/Float.type.html),
`+` performs normal mathematical addition, subject to the limitations
of the relevant type.

For [`String`](#{site.urls.apidoc_current}/String.type.html), `+` performs concatenation.


## See also

* API documentation for [`Summable`](#{site.urls.apidoc_current}/Summable.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
