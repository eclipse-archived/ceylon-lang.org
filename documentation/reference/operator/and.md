---
layout: reference
title: `&` (intersection) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The left-associative, binary `&` operator is used to compute the 
*intersection* of two operands, for example:

    Natural one = 1 & 2;

It it also commonly used to intersect types, so that the declared entity 
is assignable to both (or all) of the given types:

    Foo&Bar foobar;

## Description

### Polymorphism

The `&` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `&` depends on the 
[`Slots`](../../ceylon.language/Slots) interface as follows:

    lhs.and(rhs)

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of and for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`&` performs a normal bitwise *and*. 

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

