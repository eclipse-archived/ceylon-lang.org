---
layout: reference12
title_md: '`*.` (spread attribute) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *spread attribute* operator maps an iterable of instances through an 
attribute, resulting in a sequence of the attribute values.

## Usage 

<!-- try: -->
    {String+} names = {"foo", "bar", "baz"};
    {Integer+} sizes = names*.size;

## Description

### Definition

The `*.` operator is defined by the comprehension:

<!-- check:none -->
<!-- try: -->
    [ for (X x in lhs) x.member ]

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `*.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `lhs*.rhs` operator is the sequential type of the 
type of the right hand operand.

## See also

* [`*.` (spread invoke)](../spread-invoke) operator, the equivalent of the 
  spread attribute operator but for methods;
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

