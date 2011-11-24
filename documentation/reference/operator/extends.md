---
layout: reference
title: `extends` operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The non-associating, binary `extends` operator is used to test whether its 
left-hand operand is *extends* its right-hand operand

## Usage 

    Type<Void> x;
    Class<Void> y;
    Boolean extension = x extends y;

## Description

### Definition

The `extends` operator is defined as follows:

    lhs.extendsType(rhs);

See the [language specification](#{site.urls.spec}#equalitycomparison) for more details.

### Polymorphism

The `extends` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `extends` depends on the 
[`Class`](#{site.urls.apidoc}/ceylon/language/metamodel/class_Class.html) class and 
[`Type`](#{site.urls.apidoc}/ceylon/language/metamodel/class_Type.html) interface.

## See also

* API documentation for [`Class`] _doc coming soon at_ (#{site.urls.apidoc}/ceylon/language/metamodel/Class)
* API documentation for [`Type`](#{site.urls.apidoc}/ceylon/language/metamodel/Type)
* [`extends` in the language specification](#{site.urls.spec}#equalitycomparison)
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

