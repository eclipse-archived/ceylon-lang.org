---
layout: reference
title: '`*.` (spread method) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The *spread method* operator maps an iterable of instances through a 
method, resulting in a new iterable containing the return values of
each method invocation.

## Usage 

    {String+} names = {"foo", "bar", "baz"};
    {String+} initials = names*.initial(1);

## Description

### Implementation

You can also spread method references:

<!-- check:none -->
    Callable<String[], [Integer]> ref = names*.initial;
    
### Definition

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `*.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`*.` (spread attribute)](../spread-attribute) operator, the equivalent of the 
  spread method operator but for attributes;
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

