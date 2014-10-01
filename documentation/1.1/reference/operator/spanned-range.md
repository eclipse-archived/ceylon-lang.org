---
layout: reference11
title_md: '`..` (spanned range) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *spanned range* operator creates a `Range` from its endpoints.

## Usage 

<!-- try: -->
    Range<Integer> ten = 1..10;

## Description


### Definition

The `..` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    Range(lhs, rhs)

See the [language specification](#{site.urls.spec_current}#constructors) for 
more details.

### Polymorphism

The `..` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `..` depends on the 
[`Range`](#{site.urls.apidoc_1_1}/Range.type.html) 
class.

### Type

The result type of the `lhs..rhs` operator is `Range<Lhs>` where `Lhs` is the type of `lhs`.

## See also

* [`:` (segmented range)](../segmented-range)
* [object creation operators](#{site.urls.spec_current}#constructors) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

