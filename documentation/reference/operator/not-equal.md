---
layout: reference
title: `!=` (not equal) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `!=` operator is used to test whether its operands 
are *not equal*:

    Equality<T> x;
    T y;
    Boolean identical = x != y;

## Description

### Polymorphism

The `!=` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `!=` depends on the 
[`Equality`](../../ceylon.language/Equality) interface as follows:

    !lhs.equals(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`==` (equal)](../equal) operator
* [`Equality`](../../ceylon.language/Equality)
* [equality in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

