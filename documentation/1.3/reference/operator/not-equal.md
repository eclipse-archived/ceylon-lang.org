---
layout: reference13
title_md: '`!=` (not equal) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary infix `!=` operator is used to test whether its operands 
are *not equal*.

## Usage 

<!-- try: -->
    void m(Object x, Object y) {
        Boolean identical = x != y;
    }

## Description

### Definition

The `!=` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    !lhs.equals(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `!=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `!=` depends on the 
[`Object`](#{site.urls.apidoc_1_3}/Object.type.html) class.

### Type

The result type of the `!=` operator is [`Boolean`](#{site.urls.apidoc_1_3}/Boolean.type.html).

## See also

* [`==` (equal)](../equal) operator
* API documentation for [`Object`](#{site.urls.apidoc_1_3}/Object.type.html)
* [not equal in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

