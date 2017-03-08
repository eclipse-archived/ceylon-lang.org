---
layout: reference12
title_md: '`while` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `while` statement executes a block of code repeatedly.

## Usage 

The general form of the `while` statement is:

<!-- check:none -->
<!-- try: -->
    while ( /* condition */ ) {
        /* while block */
    }
    /* code after while statement */


## Description

### Execution

A `while` statement executes a block of code repeatedly until the 
`while` condition evaluates to `false` (or the block is exited via 
a `return`, `throw` or `break` directive).

### `break` and `continue`

Within the `while` block the [`break` directive](../break/) can be 
used to exit the block early without waiting for the condition to 
become `false`.

The [`continue` directive](../continue/) can be used to skip 
execution of the remainder of the block.

### Conditions

The conditions in a `while` statement form a
[condition list](../conditions#condition_lists).

Any expression of type [`Boolean`](#{site.urls.apidoc_1_2}/Boolean.type.html) 
may be occur in the condition list of a `while` statement. The 
`while` statement also supports the use of typing conditions:

* [`is` conditions](../conditions/#_is_conditions), 
* [`exists` conditions](../conditions/#_exists_conditions), and
* [`nonempty` conditions](../conditions/#_nonempty_conditions).

These conditions narrow the type of a reference within the `while` 
block, and in later conditions in the condition list.

<!-- try: -->
    Object takeNext() {
        // ...
    }
    
    void takeSmallIntegers() {
        while (is Integer x=takeNext(), x < 10) {
            // ...
        }
    }

### Notes

* Ceylon has no `do`/`while` statement as seen in other C-like 
  languages.

## See also

* The [`break` statement](../break/)
* The [`continue` statement](../continue)
* The [`for` statement](../for)
* The [`while` statement](#{page.doc_root}/tour/attributes-control-structures#control_structures) 
  in the Tour of Ceylon
* The [`while` statement](#{site.urls.spec_current}#while) 
  in the language specification
