---
layout: reference
title_md: '`native` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `native` annotation marks a declaration that is not implemented 
in the Ceylon programming language.

## Usage

<!-- try: -->
     native class Example() {
     }

## Description

Currently Ceylon does not offer a well defined "native interface", 
and therefore this annotation is intended to be used only by the 
language module and dedicated interoperability modules. In a future
version of the language, this annotation will be available for
general use.

## See also

* [`native`](#{site.urls.apidoc_1_0}/index.html#native)
* Reference for [annotations in general](../../structure/annotation/)

