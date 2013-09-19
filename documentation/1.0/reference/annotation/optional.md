---
layout: reference
title: '`optional` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `optional` annotation is applied to module imports which are 
not strictly required by the module.

## Usage

<!-- try: -->
    module com.example.foo "1.0" {
        optional import org.example.bar "4.5.1";
    }

## Description

## See also

* [`optional`](#{site.urls.apidoc_current}/index.html#optional)
* Reference for [annotations in general](../../structure/annotation/)

