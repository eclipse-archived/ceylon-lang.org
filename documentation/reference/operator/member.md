---
layout: reference
title: `.` (member) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The left-associative, binary `.` operator is used to  access the member 
named by the right-hand operand from left-hand operand.

## Usage 

    process.args;

## Description

Members include attributes, methods, classes and interfaces.

### Definition

The `.` operator is primitive.

### Polymorphism

The `.` operator is not [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 

## See also

* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
