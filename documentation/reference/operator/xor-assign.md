---
layout: reference
title: `^=` (xor assign) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

## Usage 

The right-associative, binary `^=` operator is used to compute the 
*exclusive or* of two operands, assigning the result to the left hand 
operand, for example:

    variable Natural one = 1;
    one ^= 3; // now 'one' has value 2

## Description

### Polymorphism

The `^=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
And is defined as follows:

    lhs:=lhs^rhs

Where `^` is the [xor operator](../xor) which depends on the 
[`Slots`](../../ceylon.language/Slots) interface.

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of *xor assign* for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`^=` performs a normal bitwise *xor and assign*. 

## See also

* [`^` (xor)](../xor) operator
* [`Slots`](../../ceylon.language/Slots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

