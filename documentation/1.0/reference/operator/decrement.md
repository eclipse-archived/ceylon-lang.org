---
layout: reference
title: `--` (decrement) operator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The left-associative, unary `--` operators decrement their operand; they
differ in whether the result is assigned before or after the decrement.

## Usage 

Postfix `--` has the operator after the operand:


    variable Integer num := 1;
    num--;
    
Prefix `--` puts the operator before the operand:

    variable Integer num := 1;
    --num;

## Description

Both operators decrement their operand by one. The difference is that the 
prefix operator updates its operand and evaluates to the updated value. 
The postfix operator, in contrast, decrements its operand but evaluates to the 
value of the operand *before* the decrement.

### Definition

The prefix `--` is defined as:

    rhs:=rhs.predecessor
    
The postfix `--` is defined as:

    (--lhs).successor

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `--` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `--` depends on the 
[`Ordinal`](#{page.doc_root}/api/ceylon/language/interface_Ordinal.html) and
[`Settable`](#{page.doc_root}/api/ceylon/language/interface_Settable.html) interfaces.

## See also

* [++ (increment)](../increment) operator
* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
