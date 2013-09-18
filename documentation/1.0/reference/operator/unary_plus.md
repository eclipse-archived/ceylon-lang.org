---
layout: reference
title: '`+` (unary plus) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, unary `+` operator is used to clarify the positive value 
of its operand.

## Usage 

<!-- try: -->
    Integer one = +1;

## Description

Note that `+` does not change the sign of a negative number:

<!-- try: -->
    Integer minusOne = +(-1);

### Definition 

The `+` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    rhs.positiveValue;

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The unary `+` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `+` depends on 
[`Invertable`](#{site.urls.apidoc_current}/Invertable.type.html) interface 

### Meaning of unary plus for built-in types

For the built-in numeric types
[`Integer`](#{site.urls.apidoc_current}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_current}/Float.type.html), `+` 
is essentially a no-op.

## See also

* [`-` (unary minus)](../unary_minus) which does change the sign of its operand
* API documentation for [`Invertable`](#{site.urls.apidoc_current}/Invertable.type.html)
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon

