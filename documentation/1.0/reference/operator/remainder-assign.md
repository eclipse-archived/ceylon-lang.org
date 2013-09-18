---
layout: reference
title: '`%=` (remainder assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `%=` operator takes the remainder of it's 
left-hand operand with respect to its right-hand operand and updates 
the left-hand operand with the result.

## Usage 

<!-- cat: void m() { -->
    variable Integer num = 10;
    num %= 2; // half num 
<!-- cat: } -->

## Description


### Definition

The `%=` operator is defined as follows:

    lhs = lhs.remainder(rhs)

except that `lhs` is evaluated only once.

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `%=` operator is polymorphic. The definition of the `%=` operator depends 
on the [`Integral`](#{site.urls.apidoc_current}/Integral.type.html) 
interface.


## See also

* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
