---
layout: reference
title_md: '`return` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

The `return` statement is a control directive that returns control normally 
to the caller of a function, class, getter, or setter. In the case of a
getter or non-`void` function, it also specifies the return value.

## Usage 

For getters or non-`void` functions, a `return` statement specifies a 
a result expression:

<!-- check:none -->
<!-- try: -->
    // ...within a getter or function
    return resultExpression;

For `void` functions, classes, or setters, no result expression is given:

<!-- check:none -->
<!-- try: -->
    // ...within a void function, class, or setter
    return;

## Description

### Execution

The result expression, if any, is evaluated, and then execution resumes 
with the caller of the value getter or function.

## See also

* The [`throw` statement](../throw/), used for abnormal return from an 
  value getter, method or function
* [Control directives](#{site.urls.spec_current}#controldirectives) in the 
  Ceylon language specification

