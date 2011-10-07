---
layout: reference
title: `%` (remainder) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The binary left-associative `%` operator is used to get the remainder of an
integer division, for example:

<!-- lang: ceylon -->

    Integer two = 5 % 3;

## Description

### Polymorphism

The `%` operator is [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 
The meaning of `%` depends on the 
[`Integral`](../../ceylon.language/Integral) and
[`Castable`](../../ceylon.language/Castable) interfaces as follows:

    lhs.castTo<N>().remainder(rhs.castTo<N>());

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Meaning of product for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural) and
[`Integer`](../../ceylon.language/Integer) `/` 
`%` computes normal mathematical remainder.

Since the other built-in numeric types do not satisfy `Integral`, the
remainder operator cannot be used on them.

### Widening

The types of the operands need not match because of the calls to `cast<N>()` 
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
