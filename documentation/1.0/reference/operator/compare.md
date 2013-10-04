---
layout: reference
title_md: '`<=>` (compare) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary infix `<=>` operator is used to *compare* the order of 
its operands.

## Usage 

<!-- try: -->
    void m<T>(T x, T y) given T satisfies Comparable<T> {
        Comparison cmp = x <=> y;
    }

## Description

### Definition

The `<=>` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.compare(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `<=>` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `<=>` depends on the 
[`Comparable`](#{site.urls.apidoc_current}/Comparable.type.html) interface 

### Type

The result type of the `<=>` operator is [`Comparison`](#{site.urls.apidoc_current}/Comparison.type.html).

## See also

* API documentation for [`Comparable`](#{site.urls.apidoc_current}/Comparable.type.html)
* [compare in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

