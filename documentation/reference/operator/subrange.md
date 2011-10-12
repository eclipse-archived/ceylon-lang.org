---
layout: reference
title: `[x..y]` (subrange) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The *subrange* operator returns the subrange of its left-hand operand
indexed by its right-hand operand.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] firstAndSecond = names[0..1];
    String[] secondAndThird = names[1..2];

## Description

### Definition

The `[x..y]` operator is defined as follows:

    range(lhs,x,y)

See the [language specification](#{site.urls.spec}#listmap) for 
more details.

### Polymorphism

The `[x..y]` operator is not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [`[x...\]` (upper range)](../upper-range) operator used for obtaining a tail of a sequence
* [sequence operators](#{site.urls.spec}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

