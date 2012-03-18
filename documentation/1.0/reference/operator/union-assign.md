---
layout: reference
title: `|=` (union assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `|=` operator is used to compute the 
*union* of two operands, assigning the result to the left-hand 
operand.

## Usage

<!-- check:none -->
    void m(Set<Integer> odds, Set<Integer> evens) {
        variable Set<Integer> all := odds;
        all |= evens;
    }

## Description


### Definition

The `|=` operator is defined as follows:

<!-- check:none -->
    lhs:=lhs|rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#sets) for 
more details.

### Polymorphism

The `|=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
Tge `|` in its definition is the [union operator](../union) which depends on the 
[`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html) interface.

## See also

* [`|` (union)](../union) operator
* API documentation for [`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html)
* [set operators](#{page.doc_root}/#{site.urls.spec_relative}#sets) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 


