---
layout: reference
title: '`**` (scale) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `**` operator is used to scale an instance of `Scalable` but an amount.

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

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#listmap) for more details.

### Polymorphism

The `**` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `**` depends on the 
[`Scalable`](#{site.urls.apidoc_current}/interface_Scalable.html) interface.

### Meaning of scale for built-in types

No types in the language module satisfy `Scalable`.

## See also

* API documentation for [`Scalable`](#{site.urls.apidoc_current}/interface_Scalable.html)
* [scalable operators](#{page.doc_root}/#{site.urls.spec_relative}#listmap) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon
