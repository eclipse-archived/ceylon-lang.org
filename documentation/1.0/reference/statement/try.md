---
layout: reference
title: '`try` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `try` statement is used to execute a block of code that may result 
in an exception, providing additional blocks to handle the exceptional 
circumstances, and, optionally, another block to be executed in all 
circumstances.

## Usage 

An example of a basic try/catch/finally construct:

<!-- check:none -->
<!-- try: -->
    try {
        // some code
    } catch (ReadException e) {
        // clean up code
    } catch (WriteException e) {
        // clean up code
    } finally {
        // clean up code
    }
    
Or, with a *resource expression*:

<!-- try: -->
    try (Reader input = open('/etc/passwd')) {
        // ...
    }

## Description

The `try` statment is used to handle exceptions thrown by the 
[`throw`](../throw) statement.

The `try` clause may optionally have a list of one or more 
[`Closeable`](#{site.urls.apidoc_current}/Closeable.type.html)-typed 
*resource expressions*. If it does then both `catch` and `finally` clauses 
are optional, otherwise at least one other of those clauses is required.

The [`catch` clause](../catch) specifies the [type](../../structure/type) 
of exception (which must be a subtype of 
[`Exception`](#{site.urls.apidoc_current}/Exception.type.html)) to be handled 
by the associated block. The block is executed only if an exception 
assignable to that type propagates out of the `try` block and the exception 
was not assignable to the type of any earlier `catch` clause.

The [`finally` clause](../finally) specifies a block to be executed whether 
or not an exception propogated out of the `try` block, and whether or not any 
matching `catch` clause was found.

### Execution

1. If there are any resource expressions they are evaluated and 
   [`open()`](#{site.urls.apidoc_current}/Closeable.type.html#open) is 
   invoked.
2. Each of the statements in the `try` block is executed
3. [`close()`](#{site.urls.apidoc_current}/Closeable.type.html#close) 
   is invoked on each of the resources acquired in 1.
4. If an exception propogates out of the `try` block, each of the
   `catch` clauses is considered in turn:
    1. If the propgated exception is a subtype of the exception type of 
        the `catch` clause the corresponding block is executed.
5. If there is a `finally` block, it is executed. 

### The `finally` guarantee

It's worth bearing in mind that the virtual machine could do things
which prevent a `finally` clause from executing, or from executing 
in a timely fashion, even though the application may continues to 
execute. Such things may include:

* Virtual machine exit
* Termination or interruption of the application thread executing the 
  finally block
* Non-terminating ("infinite loop") code while evaluating a `close()` or 
  executing a statement in a `catch` block.

### Advice

Note that [union types](../../structure/type#union_types) can and should 
be used to avoid writing multiple `catch` blocks with the same logic to 
handle disparate exception types:

<!-- try: -->
    catch (ReadException|WriteException e) {
        // ...
    }

## See also

* [`throw`](../throw)
* [`Exception`](#{site.urls.apidoc_current}/Exception.type.html)
* [`try` in the language specification](#{site.urls.spec_current}#trycatchfinally)

