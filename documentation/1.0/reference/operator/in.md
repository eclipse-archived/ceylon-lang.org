---
layout: reference
title: '`in` (containment) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `in` operator is used to test whether its left-hand 
operand is *contained in* its right-hand operand

## Usage 

    void m(Object x, Category y) {
        Boolean contained = x in y;
    }

## Description

### Definition
The `in` operator is defined as follows:

<!-- check:none -->
    lhs.contained(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `in` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `in` depends on the 
[`Category`](#{site.urls.apidoc_current}/interface_Category.html) interface

## See also

* API documentation for [`Category`](#{site.urls.apidoc_current}/interface_Category.html)
* [`in` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

