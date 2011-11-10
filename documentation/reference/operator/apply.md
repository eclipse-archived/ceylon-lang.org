---
layout: reference
title: `.=` follow/apply
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, binary `.=` operator is used to access the member 
named by the right-hand operand from left-hand operand and assign the result to 
the left-hand operand.

## Usage 

The *follow* version is used for accessing attributes:

    X x;
    Attribute<X> y;
    x .= y; 
    // x now has the value of x.y

The *apply* version is used for invoking methods:

    X x;
    Method <X,X,String, Number> m;
    x .= m("hello", 5); 
    // x now has the value of x.m("hello", 5)

## Description

### Definition

The *follow* operator is defined as:

    lhs:=lhs.member

The *apply* operator is defined as:

    lhs:=lhs.member(x,y,z)

See the [language specification](#{site.urls.spec}#basic) for more details.

### Polymorphism 

The *follow* and *apply* operators are not [polymorphic](/documentation/reference/operator/operator-polymorphism). 

## See also

* [`Attribute`] _doc coming soon at_ (../../ceylon.language/Attribute)
* [`Method`] _doc coming soon at_ (../../ceylon.language/Method)
* [`.=` in the language specification](#{site.urls.spec}#basic)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

