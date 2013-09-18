---
layout: reference
title: '`throw` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `throw` statement is used to indicate that an exception to the normal 
flow of control has occurred.

## Usage 

A bare `throw` doesn't supply an exception instance:

<!-- cat: void m() { -->
<!-- try: -->
    throw;
<!-- cat: } -->

Otherwise an exception instance may be specified; commonly a new instance is 
created at the point the `throw` statement is used:

<!-- cat: void m() { -->
<!-- try: -->
    throw Exception();
<!-- cat: } -->

## Description

### Execution

The `throw` statement starts the propogation of an exception. The
call stack is searched for the nearest [`try`](../try) statement 
with a matching `catch` clause, and execution resumes at the start of that
`catch` block (possibly after [resource cleanup](../try).

A method, getter, setter or 
initializer, is said to *return abnormally* if an exception propgates beyond its scope. 
This signifies an exceptional circumstance which prevents normal completion of the 
method, getter, setter or initializer. 

An expression may be supplied with the `throw` statement. If no expression is 
given a new messageless and causeless 
[`ceylon.language.Exception`](#{site.urls.apidoc_current}/Exception.type.html) instance is 
created automatically. If an expression is given is must be of a type which is
assignable to `ceylon.language.Exception`.

### Notes

* Ceylon does not support 'checked' exceptions. Any kind of exception may be 
  thrown without it having to be declared by a 
  [`throws` annotation](TODO) in the relevant declaration. 
  This includes Ceylon code throwing what in Java would 
  be considered to be *checked exceptions* (such as `java.lang.Exception`). In 
  other words the following is perfectly acceptable to the Ceylon compiler:

<!-- try: -->
      import java.lang {CheckedException=Exception}
    
      void m() {
          throw CheckedException();
      }

### Advice

It is possible, though not recommended, to use `throw` to implement control 
logic.

## See also

* [`try` statement](../try)
* [`ceylon.language.Exception`](#{site.urls.apidoc_current}/Exception.type.html)
* The [`throws`](#{site.urls.apidoc_current}/TODO) annotation provides a way to document the 
  exceptions which may be thrown from a method, getter, setter or class initializer.
* [`throw` in the language specification](#{site.urls.spec_current}#trycatchfinally)

