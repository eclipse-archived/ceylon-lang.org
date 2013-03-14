---
layout: reference
title: '`~=` (complement assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `~=` operator is used to compute the 
*complement* of its left-hand operand in its right-hand operand, assigning the 
result to the left-hand operand. 

## Usage 

<!-- check:none -->
    void m<Dog>(Set<Dog> dogs, Set<Dog> blackDogs) 
      given Dog satisfies Object {
        variable Set<Dog> nonBlackDogs = dogs;
        nonBlackDogs ~= blackDogs;
    }

## Description


### Definition

The `~` operator is defined as follows:

<!-- check:none -->
    lhs = lhs ~ rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#sets) for 
more details.

### Polymorphism

The `~=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

The `~` in the definition is the [complement](../complement) operator 
which depends on the [`Set`](#{site.urls.apidoc_current}/ceylon/language/interface_Set.html) interface.

## See also

* [`~`](../complement) (complement) operator
* [`Set`](#{site.urls.apidoc_current}/ceylon/language/interface_Set.html)
* [set operators](#{page.doc_root}/#{site.urls.spec_relative}#sets) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

