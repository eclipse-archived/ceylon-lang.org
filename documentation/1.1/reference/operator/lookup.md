---
layout: reference11
title_md: '`[]` (lookup) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *lookup* operator accesses a particular item in a `Correspondence`.

## Usage 

<!-- try: -->
    void m(Integer[] seq) {
        Integer? first = seq[0];
    }

Note that first is `Integer?` rather than `Integer` because of the 
possibility that seq doesn't have a value for the given key.

## Description

The lookup operator gets an item from a 
`Correspondence` according to its key.

### Definition

The `[]` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.get(index)

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `[]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `[]` depends on the 
[`Correspondence`](#{site.urls.apidoc_1_1}/Correspondence.type.html) 
interface.

### Type

The result type of the `lhs[index]` operator is the element type of the `Correspondence` `lhs`.

## See also

* API documentation for [`Correspondence`](#{site.urls.apidoc_1_1}/Correspondence.type.html) 
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

