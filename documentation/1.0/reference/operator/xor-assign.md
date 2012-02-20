---
layout: reference
title: `^=` (xor assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

The right-associative, binary `^=` operator is used to compute the 
*exclusive or* of two operands, assigning the result to the left-hand 
operand.

## Usage 

    variable Integer one = 1;
    one ^= 3; // now 'one' has value 2

## Description

### Definition

The `^=` operator is defined as follows:

    lhs:=lhs^rhs

See the [language specification](#{site.urls.spec}#slotwise) for 
more details.

### Polymorphism

The `^=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The `^` in the definition is the [xor operator](../xor) which depends on the 
[`Slots`](#{site.urls.apidoc}/ceylon/language/interface_Slots.html) interface.

## See also

* [`^` (xor)](../xor) operator
* API documentation for [`Slots`](#{site.urls.apidoc}/ceylon/language/interface_Slots.html)
* [slotwise operators](#{site.urls.spec}#slotwise) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

