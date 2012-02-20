---
layout: reference
title: `[]` (lookup) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The *lookup* operator accesses a particular item in a `Correspondence`.

## Usage 

    Integer[] seq = {1, 2, 3};
    Integer? first = seq[0]; // The get case
    seq[0] := 5;             // The set case

## Description

The lookup operator is actually two operators, one for getting an item from a 
`Correspondence` according to its key and the other for setting an 
item with its key in an `OpenCorrespondence`.

### Implementation Note

<!-- M2 -->
Setting an item in an `OpenCorrespondence` may be implemented in Milestone 2,
or possibly Milestone 3.

### Definition

The `[]` operator is defined as follows (for both the get and set cases):

    lhs.item(index)

The difference between the get and set cases is in the types of the operands.

See the [language specification](#{site.urls.spec}#listmap) for 
more details.

### Polymorphism

The `[]` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `[]` depends on the 
[`Correspondence`](#{site.urls.apidoc}/ceylon/language/interface_Correspondence.html) 
interface for the get case and 
[`OpenCorrespondence`](#{site.urls.apidoc}/ceylon/language/interface_OpenCorrespondence.html)
for the set case.

## See also

* [`[]` (sequenced lookup)](../sequenced-lookup) operator used for accessesing several items using a sequence
* [`[]` (iterated lookup)](../iterated-lookup) operator used for accessesing several items using an iterable
* API documentation for [`Correspondence`](#{site.urls.apidoc}/ceylon/language/interface_Correspondence.html) 
* [`OpenCorrespondence`] _doc coming soon at_ (../../ceylon.language/OpenCorrespondence)
* [sequence operators](#{site.urls.spec}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

