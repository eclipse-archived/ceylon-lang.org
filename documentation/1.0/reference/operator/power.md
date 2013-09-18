---
layout: reference
title: '`^` (power) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
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

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `^` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `^` depends on the 
[`Exponentiable`](#{site.urls.apidoc_current}/Exponentiable.type.html) interface.

### Meaning of power for built-in types

For the built-in numeric types ([`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_current}/Float.type.html), `**` 
`**` performs normal mathematical exponentiation, subject to the limitations
of the relevant type.


## See also

* API documentation for [`Exponentiable`](#{site.urls.apidoc_current}/Exponentiable.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
