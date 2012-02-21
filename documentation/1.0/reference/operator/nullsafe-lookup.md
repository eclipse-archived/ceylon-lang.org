---
layout: reference
title: `?[]` (null-safe lookup) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *null-safe lookup* operator accesses an element in a 
[`Correspondence?`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html) if that operand is 
not `null`, otherwise results in `null`.

## Usage 

    String[]? names = {"foo", "bar", "baz"};
    Iterable<Integer> keys = {1, 2};
    Iterable<String> firstAndLast = names?[keys];

## Description

### Definition

The `?[]` operator is defined as follows:

    if (exists lhs) lhs[index] else null	

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `?[]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `?[]` depends on the 
[`Correspondence`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html) 
interface.

## See also

* [`[]` (lookup)](../lookup) operator used for accessesing a single item
* API documentation for [`Correspondence`](#{page.doc_root}/api/ceylon/language/interface_Correspondence.html)
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

