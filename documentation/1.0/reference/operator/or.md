---
layout: reference
title: '`||` (or) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `||` operator is used to compute the 
logical *or* of two operands.

## Usage 

    Boolean true_ = true || false;

## Description

### Definition

The `||` operator is defined as:

<!-- check:none -->
    if (lhs) true else rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#logical) for 
more details.

### Polymorphism

The `||` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [logical operators](#{page.doc_root}/#{site.urls.spec_relative}#logical) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification

