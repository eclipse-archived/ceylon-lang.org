---
layout: reference
title: `~` (complement in) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

The left-associative, binary `~` operator is used to compute the 
*complement* of its left-hand operand in its right-hand operand. 

## Usage 

    Set<T> a;
    Set<T> b;
    // Code initializing a and b
    Set<T> aExceptB = a~b;

## Description

Another way of describing this operator is 'set minus'.

### Definition

The `~` operator is defined as follows:

    lhs.complement(rhs);

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Polymorphism

The `~` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `~` depends on the 
[`Slots`](../../ceylon.language/Slots) interface.

### Meaning of *complement in* for built-in types

TODO

## See also

* [unary `~`](../complement)
* [`Slots`](../../ceylon.language/Slots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and the
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

