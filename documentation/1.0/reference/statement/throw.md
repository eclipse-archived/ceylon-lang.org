---
layout: reference
title: '`throw` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The `throw` statement is used to indicate that an exception to the normal 
flow of control has occurred.

## Usage 

A bare `throw` doesn't supply an exception instance:

<!-- cat: void m() { -->
    throw;
<!-- cat: } -->

Otherwise an exception instance may be specified; commonly a new instance is 
created at the point the `throw` statement is used:

<!-- cat: void m() { -->
    throw Exception();
<!-- cat: } -->

## Description

### Execution

The `throw` statement causes the enclosing method, attribute accessor or 
initializer to return *abnormally*, signifying an exceptional circumstance 
which prevents normal completion. Instead of returning to the caller, the
call stack is searched for the nearest [`try`](../try) statement 
with a matching `catch` clause, and execution resumes at the start of that
`catch` block (possibly after [resource cleanup] _doc coming soon_.

An expression may be supplied with the `throw` statement. If no expression is 
given a new messageless and causeless 
[`ceylon.language.Exception`](#{site.urls.apidoc_current}/ceylon/language/interface_Exception.html) instance is 
created automatically. If an expression is given is must be of a type which is
assignable to `ceylon.language.Exception`.

### Checked exceptions

Ceylon does not support 'checked' exceptions. Any kind of exception may be 
thrown without it having to be declared by a 
[`throws` annotation]  _doc coming soon at_ (../../ceylon.language/throws) in the relevant declaration. 
This includes Ceylon code throwing what in Java would 
be considered to be *checked exceptions* (such as `java.lang.Exception`). In 
other words the following is perfectly acceptable to the Ceylon compiler:

    import java.lang {CheckedException=Exception}
    
    void m() {
        throw CheckedException();
    }

### Advice

It is possible, though not recommended, to use `throw` to implement control 
logic.

## See also

* [`try` statement](../try)
* [`ceylon.language.Exception`](#{site.urls.apidoc_current}/ceylon/language/interface_Exception.html)
* [`throw` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#trycatchfinally)

