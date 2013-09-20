---
layout: reference
title: '`~` (complement) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary infix `~` operator is used to compute the 
*complement* of its left-hand operand in its right-hand operand. 

## Usage 

<!-- check:none -->
<!-- try: -->
    void m<Dog>(Set<Dog> dogs, Set<Dog> blackDogs) 
      given Dog satisfies Object {
        Set<Dog> nonBlackDogs = dogs ~ blackDogs;
    }

## Description

Another way of describing this operator is 'set minus'.

### Definition

The `~` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.complement(rhs);

See the [language specification](#{site.urls.spec_current}#sets) for 
more details.

### Polymorphism

The `~` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `~` depends on the 
[`Set`](#{site.urls.apidoc_current}/Set.type.html) interface.

### Type

The type of `~` is a [`Set`](#{site.urls.apidoc_current}/Set.type.html) with the same element type as 
the left hand operand's element type.

## See also

* API documentation for [`Set`](#{site.urls.apidoc_current}/Set.type.html)
* [set operators](#{site.urls.spec_current}#sets) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

