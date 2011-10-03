---
layout: reference
title: `-` (difference) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `-` operator is used to take the *difference* of 
two operands, for example:

<!-- lang: ceylon -->

    Natural one = 3 - 2;

## Description

The difference operator is not limited to numeric 
operands. The meaning of *difference* is defined by 
[`Numeric.minus()`](../../ceylon.language/Numeric). 

### Widening

The types of the operands need not match, because an expression such as 

<!-- lang: ceylon -->

    X lhs;
    Y rhs;
    // some code assigning lhs and rhs
    Z z = lhs - rhs;

(where `X` satisfies `Castable<N> & Numeric<X>` and `Y` 
satisfies `Castable<N> & Numeric<Y>`) is equivalent to 

<!-- lang: ceylon -->

    Z z = lhs.cast<N>().minus(rhs.cast<N>())

where `Z` is assignable to one of `X` or `Y`. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

### Meaning of difference for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Whole`](../../ceylon.language/Whole) and
[`Decimal`](../../ceylon.language/Decimal)) `-` 
performs the usual numeric subtraction.

## See also

* [`Numeric`](../../ceylon.language/Numeric)
* [`Castable`](../../ceylon.language/Castable)
* [difference in the language specification](FIXME#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
