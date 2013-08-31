---
layout: reference
title: '`then` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The left-associative, binary `then` operator evaluates its right operand only 
when it's left operand is `true`, otherwise it evaluates as `null`.

## Usage 

    void m(String s) {
        String s2 = s.empty then "hello";
    }

## Description

The `then` operator is defined as follows

<!-- check:none -->
    if (lhs) then rhs else null

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#conditionals) for more details.

The `then` operator is often used with the `else` operator to emulate
C's ternary operator ` cond ? when-true-expr : when-false-expr`, like so

    T|F result = cond then whenTrueExpr else whenFalseExpr;


## See also

* [`else` operator](../else)
