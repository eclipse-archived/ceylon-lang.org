---
layout: reference
title: `===` (identical) operator
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `===` operator is used to test whether its operands 
are *identical*

## Usage 

    IdentifiableObject x;
    IdentifiableObject y;
    Boolean identical = x === y;

## Description

### Definition 

The `===` operator is defined as follows:

    lhs.identical(rhs);

See the [language specification](#{site.urls.spec}#equalitycomparison) for more details.

### Polymorphism

The `===` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `===` depends on the 
[`IdentifiableObject`](../../ceylon.language/IdentifiableObject) interface

### Meaning of *identical* for built-in types

TODO

## See also

* [`==` (equal)](../equal) operator
* [`IdentifiableObject`](../../ceylon.language/IdentifiableObject)
* [identical in the language specification](#{site.urls.spec}#equalitycomparison)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
