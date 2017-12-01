---
layout: reference12
title_md: '`dynamic` blocks'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A `dynamic` block is a series of statements which are executed sequentially.
Expressions within a `dynamic` block may not have Ceylon type information.

## Usage 

    dynamic {
        alert("hello, world");
        value status = window.status;
    }

## Description

The purpose of a `dynamic` block is to allow interoperation with dynamically 
typed languages in a controlled way without letting untyped values "leak" 
out of the block and into (typed) Ceylon code. There are a number of 
rules for `dynamic` blocks which enforce this.

Expressions with static types are checked as normal within a `dynamic` 
block. However, expressions with no type:

* may be specified or assigned to a typed value
* may be passed as the argument of a typed parameter in an invocation expression
* may be the invoked expression of an invocation
* may be returned by a typed function or getter, or thrown as an exception
* may be the operand of an operator expression
* may be the subject of a control structure condition, a `switch`, or a `for` iterator

Furthermore:

* a qualified or unqualified reference may not refer to a statically typed 
 declaration
 
In these situations typechecking does not happen statically (at compile time), 
but dynamically (at runtime) and if that runtime type checking fails an 
` AssertionError` is thrown.


## See also

* [`dynamic` interfaces](../../structure/dynamic)
* [`dynamic` blocks](#{site.urls.spec_current}#dynamicblocks) in the 
  Ceylon language specification
