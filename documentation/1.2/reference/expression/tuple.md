---
layout: reference12
title_md: 'Tuple enumeration'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

_Tuple enumeration_ is a notation for creating instances of
[`Tuple`](#{site.urls.apidoc_1_2}/Tuple.type.html).

## Usage 

An example tuple enumeration using 
[listed arguments](../positional-argument-list/#listed_arguments):

<!-- try: -->
    [Integer, Float, String] one23 = [1, 2.0, "three"];

## Description

### Syntax

Syntactically a tuple enumeration is a 
[positional argument list](../positional-argument-list/) enclosed 
within square brackets `[` and `]`.

If you supply no arguments you obtain the empty tuple, `[]`, 
which is precisely the same as 
[`empty`](#{site.urls.apidoc_1_2}/index.html#empty).

All kinds of positional argument are available. 
For example, consider
the tuple constructed using a 
[spread argument](../positional-argument-list/#spread_arguments):

<!-- try: -->
    [Integer, Integer, Float, String] zero123 = [0, *one23];

Or a tuple enumeration with a 
[comprehension argument](../positional-argument-list/#comprehension_arguments):

<!-- try: -->
    value oneTo10 
        = [1, 2, for (i in 3..10) i ];



### Type

The type of a tuple enumeration is the 
[`Tuple`](#{site.urls.apidoc_1_2}/Tuple.type.html) 
type of the list of arguments it contains.


## See also

* [Iterable and tuple enumeration](#{site.urls.spec_current}#enumeration) 
  in the Ceylon language specification
