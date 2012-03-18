---
layout: reference
title: `extends` operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Later
doc_root: ../../..
---

# #{page.title}

The non-associating, binary `extends` operator is used to test whether its 
left-hand operand is *extends* its right-hand operand

## Usage 

<!-- check:none -->
    void m(Type<Void> x) {
        Boolean extension = x extends Class<Void>;
    }

## Description

### Definition

The `extends` operator is defined as follows:

<!-- check:none -->
    lhs.extendsType(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison) for more details.

### Polymorphism

The `extends` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `extends` depends on the 
[`Class`](#{page.doc_root}/api/ceylon/language/metamodel/interface_Class.html) class and 
[`Type`](#{page.doc_root}/api/ceylon/language/metamodel/interface_Type.html) interface.

## See also

* API documentation for [`Class`] _doc coming soon at_ (#{page.doc_root}/api/ceylon/language/metamodel/interface_Class.html)
* API documentation for [`Type`](#{page.doc_root}/api/ceylon/language/metamodel/interface_Type.html)
* [`extends` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#equalitycomparison)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

