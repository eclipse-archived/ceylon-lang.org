---
layout: reference
title: '`-` (difference) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `-` operator is used to take the *difference* of 
two operands.

## Usage 

    Integer one = 3 - 2;

## Description

### Definition

The `-` operator is defined as 

<!-- check:none -->
    lhs.minus(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `-` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `-` depends on the 
[`Numeric`](#{site.urls.apidoc_current}/interface_Numeric.html) interface.

### Meaning of *difference* for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/class_Integer.html) and
[`Float`](#{site.urls.apidoc_current}/class_Float.html),
`-` performs normal mathematical subtraction, subject to the limitations
of the relevant type.

## See also

* API documentation for [`Numeric`](#{site.urls.apidoc_current}/interface_Numeric.html)
* [difference in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic)
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
* [~ (complement)](../complement) the set-wise minus operator

