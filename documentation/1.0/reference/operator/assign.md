---
layout: reference
title_md: '`=` (assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, binary infix `=` operator is used to *assign* a value to a `variable`-annotated attribute

## Usage 

<!-- cat: void m() { -->
<!-- try: -->
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

### Type

The result type of the `=` operator is the type of the right hand operand.

## See also

* [`variable`](#{site.urls.apidoc_1_0}/index.html#variable) annotation
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
