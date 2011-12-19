---
layout: reference
title: `%=` (remainder assign) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The right-associative, binary `%=` operator takes the remainder of it's 
left-hand operand with respect to its right-hand operand and updates 
the left-hand operand with the result.

## Usage 

    variable Integer num := 10;
    num %= 2; // half num 

## Description


### Definition

The `%=` operator is defined as follows:

    lhs:=lhs.remainder(rhs.castTo<N>())

except that `lhs` is evaluated only once.

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

### Polymorphism

The `%=` operator is polymorphic. The definition of the `%=` operator depends 
on the [`Integral`](#{site.urls.apidoc}/ceylon/language/interface_Integral.html) and 
[`Castable`](#{site.urls.apidoc}/ceylon/language/interface_Castable.html) and
[`Settable`] _doc coming soon at_ (../../ceylon.language/Settable) interfaces 

### Widening

Widening will be implemented in <!-- m2 -->

The types of the operands need not match because of the call to `castTo<N>()` 
in the definition of the operator. In other words assuming it's possible to 
widen the `rhs` so that it's the same type as the `lhs` then 
such a widening will automatically be performed. It is a compile time error if 
such a widening is not possible.

## See also

* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
