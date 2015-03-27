---
layout: reference12
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
Compare the example in the *Usage* above with the equivalent using 
a statement level `if`:

    String greeting;
    if (exists name) {
        greeting = "hello " + name;
    } else {
        greeting = "hello world";
    }

`if` expressions support condition lists, type narrowing etc, just like the
`if`/`else` control structure.

### Type

The type of an `if` expression is the union type of the `then` expression 
and the `else` expression.

## See also

* [`if` statements](../../statement/if/)
* [`switch` expressions](../switch/)
