---
layout: reference
title: 'Callable references'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A Callable reference is an expression that references something (a function, method or class) 
that can be invoked by specifying an [argument list](../argument-list).

## Usage

<!-- try: -->
    value classReference = String;
    value methodReference = 1.plus;
    value functionReference = sum<Integer>;
    
## Description

### Type

The type of a Callable reference is the 
[callable type](../../structure/function/#callable_type) 
of the thing being referenced, so referring to the [example above](#usage),

* the type of `classReference` is `String({Character*})`,
* the type of `methodReference` is  `Integer(Integer)`.
* the type of `functionReference` is `Integer({Integer+})`,

### Unreferencable things

You cannot take a Callable reference of an `abstract` class (because calling it would be the 
same as instantiating the `abstract` class), so `value objectReference = Object;` 
would be a compile-time error.

If referring to a type parameterized thing, you must specify the type arguments, as 
shown by `functionReference` in the [example above](#usage). Saying 
`value functionReference = sum;` would be a compile-time error.

### Invocation 

Because a Callable doesn't encode information about parameter names when invoking the result of a 
Callable reference (e.g. `methodExample(1)` using the [example above](#usage)) you must use a 
positional argument list, not a named argument list.

## See also
