---
layout: reference
title: `~` (complement) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `~` operator is used to compute the 
*complement* of its left-hand operand in its right-hand operand. 

## Usage 

    void m<Dog>(Set<Dog> dogs, Set<Dog> blackDogs) 
      given Dog satisfies Object {
        Set<Dog> nonBlackDogs = dogs ~ blackDogs;
    }

## Description

Another way of describing this operator is 'set minus'.

### Definition

The `~` operator is defined as follows:

<!-- no-check -->
    lhs.complement(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#sets) for 
more details.

### Polymorphism

The `~` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `~` depends on the 
[`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html) interface.


## See also

* API documentation for [`Set`](#{page.doc_root}/api/ceylon/language/interface_Set.html)
* [set operators](#{page.doc_root}/#{site.urls.spec_relative}#sets) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

