---
layout: reference12
title_md: '`&&` (and) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary infix `&&` operator is used to compute the 
logical *and* of two operands

## Usage 

<!-- try: -->
    Boolean false_ = true && false;

## Description

### Definition

The `&&` operator is defined as:

<!-- check:none -->
<!-- try: -->
    if (lhs) rhs else false

See the [language specification](#{site.urls.spec_current}#logical) for 
more details.

### Polymorphism

The `&&` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

### Type

The result type of the `&&` operator is [`Boolean`](#{site.urls.apidoc_1_2}/Boolean.type.html).

## See also

* [logical operators](#{site.urls.spec_current}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

