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

### Polymorphism

The `-` operator is [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 
The meaning of `-` depends on the 
[`Numeric`](../../ceylon.language/Numeric) and
[`Castable`](../../ceylon.language/Castable) interfaces as follows:

    lhs.castTo<N>().minus(rhs.castTo<N>());

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Meaning of difference for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer),
[`Float`](../../ceylon.language/Float),
[`Whole`](../../ceylon.language/Whole) and
[`Decimal`](../../ceylon.language/Decimal)) 
`-` performs normal mathematical subtraction, subject to the limitations
of the relevant type.

### Widening

The types of the operands need not match because of the calls to `cast<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen one of the `lhs` or `rhs` so that it's the same type as the other then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* [`Numeric`](../../ceylon.language/Numeric)
* [`Castable`](../../ceylon.language/Castable)
* [difference in the language specification](#{site.urls.spec}#arithmetic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
