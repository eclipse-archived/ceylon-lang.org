---
layout: reference
title: `~` (complement) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, unary `~` operator is used to compute the 
*complement* of its operands, for example:

    Natural minusTwo = ~1;

## Description

### Polymorphism

The `~` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `~` depends on the 
[`FixedSlots`](../../ceylon.language/FixedSlots) interface as follows:

    rhs.complement;

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of *complement* for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`~` performs a normal bitwise *complement*. 

## See also

* [binary `~`](../complement-in)
* [`FixedSlots`](../../ceylon.language/FixedSlots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

