---
layout: reference12
title_md: '`serializable` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `serializable` annotation is applied to a `class` to denote that it 
should be able to externalize its state. Ultimately the serializability of an 
instance is also dependent on the serialization library being used.

## Usage

<!-- try: -->
    serializable class Foo() {}

## Description

The `serializable` annotation causes the compiler to generate extra hidden 
code which allows the instances state (including non-`shared` state) to be 
externalized to a `Deconstructor`, and to initialize an instance from a 
`Deconstructed`.

## See also

* API documentation for [`serializable`](#{site.urls.apidoc_1_2}/index.html#serializable)
* Reference for [annotations in general](../../structure/annotation/)

