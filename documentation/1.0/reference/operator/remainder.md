---
layout: reference
title: `%` (remainder) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
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
    lhs.castTo<N>().remainder(rhs.castTo<N>());

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `%` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `%` depends on the 
[`Integral`](#{page.doc_root}/api/ceylon/language/interface_Integral.html) and
[`Castable`](#{page.doc_root}/api/ceylon/language/interface_Castable.html) interfaces 

### Meaning of remainder for built-in types

For the built-in numeric types ([`Integer`](#{page.doc_root}/api/ceylon/language/class_Integer.html) and
[`Whole`](#{page.doc_root}/api/ceylon/language/class_Whole.html) `/` 
`%` computes normal mathematical remainder.

Since the other built-in numeric types do not satisfy `Integral`, the
remainder operator cannot be used on them.

### Widening

Widening will be implemented in <!-- m2 -->

The types of the operands need not match because of the calls to `castTo<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* API documentation for [`Integral`](#{page.doc_root}/api/ceylon/language/interface_Integral.html)
* API documentation for [`Castable`](#{page.doc_root}/api/ceylon/language/interface_Castable.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
