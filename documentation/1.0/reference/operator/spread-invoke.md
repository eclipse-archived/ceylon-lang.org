---
layout: reference
title: '`[].` (spread method) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The *spread method* operator maps a sequence of instances through a 
method, resulting in a `Callable`.

## Usage 

    String[] names = {"foo", "bar", "baz"};
    String[] initials = names[].initial(1);

## Description

### Implementation

Spread method references, such as:

<!-- check:none -->
    Callable<String[], Integer> ref = names[].initial;
    
will be implemented in Milestone 3.

### Definition

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for 
more details.

### Polymorphism

The `[].` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

## See also

* [`[].` (spread attribute)](../spread attribute) operator, the equivalent of the 
  spread method operator but for attributes;
* [sequence operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

