---
layout: reference
title: '`^` (power) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `^` operator is used to compute its left-hand 
operand *raised to the power* of its right-hand operand.

## Usage 

    Integer eight = 2 ^ 3;

## Description

### Definition

The `^` operator is defined as follows:

<!-- check:none -->
    lhs.power(rhs);

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `^` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `^` depends on the 
[`Exponentiable`](#{page.doc_root}/api/ceylon/language/interface_Exponentiable.html) interface.

### Meaning of power for built-in types

For the built-in numeric types ([`Integer`](#{page.doc_root}/api/ceylon/language/class_Integer.html) and
[`Float`](#{page.doc_root}/api/ceylon/language/class_Float.html), `**` 
`**` performs normal mathematical exponentiation, subject to the limitations
of the relevant type.


## See also

* API documentation for [`Exponentiable`](#{page.doc_root}/api/ceylon/language/interface_Exponentiable.html)
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
