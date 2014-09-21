---
layout: reference11
title_md: '`&` (intersection) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary infix `&` operator is used to compute the 
*intersection* of its operands.

## Usage 

Intersection on values:

<!-- check:none -->
<!-- try: -->
    void m(Set<Integer> primes, Set<Integer> evens) {
        Set<Integer> two = primes & evens;
    }

## Description

**Note**: The `&` operator is also commonly used to 
[intersect types](#{page.doc_root}/reference/structure/type#intersection_types). 
This page is about using the `&` operator on *values*.

### Definition

The `&` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.intersection(rhs)

See the [language specification](#{site.urls.spec_current}#sets) for 
more details.

### Polymorphism

The `&` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `&` depends on the 
[`Set`](#{site.urls.apidoc_current}/Set.type.html) interface 

### Type

The result type of the `|` operator is a [`Set`](#{site.urls.apidoc_current}/Set.type.html) whose element type is the intersection of the 
element types of its operands.

## See also

* API documentation for [`Set`](#{site.urls.apidoc_current}/Set.type.html)
* [set operators](#{site.urls.spec_current}#sets) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

