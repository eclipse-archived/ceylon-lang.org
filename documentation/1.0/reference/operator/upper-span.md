---
layout: reference
title: `[x...]` (upper span) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *upper span* operator returns the tail of its left-hand `Ranged` operand
as specified by its right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] secondAndThird = names[1..];
    String[] third = names[2..];
    String[] emptySequence = names[3..];

## Description

### Definition

The `[x..]` operator is defined as follows:

<!-- no-check -->
    lhs.span(from)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[x..]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `[x..]` depends on the 
[`Ranged`](#{page.doc_root}/api/ceylon/language/interface_Ranged.html) 
interface.

## See also

* [`[x..y]` (span)](../span) operator used for obtaining a span of a `Ranged`.
* API documentation for [`Ranged`](#{page.doc_root}/api/ceylon/language/interface_Ranged.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

