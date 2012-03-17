---
layout: reference
title: `^=` (xor assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
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

<!-- no-check -->
    lhs:=lhs^rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) for 
more details.

### Polymorphism

The `^=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The `^` in the definition is the [xor operator](../xor) which depends on the 
[`Slots`](#{page.doc_root}/api/ceylon/language/interface_Slots.html) interface.

## See also

* [`^` (xor)](../xor) operator
* API documentation for [`Slots`](#{page.doc_root}/api/ceylon/language/interface_Slots.html)
* [slotwise operators](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](#{page.doc_root}/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

