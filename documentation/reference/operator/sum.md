---
layout: reference
title: `+` (sum) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `+` operator is used to *sum* two operands:

<!-- lang: ceylon -->

    Natural three = 1 + 2;
    String concatenated = "foo" + "bar";

## Description

As the above example shows, the sum operator is not limited to numeric 
operands. The meaning of *sum* corresponds to the 
[`Summable`](../../ceylon.language/Summable) interface. Note that the types of 
the operands need not match.

### Meaning of sum for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Whole`](../../ceylon.language/Whole) and
[`Decimal`](../../ceylon.language/Decimal)) `+` 
performs addition.

For [`String`](../../ceylon.language/String), `+` performs concatenation.

## See also

* [`Summable`](../../ceylon.language/Summable)
* [`Castable`](../../ceylon.language/Castable)
* [sum in the language specification](FIXME#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
