---
layout: reference12
title_md: '`%=` (remainder assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The right-associative, binary infix `%=` operator takes the remainder of it's 
left-hand operand with respect to its right-hand operand and updates 
the left-hand operand with the result.

## Usage 

<!-- cat: void m() { -->
<!-- try: -->
    variable Integer num = 10;
    num %= 2; // half num 
<!-- cat: } -->

## Description


### Definition

The `%=` operator is defined as follows:

<!-- try: -->
    lhs = lhs.remainder(rhs)

except that `lhs` is evaluated only once.

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `%=` operator is polymorphic. The definition of the `%=` operator depends 
on the [`Integral`](#{site.urls.apidoc_1_2}/Integral.type.html) 
interface.

### Type

The result type of the `%=` operator is the same as the type of its right hand operand.

## See also

* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
