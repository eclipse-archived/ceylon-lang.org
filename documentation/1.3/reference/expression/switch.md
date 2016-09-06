---
layout: reference13
title_md: '`switch` expression'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A `switch` expression allows the expression to take any of a number of results
depending which `case` matches a value. It is the expression analog of 
a statement-level [`switch` control structure](../../statement/switch/).

## Usage 

    String formatted = switch (val) 
                        case (true) "yes" 
                        case (false) "no" 
                        case (is Float) formatFloat(val) 
                        else val.string;
    
## Description

When writing an expression it is often inconvenient to have 
to "hoist" some simple conditional logic 
into a number of statements using an `switch` control structure. 
Compare the example in the *Usage* above with the equivalent using 
a statement level `switch`:

    String formatted;
    switch(val)
    case (true) {
        formatted = "yes";
    }
    case (false) {
        formatted = "no";
    }
    case (is Float) {
        formatted = formatFloat(val);
    }
    else {
        formatted = val.string;
    }

`switch` expressions support type narrowing etc, just like the
`switch` statement. Likewise the `else` is required precisely when 
the `case`s are not exhaustive.

### Type

The type of a `switch` expression is the union type of the `case` expressions 
and the `else` expression, if any.

## See also

* [`switch` statements](../../statement/switch/)
* [`if` expressions](../if/)
