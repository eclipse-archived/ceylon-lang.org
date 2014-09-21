---
layout: reference11
title_md: '`in` (containment) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary infix `in` operator is used to test whether its left-hand 
operand is *contained in* its right-hand operand

## Usage 

<!-- try: -->
    void m(Object x, Category y) {
        Boolean contained = x in y;
    }

## Description

### Definition
The `in` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.contained(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `in` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `in` depends on the 
[`Category`](#{site.urls.apidoc_current}/Category.type.html) interface

### Type

The result type of the `in` operator is [`Boolean`](#{site.urls.apidoc_current}/Boolean.type.html).

## See also

* API documentation for [`Category`](#{site.urls.apidoc_current}/Category.type.html)
* [`in` in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

