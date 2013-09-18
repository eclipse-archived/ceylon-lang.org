---
layout: reference
title: '`===` (identical) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `===` operator is used to test whether its operands 
are *identical*

## Usage 

    void m(Identifiable x, Identifiable y) {
        Boolean identical = x === y;
    }

## Description

### Definition 

The `===` operator is defined as follows:

<!-- check:none -->
    lhs.identical(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `===` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `===` depends on the 
[`Identifiable`](#{site.urls.apidoc_current}/Identifiable.type.html) interface

### Meaning of *identical* for built-in types

TODO

## See also

* [`==` (equal)](../equal) operator
* API documentation for [`Identifiable`](#{site.urls.apidoc_current}/Identifiable.type.html)
* [identical in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
