---
layout: reference
title: '`return` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

The `return` statement is a control directive that returns control normally 
to the caller of the value getter or function.

## Usage 

The general form of the `return` statement is

<!-- check:none -->
<!-- try: -->
    // ...within a value getter or function
    return resultExpression;

For `void` functions no result expression is given:

<!-- check:none -->
<!-- try: -->
    // ...within an void method or function
    return;

## Description

### Execution

The `return` statement causes execution to resume with the caller of the
value getter or function.

## See also

* The [`throw` statement](../throw/), used for abnormal return from an 
  value getter, method or function

