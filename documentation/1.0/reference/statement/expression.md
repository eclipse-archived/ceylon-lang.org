---
layout: reference
title: 'Expression statements'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

An expression statement just treats an [expression](../../expression/) as a statement. 

## Usage 

An expression statement is just the expression followed by a semicolon (`;`).

<!-- try: -->
    foo();

## Description

No all expressions can be treated as statements in this way, for example

    "";
    
is not allowed. This is because there are no side-effects from evaluating the 
String literal and then discarding it, so the statement is pointless. 
Only the following expressions may be used as statements:

* [assignment](../../operator/assign/),
* prefix or postfix increment or decrement,
* invocation of a method,
* instantiation of a class.

On execution, the expression's result is discarded.

## See also

* The reference on [expressions](../../expression/)
