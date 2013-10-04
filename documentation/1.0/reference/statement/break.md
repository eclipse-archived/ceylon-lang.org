---
layout: reference
title_md: '`break` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

The `break` statement is a control directive that causes immediately 
termination of a `for` or `while` loop.

## Usage 

The general form of the `break` statement is

<!-- check:none -->
<!-- try: -->
    // ...within a while or for statement
    // and often guarded by some condition
    break;

## Description

### Execution

Within a `for` or `while` statement the `break` directive can be used to exit 
the block early without waiting for the `for` iterator to be exhausted or the 
`while` condition to become `false`.

### Notes

* Java's 'labelled' `break` directive is not supported. The `break` directive 
  operates on the directly enclosing `for` or `while` statement.

## See also

* The [`continue` statement](../continue/)
* The [`for` statement](../for/)
* The [`while` statement](../while/)
* [Control directives](#{site.urls.spec_current}#controldirectives) in the 
  Ceylon language specification
