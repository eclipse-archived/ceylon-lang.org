---
layout: reference
title: '`->` (entry) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The *entry* operator creates an `Entry` from its key and value.

## Usage 

    Entry<Integer, String> intName = 1 -> "One";

## Description


### Definition

The `->` operator is defined as follows:

<!-- check:none -->
    Entry(lhs, rhs)

See the [language specification](#{site.urls.spec_current}#constructors) for 
more details.

### Polymorphism

The `->` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [object creation operators](#{site.urls.spec_current}#constructors) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

