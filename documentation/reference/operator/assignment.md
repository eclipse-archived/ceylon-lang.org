---
layout: reference
title: `:=` (assignment) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `:=` operator is used to assign a value to a
`variable`-annotated attribute or local variable:

    variable Natural num := 1;
    num := 2;

## Description



### Polymorphism

The `:=` operator is not [polymorphic](/documentation/tour/language-module/#operator_polymorphism). 

## See also

* [`variable`](../../ceylon.language/variable) annotation
