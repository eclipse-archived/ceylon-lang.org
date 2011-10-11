---
layout: reference
title: `%` (remainder) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The binary, left-associative `%` operator is used to get the remainder of an
integer division.

## Usage 

    Integer two = 5 % 3;

## Description

### Definition

The `%` operator is defined as follows:

    lhs.castTo<N>().remainder(rhs.castTo<N>());

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Polymorphism

The `%` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `%` depends on the 
[`Integral`](../../ceylon.language/Integral) and
[`Castable`](../../ceylon.language/Castable) interfaces 

### Meaning of product for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural) and
[`Integer`](../../ceylon.language/Integer) `/` 
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

* [`Integral`](../../ceylon.language/Integral)
* [`Castable`](../../ceylon.language/Castable)
* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
