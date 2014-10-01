---
layout: reference
title_md: '`extends` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Later
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary prefix `extends` operator is used to test whether its 
left-hand operand is *extends* its right-hand operand

## Usage 

<!-- check:none -->
<!-- try: -->
    void m(Type<Anything> x) {
        Boolean extension = x extends Class<Anything>;
    }

## Description

### Definition

The `extends` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.extendsType(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) for more details.

### Polymorphism

The `extends` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `extends` depends on the 
[`Class`](#{site.urls.apidoc_1_0}/metamodel/Class.type.html) class and 
[`Type`](#{site.urls.apidoc_1_0}/metamodel/Type.type.html) interface.

### Type

The result type of the `entends` operator is [`Boolean`](#{site.urls.apidoc_1_0}/Boolean.type.html).

## See also

* API documentation for [`Class`] _doc coming soon at_ (#{site.urls.apidoc_1_0}/metamodel/Class.type.html)
* API documentation for [`Type`](#{site.urls.apidoc_1_0}/metamodel/Type.type.html)
* [`extends` in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

