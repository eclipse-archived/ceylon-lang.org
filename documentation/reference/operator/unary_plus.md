---
layout: reference
title: `+` (unary plus) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, unary `+` operator is used to get the clarify the 
positive value of its operand.

## Usage 

    Integer one = +1;

## Description

Note that `+` does not change the sign of a negative number:

    Integer minusOne = +(-1);

### Definition 

The `+` operator is defined as follows:

    rhs.positiveValue;

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Polymorphism

The unary `+` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `+` depends on 
[`Invertable`](../../ceylon.language/Invertable) interface 

### Meaning of unary plus for built-in types

For the built-in type ([`Natural`](../../ceylon.language/Natural) unary plus
has the effect of converting the `Natural` to an `Integer`.

For the other built in numeric types
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Decimal`](../../ceylon.language/Decimal)) `+` 
is essentially a no-op: Those types are already able to represent negative 
numbers.

### Widening

The result type need not be the same as the operand type. This 
allows unary plus to effect a type conversion. 
An example of this is `Natural` which is declared to satisfy 
`Inverable<Integer>`, so unary plus on a `Natural` results in an `Integer`.

## See also

* [`-` (unary minus)](../unary_minus) which does change the sign of its operand
* [`Invertable`](../../ceylon.language/Invertable)
* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon

