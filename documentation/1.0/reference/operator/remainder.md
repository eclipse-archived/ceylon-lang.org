---
layout: reference
title_md: '`%` (remainder) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The binary, left-associative infix `%` operator is used to get the remainder of an
integer division.

## Usage 

<!-- try: -->
    Integer two = 5 % 3;

## Description

### Definition

The `%` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.remainder(rhs);

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `%` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `%` depends on the 
[`Integral`](#{site.urls.apidoc_current}/Integral.type.html) interface. 

### Type

The result type of the `%` operator is the same as the type of its right hand operand.

### Meaning of remainder for built-in types

For the built-in numeric type [`Integer`](#{site.urls.apidoc_current}/Integer.type.html), 
`%` computes normal mathematical remainder.

Since the other built-in numeric types do not satisfy `Integral`, the
remainder operator cannot be used on them.

## See also

* API documentation for [`Integral`](#{site.urls.apidoc_current}/Integral.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
