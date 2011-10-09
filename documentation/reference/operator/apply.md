---
layout: reference
title: `.=` follow/apply
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `.=` operator is used to access the member 
named by the right hand operand from left-hand operand and assign the result to 
the left hand operand.

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

### Polymorphism

The *follow* and *apply* operators are [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of *follow* depends on the 
[`Attribute`](../../ceylon.language/Attribute) interface as follows:

    lhs:=lhs.member

The *apply* operator depends on [`Method`](../../ceylon.language/Method)

    lhs:=lhs.member(x,y,z)

See the [language specification](#{site.urls.spec}#basic) for more details.

## See also

* [`Attribute`](../../ceylon.language/Attribute)
* [`Method`](../../ceylon.language/Method)
* [`.=` in the language specification](#{site.urls.spec}#basic)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

