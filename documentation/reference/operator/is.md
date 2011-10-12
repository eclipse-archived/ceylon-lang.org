---
layout: reference
title: `is` operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `is` operator is used to test the type of a 
variable.

## Usage 

    Object? obj;
    Boolean isNumber = obj is Number;
    Boolean isNothing = obj is Nothing;

## Description

### Definition

The `is` operator is primitive.

### Polymorphism

The `is` operator is not [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 

## See also

* [`extends` operator](../extends)
* [`satisfies` operator](../satisfies)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
