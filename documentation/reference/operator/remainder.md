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

The remainder operator is not limited to numeric 
operands. The meaning of *remainder* is defined by 
[`Integral.remainder()`](../../ceylon.language/Integral). 

### Meaning of product for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural) and
[`Integer`](../../ceylon.language/Integer) `/` 
performs the usual mathematical remainder operation.

Since the other built-in numeric types do not satisfy `Integral`, the
remainder operator cannot be used on them.

### Widening

The types of the operands need not match, because an expression such as 

<!-- lang: ceylon -->

    X lhs;
    Y rhs;
    // some code assigning lhs and rhs
    Z z = lhs % rhs;

(where `X` satisfies `Castable<N> & Integral<X>` and `Y` 
satisfies `Castable<N> & Integral<Y>`) is equivalent to 

<!-- lang: ceylon -->

    Z z = lhs.cast<N>().remainder(rhs.cast<N>())

where `Z` is assignable to one of `X` or `Y`. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* [`Integral`](../../ceylon.language/Integral)
* [`Castable`](../../ceylon.language/Castable)
* [remainder in the language specification](#{site.urls.spec}#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
