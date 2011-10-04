---
layout: reference
title: `+` (unary plus) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The unary `+` operator is used to get the clarify the positive value of 
its operand, for example:

<!-- lang: ceylon -->

    Integer one = +1;

## Description

Note that `+` does not change the sign of a negative number:

<!-- lang: ceylon -->

    Integer minusOne = +(-1);

However, the result type need not be the same as the operand type. This 
allows unary plus to effect a type conversion. 
An example of this is `Natural` which is declared to satisfy 
`Inverable<Integer>`, so unary plus on a `Natural` results in an `Integer`.

The unary plus operator is not limited to numeric 
operands. The meaning of *unary plus* is defined by 
[`Invertable.positiveValue()`](../../ceylon.language/Invertable). 

### Meaning of unary plus for built-in types

For the built-in type ([`Natural`](../../ceylon.language/Natural) unary plus
has the effect of converting the `Natural` to an `Integer`.

For the other built in numeric types
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Decimal`](../../ceylon.language/Decimal)) `+` 
is essentially a no-op: Those types are already able to represent negative 
numbers.

## See also

* [`Invertable`](../../ceylon.language/Invertable)
* [unary plus in the language specification](#{site.urls.spec}#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
* [`-` (unary minus)](../unary_minus) which does change the sign of its operand
