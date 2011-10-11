---
layout: reference
title: `~=` (complement assign) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

## Usage 

    Set<T> a;
    Set<T> b;
    // Code initializing a and b
    Set<T> aExceptB = a~b;

## Description

The right-associative, binary `~=` operator is used to compute the 
*complement* of its left hand operand in its right hand operand, assigning the 
result to the left hand operand. 
In other words, '~=' is 'set minus' with assign.

### Polymorphism

The `~=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism),
and is defined as follows:

    lhs := lhs~rhs

Where `~` is the [complement in](../complement-in) operator which depends on the 
[`Slots`](../../ceylon.language/Slots) interface.

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of *complement assign* for built-in types

TODO

## See also

* [unary `~`](../complement) (complement) operator
* [binary `~`](../complement-in) (complement in) operator
* [`Slots`](../../ceylon.language/Slots)
* [slotwise operators](#{site.urls.spec}#slotwiseoperators) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and the
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

