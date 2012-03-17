---
layout: reference
title: `[]` (sequenced lookup) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *sequenced lookup* operator accesses several elements in a 
[`Correspondence`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html) 
using a 
[`Sequence`](#{page.doc_root}/api/ceylon/language/interface_Sequence.html).

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] firstAndLast = names[{0, 2}];

## Description

Unlike the plain [lookup](../lookup) operator, the *sequenced lookup* operator
allows lookup up several items in one go, returning a `Sequence` of the items.

### Definition

The `[]` operator is defined as follows:

<!-- no-check -->
    lhs.items(index)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `[]` depends on the 
[`Correspondence`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html) 
interface.

## See also

* [`[]` (lookup)](../lookup) operator used for accessesing a single item
* [`[]` (iterated lookup)](../iterated-lookup) operator used for accessesing several items using an iterable
* API documentation for [`Correspondence`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

