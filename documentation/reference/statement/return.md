---
layout: reference
title: `return` statement
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The `return` statement is a control directive that returns control normally 
to the caller of the attribute getter, method or function.

## Usage 

The general form of the `return` statement is

    // ...within an attribute getter, method or function
    return resultExpression;

For `void` methods or functions no result expression is given:

    // ...within an void method or function
    return;

## Description

### Execution

The `return` statement causes execution to resume with the caller of the
attribute getter, method or function.

## See also

* The [`throw` statement](../throw/), used for abnormal return from an 
  attribute getter, method or function

