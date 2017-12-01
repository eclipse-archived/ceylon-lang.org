---
layout: reference12
title_md: '`x[y:n]` (measure) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *measure* operator returns the subrange of its left-hand operand
starting from its central operand and including as many elements as given by 
its right-hand operand.

## Usage 

<!-- try: -->
    String[] names = {"foo", "bar", "baz"};
    String[] foo = names[0:1];
    String[] barBaz = names[1:2];
    String[] empty = names[1:0];

## Description

### Definition

The `lhs[from:length]` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    lhs.measure(from,length)

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `x[y:n]` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `x[y:n]` depends on the 
[`Ranged`](#{site.urls.apidoc_1_2}/Ranged.type.html) 
interface.

### Type

The result type of the `lhs[from:length]` operator is the element type of the `Ranged` `lhs`.

## See also

* [`x[y..z]` (span)](../span) operator used for obtaining a subrange from a `Ranged`.
* API documentation for [`Ranged`](#{site.urls.apidoc_1_2}/Ranged.type.html)
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

