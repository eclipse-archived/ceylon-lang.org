---
layout: reference
title: `++` (increment) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, unary `++` operators increment their operand; they
differ in whether the result is assigned before or after the increment.

## Usage 

Postfix unary `++` operator has the operator after the operand:

<!-- cat: void m() { -->
    variable Integer num := 1;
    num++;
<!-- cat: } -->
    
Prefix unary `++` operator  puts the operator before the operand:

<!-- cat: void m() { -->
    variable Integer num := 1;
    ++num;
<!-- cat: } -->

## Description

Both operators increment their operand by one. The difference is that the 
prefix operator updates its operand and evaluates to the updated value. 
The postfix operator, in contrast, increments its operand but evaluates to the 
value of the operand *before* the increment.

### Definition

The prefix `++` is defined as:

<!-- check:none -->
    rhs:=rhs.successor
    
The postfix `++` is defined as:

<!-- check:none -->
    (++lhs).predecessor

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `++` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `++` depends on the 
[`Ordinal`](#{page.doc_root}/api/ceylon/language/interface_Ordinal.html) and
[`Settable`](#{page.doc_root}/api/ceylon/language/interface_Settable.html) interfaces.

## See also

* * [-- (decrement)](../decrement) operator
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
