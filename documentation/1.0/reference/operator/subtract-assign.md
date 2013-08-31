---
layout: reference
title: '`-=` (subtract assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `-=` operator decrements it's left-hand operand 
by the amount given by its right-hand operand. 

## Usage 

<!-- cat: void m() { -->
    variable Integer num = 4;
    num -= 1; // decrement num by 1
    num -= num; // decrement num by 3
<!-- cat: } -->

## Description


### Definition 

The `-=` operator is defined as follows:

    lhs = lhs.minus(rhs)

except that `lhs` is evaluated only once.

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `-=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).
The definition of the `-=` operator depends 
on the [`Numeric`](#{site.urls.apidoc_current}/interface_Numeric.html) interface.

## See also

* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
