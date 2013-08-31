---
layout: reference
title: '`!=` (not equal) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `!=` operator is used to test whether its operands 
are *not equal*.

## Usage 

    void m(Object x, Object y) {
        Boolean identical = x != y;
    }

## Description

### Definition

The `!=` operator is defined as follows:

<!-- check:none -->
    !lhs.equals(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `!=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `!=` depends on the 
[`Object`](#{site.urls.apidoc_current}/class_Object.html) class.

## See also

* [`==` (equal)](../equal) operator
* API documentation for [`Object`](#{site.urls.apidoc_current}/class_Object.html)
* [not equal in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

