---
layout: reference11
title_md: '`-` (difference) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary infix `-` operator is used to take the *difference* of 
two operands.

## Usage 

<!-- try: -->
    Integer one = 3 - 2;

## Description

### Definition

The `-` operator is defined as 

<!-- check:none -->
<!-- try: -->
    lhs.minus(rhs);

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `-` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `-` depends on the 
[`Numeric`](#{site.urls.apidoc_1_1}/Numeric.type.html) interface.

### Type

The result type of the `-` operator is the same as the type of its right hand operand.

### Meaning of *difference* for built-in types

For the built-in numeric types [`Integer`](#{site.urls.apidoc_1_1}/Integer.type.html) and
[`Float`](#{site.urls.apidoc_1_1}/Float.type.html),
`-` performs normal mathematical subtraction, subject to the limitations
of the relevant type.

## See also

* API documentation for [`Numeric`](#{site.urls.apidoc_1_1}/Numeric.type.html)
* [difference in the language specification](#{site.urls.spec_current}#arithmetic)
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
* [~ (complement)](../complement) the set-wise minus operator

