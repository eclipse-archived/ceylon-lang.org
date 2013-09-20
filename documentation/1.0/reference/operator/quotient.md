---
layout: reference
title: '`/` (quotient) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary infix `/` operator is used to compute the *quotient* of 
two operands.

## Usage 

<!-- try: -->
    Integer three = 6 / 2;

## Description

### Definition

The `/` operator it defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.divided(rhs);

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `/` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `/` depends on the 
[`Numeric`](#{site.urls.apidoc_current}/Numeric.type.html) interface.

### Type

The type of `/` is the same as the type of its right hand operand.

### Meaning of quotient for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_current}/Float.type.html),
`*` performs normal mathematical division, subject to the limitations
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
