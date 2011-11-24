---
layout: reference
title: `-` (unary minus) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, unary `-` operator is used to invert the sign of its operand

## Usage 

    Integer minusOne = -1;

## Description

### Definition

The `-` operator is defined as follows:

    rhs.negativeValue;

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Polymorphism

The unary `-` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `-` depends on 
[`Invertable`](#{site.urls.apidoc}/ceylon/language/interface_Invertable.html) interface

### Meaning of unary plus for built-in types

For the built-in type ([`Natural`](#{site.urls.apidoc}/ceylon/language/class_Natural.html) unary minus
has the effect of converting the `Natural` to an `Integer`.

For the other built in numeric types
[`Integer`](#{site.urls.apidoc}/ceylon/language/class_Integer.html),
[`Float`](#{site.urls.apidoc}/ceylon/language/class_Float.html),
[`Decimal`](#{site.urls.apidoc}/ceylon/language/class_Decimal.html) `-` 
essentially just changes the sign: Those types are already able to represent 
negative numbers.

### Widening

The result type need not be the same as the operand type. This 
allows unary minus to effect a type conversion. 
An example of this is `Natural` which is declared to satisfy 
`Inverable<Integer>`, so unary minus on a `Natural` results in an `Integer`, as
expected.

## See also

* [`+` (unary plus)](../unary_plus) which does not change the sign of its 
  operand
* API documentation for [`Invertable`](#{site.urls.apidoc}/ceylon/language/interface_Invertable.html)
* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon


