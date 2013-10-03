---
layout: reference
title: '`*` (product) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary infix `*` operator is used to compute the *product* of 
two operands.

## Usage 

<!-- try: -->
    Integer six = 3 * 2;

## Description

### Definition

The `*` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs().times(rhs);

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `*` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `*` depends on the 
[`Numeric`](#{site.urls.apidoc_current}/Numeric.type.html) interface.

### Type

The result type of the `*` operator is the same as the type of its right hand operand.

### Meaning of product for built-in types

For the built-in numeric types [`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and 
[`Float`](#{site.urls.apidoc_current}/Float.type.html),
`*` performs normal mathematical multiplication, subject to the limitations
of the relevant type.

## See also

* API documentation for [`Numeric`](#{site.urls.apidoc_current}/Numeric.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
