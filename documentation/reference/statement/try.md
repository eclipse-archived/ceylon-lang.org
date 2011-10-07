---
layout: reference
title: `try` statement
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

    try {
        // some code
    } catch (ExceptionType e) {
        // clean up code
    } catch (OtherExceptionType|ThirdException e) {
        // clean up code
    } finally {
        // clean up code
    }

## Description

The `try` statment is used to handle exceptions thrown by the 
[`throw`](../throw) statement. The statement is made up of a number of parts. 

The mandatory `try` block is code to be executed which is anticipated to 
throw some kind of exception. 

Any number of `catch` blocks may be specified. If the code in the `try` block 
throws an exception then each of the catch blocks is examined in order. If the 
exception instance can be assigned to the type of the given catch block the 
execution proceeds with that block. If that block is executed without itself 
throwing an exception execution proceeds with the `finally` block if any). 
In other words it is only the first matching `catch` block which is executed 
later matching blocks will be ignored.

A `finally` block may optionally be given. The code in this block is executed
whether or not an exception was thrown by the code in the `try` block (and 
assuming any `catch` block doesn't raise an exception). 

Note that [intersection types](FIXME) can and should be used to avoid using 
multiple `catch` blocks which use the same logic to handle disparate 
exception types.

## Grammar

    tryCatchFinally : tryBlock ( catchBlock )* ( finallyBlock )? ;

## See also

* [`throw`](../throw)
* [`Exception`](../../ceylon.language/Exception)
* [`try` in the language specification](#{site.urls.spec}#trycatchfinally)

