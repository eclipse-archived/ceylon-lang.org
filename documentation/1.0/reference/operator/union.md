---
layout: reference
title: `|` (union) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `|` operator is used to compute the 
*union* of two operands.

## Usage 

Union on values:

<!-- no-check -->
    void m(Set<Integer> odds, Set<Integer> evens) {
        Set<Integer> ints = odds | evens;
    }
  
## Description

**Note**: The `|` operator is also commonly used to 
[union types](#{page.doc_root}/reference/structure/type#union_types). 
This page is about using the `|` operator on values.

### Definition

The `|` operator is defined as follows:

<!-- no-check -->
    lhs.union(rhs)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#slotwise) for 
more details.

### Polymorphism

The `|` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `|` depends on the 
[`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html) interface 

## See also

* API documentation for [`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html)
* [set operators](#{page.doc_root}/#{site.urls.spec_relative}#sets) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 


