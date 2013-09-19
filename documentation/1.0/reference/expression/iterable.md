---
layout: reference
title: 'Iterable enumeration'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

An iterable enumeration is a notation for creating an
[`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) instance.

## Usage 

<!-- try: -->
    Iterable[Integer|Float|String] tuple = {1, 2.0, "three"};

## Description

### Syntax

Syntactically an iterable enumeration is an 
[argument list](../../structure/argument-list/) enclosed 
within braces `{` and `}`.

The empty iteratable, `{}`, has the value 
[`empty`](#{site.urls.apidoc_current}/index.html#empty) and the type
[`Empty`](#{site.urls.apidoc_current}/Empty.type.html)

### Type

the type of an iterable enumeration is simply the `Iterable` 
type of the union of the types of the elements in the expression.


## See also

* [Iterable enumeration](#{site.urls.spec_current}#enumeration) in the spec
