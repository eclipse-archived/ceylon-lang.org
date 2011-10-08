---
layout: reference
title: `~` (complement in) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

    Set<T> a;
    Set<T> b;
    // Code initializing a and b
    Set<T> aExceptB = a~b;

## Description

The left-associative, binary `~` operator is used to compute the 
*complement* of its left hand operand in its right hand operand. In other 
words, binary '~' is 'set minus'.

### Polymorphism

The `~` operator is [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 
The meaning of `~` depends on the 
[`Slots`](../../ceylon.language/Slots) interface as follows:

    lhs.complement(rhs);

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of and for built-in types

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

