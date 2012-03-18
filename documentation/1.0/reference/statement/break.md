---
layout: reference
title: `break` statement
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The `break` statement is a control directive that terminates a `for` or 
`while` iteration early.

## Usage 

The general form of the `break` statement is

<!-- check:none -->
    // ...within a while or for statement
    // and often guarded by some condition
    break;

## Description

### Execution

Within a `for` or `while` statement the `break` directive can be used to exit 
the block early without waiting for the `for` iterator to be exhausted or the 
`while` condition to become `false`.

### Unsupported features

Java's 'labelled' `break` directive is not supported. The 
`break`directive operates on the directly enclosing `for` or 
`while` statment.

## See also

* The [`continue` statement](../continue/)
* The [`for` statement](../for/)
* The [`while` statement](../while/)

