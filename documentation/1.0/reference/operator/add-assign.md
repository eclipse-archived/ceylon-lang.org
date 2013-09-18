---
layout: reference
title: '`+=` (add assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `+=` operator increments it's left-hand operand 
by the amount given by its right-hand operand. 

## Usage 

<!-- cat: void m() { -->
    variable Integer num = 1;
    num += 1; // increment num by 1
    num += num; // increment num by 2
<!-- cat: } -->

## Description


### Definition

The operator is defined as: 

<!-- cat: void m<N>(N lhs1, N rhs) given N satisfies Summable<N> { variable Summable<N> lhs = lhs1; -->
    lhs = lhs.plus(rhs)
<!-- cat: ;} -->

except that `lhs` is evaluated only once.

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `+=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

The definition of the `+=` operator depends 
on the [`Summable`](#{site.urls.apidoc_current}/interface_Summable.html)
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
