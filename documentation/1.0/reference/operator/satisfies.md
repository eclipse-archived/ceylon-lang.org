---
layout: reference
title: '`satisfies` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Later
doc_root: ../../..
---

# #{page.title}

The non-associating, binary prefix `satisfies` operator is used to test whether its 
left-hand  operand is *satisfies* its right-hand operand.

## Usage 

<!-- check:none -->
<!-- try: -->
    void m(Type<Anything> x) {
        Boolean satisfaction = satisfies String Iterator;
    }

## Description

### Definition

The `satisfies` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.satisfiesType(rhs);

See the [language specification](#{site.urls.spec_current}#equalitycomparison) 
for more details.

### Polymorphism

TODO The `satisfies` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `satisfies` depends on the 
[`Type`](#{site.urls.apidoc_current}/metamodel/Type.type.html) interface.

### Type

The result type of the `satisfies` operator is [`Boolean`](#{site.urls.apidoc_current}/Boolean.type.html).

## See also

* API documentation for [`Type`](#{site.urls.apidoc_current}/metamodel/Type.type.html)
* [`is` in the language specification](#{site.urls.spec_current}#equalitycomparison)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

