---
layout: reference
title: `satisfies` operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `satisfies` operator is used to test whether its 
left-hand  operand is *satisfies* its right-hand operand.

## Usage 

    Type<Void> x;
    Type<Void> y;
    Boolean satisfaction = x satisfies y;

## Description

### Definition

The `satisfies` operator is defined as follows:

    lhs.satisfiesType(rhs);

See the [language specification](#{site.urls.spec}#equalitycomparison) 
for more details.

### Polymorphism

TODO The `satisfies` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `satisfies` depends on the 
[`Type`](../../ceylon.language/Type) interface.

## See also

* [`Type`](../../ceylon.language/Type)
* [`is` in the language specification](#{site.urls.spec}#equalitycomparison)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

