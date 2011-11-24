---
layout: reference
title: `in` (containment) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `in` operator is used to test whether its left-hand 
operand is *contained in* its right-hand operand

## Usage 

    Object x;
    Category y;
    Boolean contained = x in y;

## Description

### Definition
The `in` operator is defined as follows:

    lhs.contained(rhs);

See the [language specification](#{site.urls.spec}#equalitycomparison) for more details.

### Polymorphism

The `in` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `in` depends on the 
[`Category`](#{site.urls.apidoc}/ceylon/language/interface_Category.html) interface

## See also

* API documentation for [`Category`](#{site.urls.apidoc}/ceylon/language/interface_Category.html)
* [`in` in the language specification](#{site.urls.spec}#equalitycomparison)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

