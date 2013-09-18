---
layout: reference
title: '`?.` (null-safe member) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `?.` operator is used to access a member if
the its right-hand operand is not `null`.

## Usage 

<!-- try: -->
    void m(Integer? num) {
        Integer? int = num?.positiveValue;
    }

## Description

### Definition

The meaning of `?.` is defined as follows:

<!-- check:none -->
<!-- try: -->
    if (exists lhs) lhs.member else null	

### Polymorphism

The `?.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`?` (default)](../default) operator
* [`?.`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
