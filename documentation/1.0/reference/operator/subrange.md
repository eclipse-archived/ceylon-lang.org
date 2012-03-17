---
layout: reference
title: `[x..y]` (subrange) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *subrange* operator returns the subrange of its left-hand operand
indexed by its right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] firstAndSecond = names[0..1];
    String[] secondAndThird = names[1..2];

## Description

### Definition

The `[x..y]` operator is defined as follows:

<!-- no-check -->
    range(lhs,x,y)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[x..y]` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`[x...]` (upper range)](../upper-range) operator used for obtaining a tail of a sequence
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

