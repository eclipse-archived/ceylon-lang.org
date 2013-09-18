---
layout: reference
title: '`%` (remainder) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The binary, left-associative `%` operator is used to get the remainder of an
integer division.

## Usage 

    Integer two = 5 % 3;

## Description

### Definition

The `%` operator is defined as follows:

<!-- check:none -->
    lhs.remainder(rhs);

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `%` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `%` depends on the 
[`Integral`](#{site.urls.apidoc_current}/interface_Integral.html) interface. 

### Meaning of remainder for built-in types

For the built-in numeric type ([`Intege`](#{site.urls.apidoc_current}/class_Integer.html) 
`%` computes normal mathematical remainder.

Since the other built-in numeric types do not satisfy `Integral`, the
remainder operator cannot be used on them.

## See also

* API documentation for [`Integral`](#{site.urls.apidoc_current}/interface_Integral.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
