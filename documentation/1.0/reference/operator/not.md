---
layout: reference
title: '`!` (not) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, unary `||` operator is used to compute the 
logical *not* of its operand.

## Usage 

    Boolean true_ = !false;

## Description

### Definition

The `!` operator is defined as:

<!-- check:none -->
    if (rhs) false else true

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#logical) for 
more details.

### Polymorphism

The `!` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [logical operators](#{page.doc_root}/#{site.urls.spec_relative}#logical) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification

