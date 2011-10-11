---
layout: reference
title: `|` (union) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

## Usage 

The left-associative, binary `|` operator is used to compute the 
*union* of two operands, for example:

    Natural two = 1 | 2;

It it also commonly used to union types, so that the declared entity 
is assignable to either (or one) of the given types:

    Foo|Bar fooOrBar;

## Description

### Polymorphism

The `|` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `|` depends on the 
[`Slots`](../../ceylon.language/Slots) interface as follows:

    lhs.or(rhs)

See the [language specification](#{site.urls.spec}#slotwiseoperators) for 
more details.

### Meaning of *union* for built-in types

For the built-in numeric types ([`Natural`](../../ceylon.language/Natural), 
[`Integer`](../../ceylon.language/Integer) and
[`Whole`](../../ceylon.language/Whole) 
`|` performs a normal bitwise *or*. 

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

