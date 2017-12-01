---
layout: reference13
title_md: '`if` expression'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An `if` expression allows the expression to take either one result or 
another result depending on a condition. It is the expression analog of 
a statement-level [`if`/`else` control structure](../../statement/if/).

## Usage 

    String greeting = if (exists name) then "hello " + name else "hello world";
    
## Description

When writing an expression it is often inconvenient to have 
to "hoist" some simple conditional logic 
into a number of statements using an `if`/`else` control structure. 
For example, compare using the expression form in an invocation:

    print(if (exists name) then "hello " + name else "hello world");

with code which codes the same thing using the statement form:

    String greeting;
    if (exists name) {
        greeting = "hello " + name;
    } else {
        greeting = "hello world";
    }
    print(greeting);
    
### Flow typing

`if` expressions support condition lists, type narrowing etc, just like the
`if`/`else` control structure.

### Type

The type of an `if` expression is the union type of the `then` expression 
and the `else` expression. 

### Compared to `then` and `else` operators

It is worth pointing out that as well as the `if` expression Ceylon 
also has distinct [`then`](../../operator/then/) 
and [`else`](../../operator/else/) *operators*.

When used together in the `then`/`else` idiom 
the effect is similar to a simple `if` expression, but 
while `then`/`else` is adequate for a simple conditional

    print(hello then "hello world" else "goodbye world");
    
it's not powerful enough to be an alternative to the `if` expression
when the branches require flow typing of `is`, `exists` or `nonempty` 
conditions to the branches

    print(if (exists name) then "hello " + name else "hello world");

## See also

* [`if` statements](../../statement/if/)
* [`switch` expressions](../switch/)
* [`then`](../../operator/then/) operator
* [`else`](../../operator/else/) operator

