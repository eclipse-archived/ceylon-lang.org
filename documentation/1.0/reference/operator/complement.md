---
layout: reference
title: `~` (complement) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 3
doc_root: ../../..
---

# #{page.title}

The right-associative, unary `~` operator is used to compute the 
*complement* of its operands.

## Usage 

    Integer minusTwo = ~1;

## Description

### Definition

The `~` operator is defined as follows:

<!-- no-check -->
    rhs.complement;

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) for 
more details.

### Polymorphism

The `~` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `~` depends on the 
[`FixedSlots`](#{page.doc_root}/api/ceylon/language/interface_FixedSlots.html) interface 

## See also

* [binary `~`](../complement-in)
* API documentation for [`FixedSlots`](#{page.doc_root}/api/ceylon/language/interface_FixedSlots.html)
* [slotwise operators](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](#{page.doc_root}/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

