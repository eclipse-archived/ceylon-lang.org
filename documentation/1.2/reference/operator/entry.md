---
layout: reference12
title_md: '`->` (entry) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The infix *entry* operator creates an `Entry` from its key and value.

## Usage 

<!-- try: -->
    Entry<Integer, String> intName = 1 -> "One";

## Description


### Definition

The `->` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    Entry(lhs, rhs)

See the [language specification](#{site.urls.spec_current}#constructors) for 
more details.

### Polymorphism

The `->` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `lhs->rhs` operator is `Entry<Lhs,Rhs>` where `Lhs` is the type of `lhs` and `Rhs` is the type of `rhs`.

## See also

* [object creation operators](#{site.urls.spec_current}#constructors) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

