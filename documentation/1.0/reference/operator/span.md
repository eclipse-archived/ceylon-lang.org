---
layout: reference
title: '`x[y..z]` (span) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *span* operator returns the subrange of its left-hand operand
indexed by its centre and right-hand operands.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] firstAndSecond = names[0..1];
    String[] secondAndThird = names[1..2];

## Description

### Definition

The `lhs[from..to]` operator is defined as follows:

<!-- check:none -->
    lhs.span(from,to)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `x[y..z]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `lhs[from..to]` depends on the 
[`Ranged`](#{site.urls.apidoc_current}/interface_Ranged.html) 
interface.

## See also

* [`x[y...]` (upper span)](../upper-span) operator used for obtaining a tail of a `Ranged`.
* API documentation for [`Ranged`](#{site.urls.apidoc_current}/interface_Ranged.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

