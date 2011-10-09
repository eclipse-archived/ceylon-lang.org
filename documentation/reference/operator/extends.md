---
layout: reference
title: `extends` operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The non-associating, binary `extends` operator is used to test whether its left hand 
operand is *extends* its right hand operand

    Type<Void> x;
    Class<Void> y;
    Boolean extension = x extends y;

## Description

### Polymorphism

The `extends` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `extends` depends on the 
[`Class`](../../ceylon.language/Class) class and 
[`Type`](../../ceylon.language/Type) interface as follows:

    lhs.extendsType(rhs);

See the [language specification](#{site.urls.spec}#equalityandcomparisonoperators) for more details.

## See also

* [`Class`](../../ceylon.language/Class)
* [`Type`](../../ceylon.language/Type)
* [`extends` in the language specification](#{site.urls.spec}#equalityandcomparisonoperators)
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

