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

### Meaning of unary minus for built-in types

For the built in numeric types
[`Integer`](#{site.urls.apidoc}/ceylon/language/class_Integer.html),
[`Float`](#{site.urls.apidoc}/ceylon/language/class_Float.html),
[`Whole`](#{site.urls.apidoc}/ceylon/language/class_Whole.html), and
[`Decimal`](#{site.urls.apidoc}/ceylon/language/class_Decimal.html), `-` 
just changes the sign.

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


