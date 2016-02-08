---
layout: reference12
title_md: '`else` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary `else` operator is used to provide a default value
when it's left operand is `null`.

## Usage 

<!-- try: -->
    void m(String? s) {
        String s2 = s else "";
    }

## Description

### Definition

The `else` operator is defined in terms of an [`if` expression](../../expression/if/) as follows

<!-- check:none -->
<!-- try: -->
    if (exists lhs) then lhs else rhs

See the [language specification](#{site.urls.spec_current}#conditionals) for more details.

### The `then`/`else` idiom

The `then` operator is often used with the `else` operator to emulate
C's ternary operator ` cond ? when-true-expr : when-false-expr`, like so

    T|F result = cond then whenTrueExpr else whenFalseExpr;

### Compared to `if` expressions

Distinct from the `then`/`else` idiom Ceylon has a separate `if` *expression*:

    if (cond) then whenTrueExpr else whenFalseExpr;
    
The `if` expression is more powerful than the `then`/`else` idiom, since it 
supports flow typing of `is`, `exists` or `nonempty` conditions to the branches


### Type

The result type of the `else` operator is given by the type expression `Lhs&Object|Rhs`, where
`Lhs` is the type of the left hand operand and 
`Rhs` is the type of the left hand operand.


## See also

* [`then` operator](../then/)
* [`if` expression](../../expression/if/)

