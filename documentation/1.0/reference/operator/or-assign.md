---
layout: reference
title: `||=` (or assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `||=` operator is used to compute the 
logical *or* of two operands, assigning the result to the left-hand operand. 

## Usage 

    variable Boolean a := false;
    Boolean b = true;
    a ||= b; // a becomes true

## Description

### Definition

The `||=` operator is defined as:

<!-- no-check -->
    if (lhs) true else lhs:=rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#logical) for 
more details.

### Polymorphism

The `||` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [logical operators](#{page.doc_root}/#{site.urls.spec_relative}#logical) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification

