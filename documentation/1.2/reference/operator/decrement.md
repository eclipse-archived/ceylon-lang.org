---
layout: reference12
title_md: '`--` (decrement) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, unary `--` operators decrement their operand; they
differ in whether the result is assigned before or after the decrement.

## Usage 

Postfix `--` has the operator after the operand:

<!-- cat: void m() { -->
<!-- try: -->
    variable Integer num = 1;
    num--;
<!-- cat: } -->
    
Prefix `--` puts the operator before the operand:

<!-- cat: void m() { -->
<!-- try: -->
    variable Integer num = 1;
    --num;
<!-- cat: } -->

## Description

Both operators decrement their operand by one. The difference is that the 
prefix operator updates its operand and evaluates to the updated value. 
The postfix operator, in contrast, decrements its operand but evaluates to the 
value of the operand *before* the decrement.

### Definition

The prefix `--` is defined as:

<!-- check:none -->
<!-- try: -->
    rhs = rhs.predecessor
    
The postfix `--` is defined as:

<!-- check:none -->
<!-- try: -->
    (--lhs).successor

See the [language specification](#{site.urls.spec_current}#arithmetic) for more details.

### Polymorphism

The `--` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `--` depends on the 
[`Ordinal`](#{site.urls.apidoc_1_1}/Ordinal.type.html) interface.

### Type

The result type of the `--` operator is the same as the `Ordinal` type of its operand.

## See also

* [++ (increment)](../increment) operator
* [arithmetic operators](#{site.urls.spec_current}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
