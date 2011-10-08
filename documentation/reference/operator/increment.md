---
layout: reference
title: `++` (increment) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

There are two versions of the increment `++` operator. 

The left-associative, postfix unary `++` operator has the operator after the
operand:


    variable Natural num := 1;
    num++;
    
The right-associative prefix unary `++` operator  puts the operator before
the operand:


    variable Natural num := 1;
    ++num;

## Description

Both operators increment their operand by one. The difference is that the 
prefix operator updates its operand and evaluates to the updated value. 
The postfix operator, in contrast, increments its operand but evaluates to the 
value of the operand *before* the increment.

### Polymorphism

The `++` operator is [polymorphic](/documentation/reference/operator/operator-polymorphism). 
The meaning of `++` depends on the 
[`Ordinal`](../../ceylon.language/Ordinal) and
[`Settable`](../../ceylon.language/Settable) interfaces.

The prefix `++` is defined as:

    rhs:=rhs.successor
    
The postfix `++` is defined as:

    (++lhs).predecessor

See the [language specification](#{site.urls.spec}#arithmetic) for more details.

## See also

* * [-- (decrement)](../decrement) operator
* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
