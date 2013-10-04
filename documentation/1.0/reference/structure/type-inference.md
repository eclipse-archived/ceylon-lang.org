---
layout: reference
title_md: Type inference
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Local declarations can often let the 
compiler infer the type. 

## Usage 

<!-- try: -->
    value i = 1;      // infers Integer i
    value b = true;   // infers Boolean
    value tuple = ["", 1] // infers [String, Integer]
    function f() => 1 // infers Integer()

## Description

You use the `function` keyword to infer a function's type, and `value` to 
infer a value's type.

Because Ceylon's type system is based 
on *principal types* there is only one type the compiler can infer.

### Limitations

Type inference cannot be used in all circumstances. It cannot be used:

* on `shared` or `formal` declarations
* when the value is specified after it's declared
* to declare a parameter


