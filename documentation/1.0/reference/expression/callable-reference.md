---
layout: reference
title_md: Callable references
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A _callable reference_ is an expression that references something 
(a function, method, or class) that can be invoked by specifying 
an [argument list](../argument-list).

## Usage

<!-- try: -->
    value classReference = String;
    value methodReference = 1.plus;
    value functionReference = sum<Integer>;
    
## Description

Callable references introduce a level of indirection between the 
definition of a function, method, or class, and the invocation of
the function, method, or class, allowing the definition of generic
functions, called _higher order functions_, that operate upon
callable references.

### Type

The type of a callable reference is the 
[callable type](../../structure/function/#callable_type) of the 
thing being referenced, so referring to the [example above](#usage),

* the type of `classReference` is `String({Character*})`,
* the type of `methodReference` is  `Integer(Integer)`.
* the type of `functionReference` is `Integer({Integer+})`,

### Unreferenceable things

It's not possible to obtain a callable reference to an `abstract` 
class, because calling it would be the same as instantiating the 
`abstract` class. So, for example, the following code is illegal:

    value objectReference = Object;

A callable reference to a generic declaration must specify type 
arguments, as shown by `functionReference` in the [example above](#usage). 
This code is illegal:

    value functionReference = sum;

### Invocation

A callable reference may be invoked, for example:

    classReference({'h', 'e', 'l', 'l', 'o'})

The interface `Callable` doesn't encode information about parameter 
names. So a callable reference may only be invoked with a positional 
argument list, not a named argument list.

## See also

* [Callable references](#{site.urls.spec_current}#callablereferences) 
  in the Ceylon language specification
