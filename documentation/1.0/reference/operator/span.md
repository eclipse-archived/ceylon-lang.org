---
layout: reference
title: '`x[y..z]` (span) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The *span* operator returns the subrange of its left-hand operand
indexed by its centre and right-hand operands.

## Usage 

<!-- try: -->
    String[] names = {"foo", "bar", "baz"};
    String[] firstAndSecond = names[0..1];
    String[] secondAndThird = names[1..2];

## Description

### Definition

The `lhs[from..to]` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.span(from,to)

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `x[y..z]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `lhs[from..to]` depends on the 
[`Ranged`](#{site.urls.apidoc_current}/Ranged.type.html) 
interface.

### Type

The type of `lhs[from..to]` is the element type of the `Ranged` `lhs`.

## See also

* [`x[y...]` (upper span)](../upper-span) operator used for obtaining a tail of a `Ranged`.
* API documentation for [`Ranged`](#{site.urls.apidoc_current}/Ranged.type.html)
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

