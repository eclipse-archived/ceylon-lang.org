---
layout: reference
title: `.` (member) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `.` operator is used to  access the member 
named by the right-hand operand from left-hand operand.

## Usage 

    String[] args = process.args;

## Description

Members include attributes, methods, classes and interfaces.

### Definition

The `.` operator is primitive.

### Polymorphism

The `.` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

## See also

* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
