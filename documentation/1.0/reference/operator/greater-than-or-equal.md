---
layout: reference
title: '`>=` (greater than or equal) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `>=` operator is used to test whether its left-hand 
operand is *greater than or equal to* its right-hand operand.

## Usage 

<!-- try: -->
    void m<T>(T x, T y) 
      given T satisfies Comparable<T> {
        Boolean greaterOrEqual = x >= y;
    }

## Description

### Definition

The `>=` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.compare(rhs)!=smaller;

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `>=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `>=` depends on the 
[`Comparable`](#{site.urls.apidoc_current}/Comparable.type.html) interface.

## See also

* API documentation for [`Comparable`](#{site.urls.apidoc_current}/Comparable.type.html)
* [`>=` in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

