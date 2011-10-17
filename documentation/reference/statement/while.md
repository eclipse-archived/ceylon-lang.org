---
layout: reference
title: `while` statement
tab: documentation
author: Tom Bentley
---

# #{page.title}

The `while` statement supports iteration.

## Usage 

The general form of the `while` statement is


    while ( /* condition */ ) {
        /* while block */
    }
    /* code after while statement */


## Description

A `while` statement executes a block of code repeatedly until the 
*while condition* evaluates as `false` (or the block it exited via a 
`return`, `throw` or `break` directive).

### `break` and `continue`

Within the `while` block the `break` directive can be used to exit the block 
early without waiting for the condition to become `false`.

The `contine` directive can be used to skip execution of
the remainder of the block and proceed with the execution of the block.

### Unsupported features

In Ceylon there is no `do`/`while` statement.

Java's 'labelled' `break` and `continue` directives are not supported. The 
`break` and `continue` directives operate on the directly enclosing `for` or 
`while` statment.

## See also

* The [`for` statement](../for).
* The [`while` statement](/documentation/tour/missing-pieces#control_structures) 
  in the Tour of Ceylon
* The [`while` statement](#{site.urls.spec}#while) 
  in the language specification
