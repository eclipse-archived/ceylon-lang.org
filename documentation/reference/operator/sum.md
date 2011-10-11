---
layout: reference
title: `+` (sum) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

## Usage 

The left-associative, binary `+` operator is used to *sum* two operands, for 
example:

    Natural three = 1 + 2;
    String concatenated = "foo" + "bar";

## Description

### Polymorphism

The `+` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `+` depends on the 
[`Summable`](../../ceylon.language/Summable) and
[`Castable`](../../ceylon.language/Castable) interfaces as follows:

    lhs.castTo<N>().plus(rhs.castTo<N>());

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Meaning of `+` for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Whole`](../../ceylon.language/Whole) and
[`Decimal`](../../ceylon.language/Decimal)) 
`+` performs normal mathematical addition, subject to the limitations
of the relevant type.

For [`String`](../../ceylon.language/String), `+` performs concatenation.

### Widening

Widening will be implemented in <!-- m2 -->

The types of the operands need not match because of the calls to `castTo<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible. 

## See also

* [`Summable`](../../ceylon.language/Summable)
* [`Castable`](../../ceylon.language/Castable)
* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
