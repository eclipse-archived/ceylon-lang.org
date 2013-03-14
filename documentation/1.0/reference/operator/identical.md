---
layout: reference
title: '`===` (identical) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `===` operator is used to test whether its operands 
are *identical*

## Usage 

    void m(IdentifiableObject x, IdentifiableObject y) {
        Boolean identical = x === y;
    }

## Description

### Definition 

The `===` operator is defined as follows:

<!-- check:none -->
    lhs.identical(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `===` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `===` depends on the 
[`IdentifiableObject`](#{site.urls.apidoc_current}/class_IdentifiableObject.html) interface

### Meaning of *identical* for built-in types

TODO

## See also

* [`==` (equal)](../equal) operator
* API documentation for [`IdentifiableObject`](#{site.urls.apidoc_current}/class_IdentifiableObject.html)
* [identical in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
