---
layout: reference12
title_md: '`let`'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A `let` expression allows the declaration of new values to be used in 
the following expression.

## Usage 

    String hw = let (x="hello", y="world") x + " " + y);

## Description

A `let` expression allows you to declare new values to be used in an 
expression without having to use statement-level declaration. 
the specification expression of each value can use all the previously defined 
values, like this:

    Integer result = let(x = 1, y = x+2, z=x*y) x^y;
    


### Type

The type of a `let` expression is the type of the expression part of the `let`.

## See also


