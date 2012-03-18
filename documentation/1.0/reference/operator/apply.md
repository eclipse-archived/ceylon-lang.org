---
layout: reference
title: `.=` follow/apply
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `.=` operator is used to access the member 
named by the right-hand operand from left-hand operand and assign the result to 
the left-hand operand.

## Usage 

The *follow* version is used for accessing attributes:

<!-- check:none -->
    X x;
    Attribute<X> y;
    x .= y; 
    // x now has the value of x.y

The *apply* version is used for invoking methods:

<!-- check:none -->
    X x;
    Method <X,X,String, Number> m;
    x .= m("hello", 5); 
    // x now has the value of x.m("hello", 5)

## Description

### Definition

The *follow* operator is defined as:

<!-- check:none -->
    lhs:=lhs.member

The *apply* operator is defined as:

<!-- check:none -->
    lhs:=lhs.member(x,y,z)

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#basic) for more details.

### Polymorphism 

The *follow* and *apply* operators are not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* API documentation for [`Attribute`] _doc coming soon at_ (#{page.doc_root}/api/ceylon/language/metamodel/Attribute)
* API documentation for [`Method`] _doc coming soon at_ (#{page.doc_root}/api/ceylon/language/metamodel/Method)
* [`.=` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#basic)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

