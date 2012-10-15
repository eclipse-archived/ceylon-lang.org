---
layout: reference
title: '`[].` (spread attribute) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *spread attribute* operator maps a sequence of instances through an 
attribute, resulting in a sequence of the attribute values.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    Integer[] sizes = names[].size;

## Description

### Definition

The `[].` operator is defined by the sequence comprehension:

<!-- check:none -->
    { for (X x in lhs) x.member }

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[x..]` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`[].` (spread invoke)](../spread invoke) operator, the equivalent of the 
  spread attribute operator but for methods;
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

