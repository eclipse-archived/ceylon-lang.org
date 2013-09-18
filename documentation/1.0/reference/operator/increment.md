---
layout: reference
title: '`++` (increment) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, unary `++` operators increment their operand; they
differ in whether the result is assigned before or after the increment.

## Usage 

Postfix unary `++` operator has the operator after the operand:

<!-- cat: void m() { -->
<!-- try: -->
    variable Integer num = 1;
    num++;
<!-- cat: } -->
    
Prefix unary `++` operator  puts the operator before the operand:

<!-- cat: void m() { -->
<!-- try: -->
    variable Integer num = 1;
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
<!-- try: -->
    rhs = rhs.successor
    
The postfix `++` is defined as:

<!-- check:none -->
<!-- try: -->
    (++lhs).predecessor

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `++` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `++` depends on the 
[`Ordinal`](#{site.urls.apidoc_current}/Ordinal.type.html).

## See also

* * [-- (decrement)](../decrement) operator
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
