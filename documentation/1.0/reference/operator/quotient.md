---
layout: reference
title: `/` (quotient) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `/` operator is used to compute the *quotient* of 
two operands.

## Usage 

    Integer three = 6 / 2;

## Description

### Definition

The `/` operator it defined as follows:

    lhs.castTo<N>().divided(rhs.castTo<N>());

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `/` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `/` depends on the 
[`Numeric`](#{page.doc_root}/api/ceylon/language/interface_Numeric.html) and
[`Castable`](#{page.doc_root}/api/ceylon/language/interface_Castable.html) interfaces.


### Meaning of quotient for built-in types

For the built-in numeric types ([`Integer`](#{page.doc_root}/api/ceylon/language/class_Integer.html), 
[`Float`](#{page.doc_root}/api/ceylon/language/class_Float.html),
[`Whole`](#{page.doc_root}/api/ceylon/language/class_Whole.html) and
[`Decimal`](#{page.doc_root}/api/ceylon/language/class_Decimal.html))
`*` performs normal mathematical division, subject to the limitations
of the relevant type.

### Widening

The types of the operands need not match because of the calls to `cast<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* API documentation for [`Numeric`](#{page.doc_root}/api/ceylon/language/interface_Numeric.html)
* API documentation for [`Castable`](#{page.doc_root}/api/ceylon/language/interface_Castable.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
