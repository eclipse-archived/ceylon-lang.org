---
layout: reference11
title_md: '`x[...z]` (lower span) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *lower span* operator returns the elements of its left-hand `Ranged` 
operand upto and including the element whose key is specified by its 
right-hand operand.

## Usage 

<!-- try: -->
    String[] names = {"foo", "bar", "baz"};
    String[] foo = names[...0];
    String[] foobar = names[...1];
    String[] emptySequence = names[...-1];

## Description

### Definition

The `lhs[...rhs]` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.spanTo(rhs)

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `x[...z]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `x[...z]` depends on the 
[`Ranged`](#{site.urls.apidoc_1_1}/Ranged.type.html) 
interface.

### Type

The result type of the `lhs[..to]` operator is the element type of the `Ranged` `lhs`.

## See also

* [`x[y..z]` (span)](../span) operator used for obtaining a span of a `Ranged`.
* [`x[y...]` (upper span)](../upper-span) operator used for obtaining a span of a `Ranged`.
* API documentation for [`Ranged`](#{site.urls.apidoc_1_1}/Ranged.type.html)
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

