---
layout: reference
title_md: '`throw` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `throw` statement is used to raise an exception

## Usage 

A bare `throw` doesn't need to supply an exception instance:

<!-- cat: void m() { -->
<!-- try: -->
    throw;
<!-- cat: } -->

An exception instance may be explicitly specified. Usually, a new 
exception is instantiated:

<!-- cat: void m() { -->
<!-- try: -->
    throw Exception();
<!-- cat: } -->

## Description

### Execution

The `throw` statement initiates the propogation of an exception, unwinding
the call stack. The call stack is searched for the nearest [`try`](../try) 
statement with a matching `catch` clause, and execution resumes at the start 
of that `catch` block (possibly after [resource cleanup](../try).

A method, getter, setter, or initializer, is said to *return abnormally* if 
an exception propgates beyond its scope. This signifies an exceptional 
circumstance which prevents normal completion of the method, getter, setter 
or initializer. 

An expression may be given. If no expression is given a new messageless and 
causeless instance of [`Exception`](#{site.urls.apidoc_current}/Exception.type.html) 
is created automatically. If an expression is given is must be assignable to 
`Exception`.

### Notes

* Ceylon does not support 'checked' exceptions. Any kind of exception may be 
  thrown without it having to be declared by a 
  [`throws` annotation](../../annotation/throws). This is even the case when 
  Ceylon code throws what in Java would be considered a *checked exception* 
  (such as `java.lang.Exception`). In other words the following is perfectly 
  acceptable to the Ceylon compiler:

<!-- try: -->
      import java.lang { CheckedException=Exception }
      
      void m() {
          throw CheckedException();
      }

### Advice

Exceptions are used somewhat less in Ceylon than in other languages, since
`null` or `[]` may be used to indicate certain kinds of problems in a more
typesafe way. For example, `list[-1]` evaluates to `null` in Ceylon, instead
of throwing an exception.

It is possible, though not usually recommended, to use `throw` to implement 
control logic. Used in this manner, `throw` is a sort of poor-man's 
[`goto`](../goto).

## See also

* [`try` statement](../try)
* [`ceylon.language.Exception`](#{site.urls.apidoc_current}/Exception.type.html)
* The [`throws`](../../annotation/throws) annotation provides a way to 
  document the exceptions which may be thrown from a method, getter, setter 
  or class initializer.
* [Control directives](#{site.urls.spec_current}#controldirectives) in the 
  Ceylon language specification

