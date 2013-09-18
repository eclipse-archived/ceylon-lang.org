---
layout: reference
title: '`&&=` (and assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `&&=` operator is used to compute the 
logical *and* of two operands, assigning the result to the left-hand operand. 

## Usage 

<!-- cat: void m() { -->
    variable Boolean a = true;
    Boolean b = false;
    a &&= b; // a becomes false
<!-- cat: } -->

## Description

### Definition

The `&&=` operator is defined as:

<!-- check:none -->
    if (lhs) lhs =rhs else false

See the [language specification](#{site.urls.spec_current}#logical) for 
more details.

### Polymorphism

The `&&` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

## See also

* [logical operators](#{site.urls.spec_current}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

