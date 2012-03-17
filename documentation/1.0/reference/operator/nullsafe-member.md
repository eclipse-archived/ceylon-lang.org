---
layout: reference
title: `?.` (null-safe member) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `?.` operator is used to access a member if
the its right-hand operand is not `null`.

## Usage 

    void m(Integer? num) {
        Integer? int = num?.positiveValue;
    }

## Description

### Definition

The meaning of `?.` is defined as follows:

<!-- no-check -->
    if (exists lhs) lhs.member else null	

### Polymorphism

The `?.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`?` (default)](../default) operator
* [`?.`](#{page.doc_root}/#{site.urls.spec_relative}#nullvalues) in the language specification.
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
