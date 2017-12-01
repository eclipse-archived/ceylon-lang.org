---
layout: reference12
title_md: '`suppressWarnings` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `suppressWarnings` annotation is applied to a declaration to suppress 
given compiler warnings in it and its descendent elements.

## Usage

<!-- try: -->
    void functionWithWarnings() {
        suppressWarnings("unusedDeclaration")
        String unused = "";
    }

## Description

The `suppressWarnings` annotation will prevent the compiler from 
issuing the given warning or warnings on the given program elements or 
its descendents. 

Compiler warnings usually warn about things which are genuine problems with 
the code (in other words there should be few false positives), 
but there are times when a warning is 
not helpful and its presence distracts from other problems with the code. 
In these circumstances using `suppressWarnings` is entirely appropriate.

Conversely, using `suppressWarnings` should not be a reflex for 
making warnings disappear: Its use should be considered on each occasion.

## See also

* API documentation for [`suppressWarnings`](#{site.urls.apidoc_1_2}/index.html#suppressWarnings)
* Reference for [annotations in general](../../structure/annotation/)

