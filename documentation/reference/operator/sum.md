---
layout: reference
title: `+` (sum) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `+` operator is used to *sum* two operands, for 
example:

<!-- lang: ceylon -->

    Natural three = 1 + 2;
    String concatenated = "foo" + "bar";

## Description

As the above example shows, the sum operator is not limited to numeric 
operands. The meaning of *sum* corresponds to the 
[`Summable`](../../ceylon.language/Summable) interface. 

### Meaning of sum for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Whole`](../../ceylon.language/Whole) and
[`Decimal`](../../ceylon.language/Decimal)) `+` 
performs addition.

For [`String`](../../ceylon.language/String), `+` performs concatenation.

### Widening

The types of the operands need not match, because an expression such as 

<!-- lang: ceylon -->

    X lhs;
    Y rhs;
    // some code assigning lhs and rhs
    Z z = lhs + rhs;

(where `X` satisfies `Castable<N> & Summable<X>` and `Y` 
satisfies `Castable<N> & Summable<Y>`) is equivalent to 

<!-- lang: ceylon -->

    Z z = lhs.cast<N>().plus(rhs.cast<N>());

where `Z` is assignable to one of `X` or `Y`. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* [`Summable`](../../ceylon.language/Summable)
* [`Castable`](../../ceylon.language/Castable)
* [sum in the language specification](#{site.urls.spec}#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
