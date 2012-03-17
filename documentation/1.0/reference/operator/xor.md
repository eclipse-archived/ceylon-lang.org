---
layout: reference
title: `^` (xor) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `^` operator is used to compute the 
*exclusive-or* of two operands.

## Usage

    Integer two = 1 ^ 3;

## Description

### Definition

The `^` operator is defined as follows:

<!-- no-check -->
    lhs.xor(rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) for 
more details.

### Polymorphism

The `^` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `^` depends on the 
[`Slots`](#{page.doc_root}/api/ceylon/language/interface_Slots.html) interface 

### Meaning of *xor* for built-in types

For the built-in numeric types ([`Integer`](#{page.doc_root}/api/ceylon/language/class_Integer.html), 
[`Integer`](#{page.doc_root}/api/ceylon/language/class_Integer.html) and
[`Whole`](#{page.doc_root}/api/ceylon/language/class_Whole.html) 
`|` performs a normal bitwise *xor*. 

## See also

* API documentation for [`Slots`](#{page.doc_root}/api/ceylon/language/interface_Slots.html)
* [slotwise operators](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](#{page.doc_root}/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

