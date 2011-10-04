---
layout: reference
title: `-` (unary minus) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The unary `-` operator is used to invert the sign of
its operand, for example:

<!-- lang: ceylon -->

    Integer minusOne = -1;

## Description

The result type need not be the same as the operand type. This 
allows unary minus to effect a type conversion. 
An example of this is `Natural` which is declared to satisfy 
`Inverable<Integer>`, so unary minus on a `Natural` results in an `Integer`, as
expected.

The unary minus operator is not limited to numeric 
operands. The meaning of *unary minus* is defined by 
[`Invertable.negativeValue()`](../../ceylon.language/Invertable).

### Meaning of unary plus for built-in types

For the built-in type ([`Natural`](../../ceylon.language/Natural) unary minus
has the effect of converting the `Natural` to an `Integer`.

For the other built in numeric types
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Decimal`](../../ceylon.language/Decimal)) `-` 
essentially just changes the sign: Those types are already able to represent 
negative numbers.

## See also

* [`Invertable`](../../ceylon.language/Invertable)
* [unary plus in the language specification](#{site.urls.spec}#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
* [`+` (unary plus)](../unary_plus) which does not change the sign of its 
  operand

