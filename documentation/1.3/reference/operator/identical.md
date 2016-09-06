---
layout: reference13
title_md: '`===` (identical) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary infix `===` operator is used to test whether its operands 
are *identical*

## Usage 

<!-- try: -->
    void m(Identifiable x, Identifiable y) {
        Boolean identical = x === y;
    }

## Description

### Definition 

The `===` operator is primitive.

### Polymorphism

The `===` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

### Type

The result type of the `===` operator is [`Boolean`](#{site.urls.apidoc_1_3}/Boolean.type.html).

### Meaning of *identical* for built-in types

TODO

## See also

* [`==` (equal)](../equal) operator
* API documentation for [`Identifiable`](#{site.urls.apidoc_1_3}/Identifiable.type.html)
* [identical in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
