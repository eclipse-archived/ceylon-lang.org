---
layout: reference
title: '`x[y:n]` (segment) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 4
doc_root: ../../..
---

# #{page.title}

The *segment* operator returns the subrange of its left-hand operand
starting from its central operand and including as many elements as given by 
its right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] foo = names[0:1];
    String[] barBaz = names[1:2];
    String[] empty = names[1:0];

## Description

### Definition

The `lhs[from:length]` operator is defined as follows:

<!-- check:none -->
    lhs.segment(from,length)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `x[y:n]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `x[y:n]` depends on the 
[`Ranged`](#{site.urls.apidoc_current}/interface_Ranged.html) 
interface.

## See also

* [`x[y...z]` (span)](../span) operator used for obtaining a subrange from a `Ranged`.
* API documentation for [`Ranged`](#{site.urls.apidoc_current}/interface_Ranged.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

