---
layout: reference
title_md: '`~=` (complement assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, binary infix `~=` operator is used to compute the 
*complement* of its left-hand operand in its right-hand operand, assigning the 
result to the left-hand operand. 

## Usage 

<!-- check:none -->
<!-- try: -->
    void m<Dog>(Set<Dog> dogs, Set<Dog> blackDogs) 
      given Dog satisfies Object {
        variable Set<Dog> nonBlackDogs = dogs;
        nonBlackDogs ~= blackDogs;
    }

## Description


### Definition

The `~` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs = lhs ~ rhs

See the [language specification](#{site.urls.spec_current}#sets) for 
more details.

### Polymorphism

The `~=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

The `~` in the definition is the [complement](../complement) operator 
which depends on the [`Set`](#{site.urls.apidoc_current}/Set.type.html) interface.

### Type

The result type of the `~=` operator is a [`Set`](#{site.urls.apidoc_current}/Set.type.html) with the same element type as 
the left hand operand's element type.

## See also

* [`~`](../complement) (complement) operator
* [`Set`](#{site.urls.apidoc_current}/Set.type.html)
* [set operators](#{site.urls.spec_current}#sets) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

