---
layout: reference
title: '`[...x]` (lower span) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 4
doc_root: ../../..
---

# #{page.title}

The *lower span* operator returns the elements of its left-hand `Ranged` 
operand upto and including the element whose key is specified by its 
right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] foo = names[...0];
    String[] foobar = names[...1];
    String[] emptySequence = names[...-1];

## Description

### Definition

The `[...x]` operator is defined as follows:

<!-- check:none -->
    lhs.spanTo(rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[...x]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `[...x]` depends on the 
[`Ranged`](#{page.doc_root}/api/ceylon/language/interface_Ranged.html) 
interface.

## See also

* [`[x..y]` (span)](../span) operator used for obtaining a span of a `Ranged`.
* [`[x...]` (upper span)](../upper-span) operator used for obtaining a span of a `Ranged`.
* API documentation for [`Ranged`](#{page.doc_root}/api/ceylon/language/interface_Ranged.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

