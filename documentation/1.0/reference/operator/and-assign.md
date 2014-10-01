---
layout: reference
title_md: '`&&=` (and assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, binary infix `&&=` operator is used to compute the 
logical *and* of two operands, assigning the result to the left-hand operand. 

## Usage 

<!-- cat: void m() { -->
<!-- try: -->
    variable Boolean a = true;
    Boolean b = false;
    a &&= b; // a becomes false
<!-- cat: } -->

## Description

### Definition

The `&&=` operator is defined as:

<!-- check:none -->
<!-- try: -->
    if (lhs) lhs =rhs else false

See the [language specification](#{site.urls.spec_current}#logical) for 
more details.

### Polymorphism

The `&&` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

### Type

The result type of the `&&=` operator is [`Boolean`](#{site.urls.apidoc_1_0}/Boolean.type.html).

## See also

* [logical operators](#{site.urls.spec_current}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

