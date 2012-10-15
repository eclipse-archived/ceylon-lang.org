---
layout: reference
title: '`continue` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The `break` statement is a control directive that skips the remainder of the 
current iteration and proceeds with the next iteration.

## Usage 

The general form of the `continue` statement is

<!-- check:none -->
    // ...within a while or for statement
    // and often guarded by some condition
    continue;

## Description

### Execution

Within a `for` or `while` statement the `continue` directive can be used to 
skip to the next iteration of the enclosing `for` or `while` statement without 
executing the rest of the block.

### Unsupported features

Java's 'labelled' `continue` directive is not supported. The 
`continue`directive operates on the directly enclosing `for` or 
`while` statment.

## See also

* The [`break` statement](../break/)
* The [`for` statement](../for/)
* The [`while` statement](../while/)

