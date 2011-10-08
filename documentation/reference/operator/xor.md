---
layout: reference
title: `^` (xor) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `^` operator is used to compute the 
*exclusive-or* of two operands, for example:

    Natural two = 1 ^ 3;

## Description

### Polymorphism

The `^` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `^` depends on the 
[`Slots`](../../ceylon.language/Slots) interface as follows:

    lhs.xor(rhs)

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of *xor* for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`|` performs a normal bitwise *xor*. 

## See also

* [`Slots`](../../ceylon.language/Slots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

