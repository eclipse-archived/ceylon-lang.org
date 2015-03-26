---
layout: reference12
title_md: 'Iterable enumeration'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

_Iterable enumeration_ is a notation for creating instances of
[`Iterable`](#{site.urls.apidoc_1_1}/Iterable.type.html).

## Usage 

An example iterable enumeration using 
[listed arguments](../positional-argument-list/#listed_arguments):

<!-- try: -->
    {Integer|Float|String+} tuple = {1, 2.0, "three"};

## Description

### Syntax

Syntactically an iterable enumeration is a 
[positional argument list](../positional-argument-list/) enclosed 
within braces `{` and `}`.

Iterable enumerations are commonly used with 
[comprehensions](../positional-argument-list#comprehension_arguments) to create a 
new `Iterable` thats filters, combines and/or transforms some other 
iterables. For example:

    value evens = {for (i in 0..100) if (i % 2 == 0) i};

The empty iteratable, `{}`, has the value 
[`empty`](#{site.urls.apidoc_1_1}/index.html#empty) and the type
[`Empty`](#{site.urls.apidoc_1_1}/Empty.type.html)

### Type

the type of an iterable enumeration is simply the `Iterable` 
type of the union of the types of the elements in the expression.


## See also

* [Iterable and tuple enumeration](#{site.urls.spec_current}#enumeration) 
  in the Ceylon language specification
