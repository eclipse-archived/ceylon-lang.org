---
layout: reference
title_md: '`&=` (intersect assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

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

The `&` in the definition is the [intersection operator](../intersection) which 
depends on the [`Set`](#{site.urls.apidoc_1_0}/Set.type.html) interface.

### Type

The result type of the `&=` operator is a [`Set`](#{site.urls.apidoc_1_0}/Set.type.html) with the same element type as 
the left hand operand's element type.

## See also

* [`&` (intersection)](../intersection) operator
* API documentation for [`Set`](#{site.urls.apidoc_1_0}/Set.type.html)
* [set operators](#{site.urls.spec_current}#sets) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 

