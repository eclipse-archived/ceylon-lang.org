---
layout: reference
title: '`=` (assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `=` operator is used to *assign* a value to a `variable`-annotated attribute

## Usage 

<!-- cat: void m() { -->
    variable Integer num = 1; // assign
    num = 2; //assign
    Integer three = 3 // specify
<!-- cat: } -->

## Description

### Specification

If an attribute (or a parameter default) is non-`variable` then it cannot be 
assigned. Instead it is [specified](../../statement/specification) using a 
statement;

### Definition

The `=` operator is primitive.

### Polymorphism

The `=` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

## See also

* [`variable`](#{site.urls.apidoc_current}/index.html#variable) annotation
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
