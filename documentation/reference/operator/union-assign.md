---
layout: reference
title: `|=` (union assign) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

The right-associative, binary `|=` operator is used to compute the 
*union* of two operands, assigning the result to the left-hand 
operand.

## Usage

    variable Natural one = 1;
    one |= 2; // now 'one' has value 3

## Description


### Definition

The `|=` operator is defined as follows:

    lhs:=lhs|rhs

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Polymorphism

The `|=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
Tge `|` in its definition is the [union operator](../union) which depends on the 
[`Slots`](../../ceylon.language/Slots) interface.

### Meaning of *union assign* for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`|=` performs a normal bitwise *or and assign*. 

## See also

* [`|` (union)](../union) operator
* [`Slots`](../../ceylon.language/Slots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

