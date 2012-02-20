---
layout: reference
title: `[x...]` (upper range) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The *upper range* operator returns the tail sequence of its left-hand operand
specified by its right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] secondAndThird = names[1...];
    String[] third = names[2...];
    String[] emptySequence = names[3...];

## Description

### Definition

The `[x...]` operator is defined as follows:

    range(lhs,x)

See the [language specification](#{site.urls.spec}#listmap) for 
more details.

### Polymorphism

The `[x...]` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [`[x..y]` (subrange)](../subrange) operator used for obtaining a subrange of a sequence
* [sequence operators](#{site.urls.spec}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

