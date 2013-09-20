---
layout: reference
title: '`!` (not) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, unary `||` operator is used to compute the 
logical *not* of its operand.

## Usage 

<!-- try: -->
    Boolean true_ = !false;

## Description

### Definition

The `!` operator is defined as:

<!-- check:none -->
<!-- try: -->
    if (rhs) false else true

See the [language specification](#{site.urls.spec_current}#logical) for 
more details.

### Polymorphism

The `!` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The type of `!` is `Boolean`.

## See also

* [logical operators](#{site.urls.spec_current}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

