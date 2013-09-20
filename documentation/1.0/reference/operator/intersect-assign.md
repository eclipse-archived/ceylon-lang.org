---
layout: reference
title: '`&=` (intersect assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary infix `&=` operator is used to compute the 
*intersection* of two operands, assigning the result to the left-hand 
operand.

## Usage 

<!-- check:none -->
<!-- try: -->
    void m(Set<Integer> primes, Set<Integer> evens) {
        variable Set<Integer> two = primes;
        two &= evens;
    }

## Definition

And is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs = lhs & rhs

See the [language specification](#{site.urls.spec_current}#sets) for 
more details.

### Polymorphism

The `&=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

The `&` in the definition is the [intersect operator](../intersect) which 
depends on the [`Set`](#{site.urls.apidoc_current}/Set.type.html) interface.

### Type

The type of `&=` is a [`Set`](#{site.urls.apidoc_current}/Set.type.html) with the same element type as 
the left hand operand's element type.

## See also

* [`&` (intersect)](../intersect) operator
* API documentation for [`Set`](#{site.urls.apidoc_current}/Set.type.html)
* [set operators](#{site.urls.spec_current}#sets) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

