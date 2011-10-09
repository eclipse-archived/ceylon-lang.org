---
layout: reference
title: `===` (identical) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `===` operator is used to test whether its operands 
are *identical*:

    IdentifiableObject x;
    IdentifiableObject y;
    Boolean identical = x === y;

## Description

### Polymorphism

The `===` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `===` depends on the 
[`IdentifiableObject`](../../ceylon.language/IdentifiableObject) interface as follows:

    lhs.identical(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

### Meaning of *identical* for built-in types

TODO

## See also

* [`==` (equal)](../equal) operator
* [`IdentifiableObject`](../../ceylon.language/IdentifiableObject)
* [identical in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
