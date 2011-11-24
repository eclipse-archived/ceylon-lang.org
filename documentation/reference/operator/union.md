---
layout: reference
title: `|` (union) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

The left-associative, binary `|` operator is used to compute the 
*union* of two operands.

## Usage 

    Natural two = 1 | 2;

## Description

The `|` operator is also commonly used to [union types](/documentation/reference/structure/type), 
so that the declared entity is assignable to either (or one) of the given types:

    Foo|Bar fooOrBar;

### Definition

The `|` operator is defined as follows:

    lhs.or(rhs)

See the [language specification](#{site.urls.spec}#slotwise) for 
more details.

### Polymorphism

The `|` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `|` depends on the 
[`Slots`](#{site.urls.apidoc}/ceylon/language/interface_Slots.html) interface 

### Meaning of *union* for built-in types

For the built-in numeric types ([`Natural`](#{site.urls.apidoc}/ceylon/language/class_Natural.html), 
[`Integer`](#{site.urls.apidoc}/ceylon/language/class_Integer.html) and
[`Whole`](#{site.urls.apidoc}/ceylon/language/class_Whole.html) 
`|` performs a normal bitwise *or*. 

## See also

* API documentation for [`Slots`](#{site.urls.apidoc}/ceylon/language/interface_Slots.html)
* [slotwise operators](#{site.urls.spec}#slotwise) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Slots Interface](/documentation/tour/language-module/#the_slots_interface) 
  in the Tour of Ceylon

