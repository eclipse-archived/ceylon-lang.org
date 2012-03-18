---
layout: reference
title: `?` (default) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `?` operator is used to specify a *default* value.

## Usage 

    void m(Integer? num) {
        Integer numOrDefault = num ? 0;
    }

## Description

### Definition

The meaning of `?` is defined as follows:

<!-- check:none -->
    if (exists lhs) lhs else rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#nullvalues) for more details.

### Polymorphism

The `?` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`?`](#{page.doc_root}/#{site.urls.spec_relative}#nullvalues) in the language specification.
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
