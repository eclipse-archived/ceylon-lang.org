---
layout: reference
title: `|` (union) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `|` operator is used to compute the 
*union* of two operands.

## Usage 

    Integer two = 1 | 2;

## Description

The `|` operator is also commonly used to [union types](#{page.doc_root}/reference/structure/type), 
so that the declared entity is assignable to either (or one) of the given types:

    Foo|Bar fooOrBar;

### Definition

The `|` operator is defined as follows:

    lhs.or(rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) for 
more details.

### Polymorphism

The `|` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `|` depends on the 
[`Slots`](#{page.doc_root}/api/ceylon/language/interface_Slots.html) interface 

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

