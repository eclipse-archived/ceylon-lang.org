---
layout: reference11
title_md: '`!` (not) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

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

The result type of the `!` operator is [`Boolean`](#{site.urls.apidoc_current}/Boolean.type.html).

### Notes

* The `!` operator has a _much_ lower precedence than other C-like
  languages!

## See also

* [logical operators](#{site.urls.spec_current}#logical) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification

