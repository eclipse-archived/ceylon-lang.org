---
layout: reference
title: 'Tuple enumeration'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A tuple enumeration is a notation for 
[`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html) instances.

## Usage 

<!-- try: -->
    [Integer, Float, String] tuple = [1, 2.0, "three"];

## Description

### Syntax

Syntactically a tuple enumeration is an 
[argument list](../../structure/argument-list/) enclosed 
within square brackets `[` and `]`.

The empty tuple, `[]`, has the value 
[`empty`](#{site.urls.apidoc_current}/index.html#empty).

### Type

The type of a tuple enumeration is the type of the list 
of arguments it contains.

As well as the [example above](#usage), consider
the tuple constructed using a [
spread argument](../argument-list#spread_argument):

<!-- try: -->
    {Integer*} ints = {};
    [Integer+] variadic = [1, *ints];

## See also

* [Tuple enumeration](#{site.urls.spec_current}#enumeration) in the spec
