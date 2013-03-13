---
layout: reference
title: '`while` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The `while` statement supports iteration.

## Usage 

The general form of the `while` statement is

<!-- check:none -->
    while ( /* condition */ ) {
        /* while block */
    }
    /* code after while statement */


## Description

### Execution

A `while` statement executes a block of code repeatedly until the 
*while condition* evaluates as `false` (or the block it exited via a 
`return`, `throw` or `break` directive).

### `break` and `continue`

Within the `while` block the [`break` directive](../break/) can be used to 
exit the block early without waiting for the condition to become `false`.

The [`continue` directive](../continue/) can be used to skip execution of
the remainder of the block and proceed with the execution of the block.

### `Boolean` conditions

Any `Boolean` expression can be used as a condition in an `while` statement.

### 'Special' conditions

The `while` statement also supports the use of certain special form conditions:

* [`while (is ...)`](../conditions/#if_is_), 
* [`while (exists ...)`](../conditions/#if_exists_), 
* [`while (nonempty ...)`](../conditions/#if_nonempty_), 
* [`while (satisfies ...)`](../conditions/#if_satisfies_).

these narrow the type of a reference within the associated block.


### Condition lists

The condition in a `while` statement can also be a
[condition list](../conditions#condition_lists).

The difference between a 
condition list and a single `Boolean` condition constructed using the 
[`&&` operator](../../operator/and/)
is that the typecasting of conditions in the list take effect for conditions 
later in the list, allowing you to write:

    Object takeNext() {
        // ...
    }

    void takeSmallIntegers() {
        while (is Integer x=takeNext(), x < 10) {
            // ...
        }
    }

### Unsupported features

In Ceylon there is no `do`/`while` statement.

## See also

* The [`break` statement](../break/)
* The [`continue` statement](../continue)
* The [`for` statement](../for)
* The [`while` statement](#{page.doc_root}/tour/attributes-control-structures#control_structures) 
  in the Tour of Ceylon
* The [`while` statement](#{page.doc_root}/#{site.urls.spec_relative}#while) 
  in the language specification
