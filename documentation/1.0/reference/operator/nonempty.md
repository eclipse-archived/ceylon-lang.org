---
layout: reference
title: `nonempty` operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, unary `nonempty` operator is used to test its operand for 
emptiness.

## Usage 

    void m(Integer[] nums) {
        Boolean haveNums = nums nonempty;
    }

## Description

### Definition

The meaning of `exists` is defined as follows:

<!-- no-check -->
    if (nonempty lhs) true else false

See the [`language specification`](#{page.doc_root}/#{site.urls.spec_relative}#nullvalues) for more details.

### Polymorphism

The `nonempty` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`nonempty`](#{page.doc_root}/#{site.urls.spec_relative}#nullvalues) in the language specification.
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
