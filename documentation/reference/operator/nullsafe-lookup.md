---
layout: reference
title: `?[]` (null-safe lookup) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The *null-safe lookup* operator accesses an element in a 
[`Correspondence?`](#{site.urls.apidoc}/ceylon/language/interface_Correspondence.html) if that operand is 
not `null`, otherwise results in `null`.

## Usage 

    String[]? names = {"foo", "bar", "baz"};
    Iterable<Natural> keys = {1, 2};
    Iterable<String> firstAndLast = names?[keys];

## Description

### Definition

The `?[]` operator is defined as follows:

    if (exists lhs) lhs[index] else null	

See the [language specification](#{site.urls.spec}#listmap) for 
more details.

### Polymorphism

The `?[]` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `?[]` depends on the 
[`Correspondence`](#{site.urls.apidoc}/ceylon/language/interface_Correspondence.html) 
interface.

## See also

* [`[]` (lookup)](../lookup) operator used for accessesing a single item
* API documentation for [`Correspondence`](#{site.urls.apidoc}/ceylon/language/interface_Correspondence.html)
* [sequence operators](#{site.urls.spec}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

