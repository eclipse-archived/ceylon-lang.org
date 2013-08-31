---
layout: reference
title: '`else` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `else` operator is used to provide a default value
when it's left operand is `null`.

## Usage 

    void m(String? s) {
        String s2 = s else "";
    }

## Description

The `else` operator is defined as follows

<!-- check:none -->
    if (exists lhs) then lhs else rhs

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#conditionals) for more details.

The `then` operator is often used with the `else` operator to emulate
C's ternary operator ` cond ? when-true-expr : when-false-expr`, like so

    T|F result = cond then whenTrueExpr else whenFalseExpr;


## See also

* [`then` operator](../then)
