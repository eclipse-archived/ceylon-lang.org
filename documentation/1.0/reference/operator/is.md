---
layout: reference
title: '`is` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `is` operator is used to test the type of a 
variable.

## Usage 

    void m(Object? obj) {
        Boolean isNumber = obj is Number;
        Boolean isNothing = obj is Nothing;
    }

## Description

### Definition

The `is` operator is primitive.

### Polymorphism

The `is` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

## See also

* [`extends` operator](../extends)
* [`satisfies` operator](../satisfies)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
