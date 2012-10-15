---
layout: reference
title: '`:=` (assignment) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `:=` operator is used to assign a value to a
`variable`-annotated attribute or local variable.

## Usage 

<!-- cat: void m() { -->
    variable Integer num := 1;
    num := 2;
<!-- cat: } -->

## Description

You have to use `:=` if you want to assign a value to a `variable`, attempting
to use `=` will result in a compile error.

### Definition

The `:=` operator is primitive.

### Polymorphism

The `:=` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

## See also

* [`variable`] annotation _doc coming soon_ (../../ceylon.language/variable) 
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
