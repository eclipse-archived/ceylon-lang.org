---
layout: reference
title: `satisfies` operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `satisfies` operator is used to test whether its 
left hand  operand is *satisfies* its right hand operand

    Type<Void> x;
    Type<Void> y;
    Boolean satisfaction = x satisfies y;

## Description

### Polymorphism

The `satisfies` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `satisfies` depends on the 
[`Type`](../../ceylon.language/Type) interface as follows:

    lhs.satisfiesType(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) 
for more details.

## See also

* [`Type`](../../ceylon.language/Type)
* [in in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

