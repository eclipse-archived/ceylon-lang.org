---
layout: reference
title: `+=` (add assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The right-associative, binary `+=` operator increments it's left-hand operand 
by the amount given by its right-hand operand. 

## Usage 

<!-- cat: void m() { -->
    variable Integer num := 1;
    num += 1; // increment num by 1
    num += num; // increment num by 2
<!-- cat: } -->

## Description


### Definition

The operator is defined as: 

<!-- cat: void m<N>(Summable<N> lhs1, Castable<N> rhs) given N satisfies Summable<N> { variable Summable<N> lhs := lhs1; -->
    lhs:=lhs.plus(rhs.castTo<N>())
<!-- cat: ;} -->

except that `lhs` is evaluated only once.

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `+=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism).

The definition of the `+=` operator depends 
on the [`Summable`](#{page.doc_root}/api/ceylon/language/interface_Summable.html),
[`Castable`](#{page.doc_root}/api/ceylon/language/interface_Castable.html) and
[`Settable`](#{page.doc_root}/api/ceylon/language/interface_Settable.html) interfaces 

### Widening

Widening will be implemented in <!-- m2 -->

The types of the operands need not match because of the call to `castTo<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen the `rhs` so that it's the same type as the `lhs` then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
