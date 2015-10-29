---
layout: reference12
title_md: 'Expression statements'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

An expression statement simply evaluates an [expression](../../expression/). 

## Usage 

An expression statement is just the expression followed by a semicolon (`;`).

<!-- try: -->
    foo();

## Description

No all expressions can be treated as statements in this way. For example:

<!-- try: -->
    "";

is not a legal expression statement. Since no side-effects result from 
evaluating a `String` literal and then discarding it, the statement is 
useless. Only the following expressions may be used as statements:

* [assignment](../../operator/assign/) or compound assignment,
* prefix or postfix [increment](../../operator/increment) or [decrement](../../operator/decrement),
* invocation of a method, or
* instantiation of a class.

On execution, the expression's value is discarded.

## See also

* The reference on [expressions](../../expression/)
* [Expression statements](#{site.urls.spec_current}#expressionstatements) 
  in the Ceylon language specification

