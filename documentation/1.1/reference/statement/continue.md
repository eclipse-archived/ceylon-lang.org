---
layout: reference11
title_md: '`continue` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

The `continue` statement is a control directive that causes immediate execution 
of the next iteration of a `for` or `while` loop.

## Usage 

The general form of the `continue` statement is

<!-- check:none -->
<!-- try: -->
    // ...within a while or for statement
    // and often guarded by some condition
    continue;

## Description

### Execution

Within a `for` or `while` statement the `continue` directive can be used to 
skip to the next iteration of the enclosing `for` or `while` statement without 
executing the rest of the current block.

### Notes

* Java's 'labelled' `continue` directive is not supported. The `continue` 
  directive operates on the directly enclosing `for` or `while` statement.

## See also

* The [`break` statement](../break/)
* The [`for` statement](../for/)
* The [`while` statement](../while/)
* [Control directives](#{site.urls.spec_current}#controldirectives) in the 
  Ceylon language specification
