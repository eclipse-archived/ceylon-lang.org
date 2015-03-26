---
layout: reference12
title_md: '`.` (member) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary infix `.` operator is used to  access the member 
named by the right-hand operand from left-hand operand.

## Usage 

<!-- try: -->
    String[] args = process.arguments;

## Description

Members include attributes, methods, classes and interfaces.

### Definition

The `.` operator is primitive.

### Polymorphism

The `.` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

### Type

The result type of the `.` operator is the type of its right hand operand.

## See also

* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
