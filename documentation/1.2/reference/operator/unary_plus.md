---
layout: reference12
title_md: '`+` (unary plus) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, unary prefix `+` operator is used to clarify the positive value 
of its operand.

## Usage 

<!-- try: -->
    Integer one = +1;

## Description

Note that `+` does not change the sign of a negative number:

<!-- try: -->
    Integer minusOne = +(-1);

### Definition 

The `+` operator is a no-op.

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Type

The result type of the `+` operator is the same as the `Invertible` type of its operand.

## See also

* [`-` (unary minus)](../unary_minus) which does change the sign of its operand
* API documentation for [`Invertible`](#{site.urls.apidoc_1_2}/Invertible.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon

