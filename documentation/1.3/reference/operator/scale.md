---
layout: reference13
title_md: '`**` (scale) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, binary infix `**` operator is used to scale an instance of `Scalable` by an amount.

## Usage 

<!-- try: -->
<!-- check:none -->
    value four_plus_6i = 2 ** Complex(2, 3);

## Description

### Definition

The `**` operator is defined as follows:

<!-- try: -->
<!-- check:none -->
    rhs.scale(lhs);

Note that the `lhs` is evaluated before the `rhs`

See the [language specification](#{site.urls.spec_current}#listmap) for more details.

### Polymorphism

The `**` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `**` depends on the 
[`Scalable`](#{site.urls.apidoc_1_3}/Scalable.type.html) interface.

### Type

The result type of the `**` operator is the type of its right hand operand.

### Meaning of scale for built-in types

No types in the language module satisfy `Scalable`.

## See also

* API documentation for [`Scalable`](#{site.urls.apidoc_1_3}/Scalable.type.html)
* [scalable operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
