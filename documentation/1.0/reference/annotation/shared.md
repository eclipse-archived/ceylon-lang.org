---
layout: reference
title: '`shared` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `shared` annotation marks a declaration as being visible outside 
the scope in which it is defined.

It is also applied to module imports which are visible in the API of 
the module, and therefore must be exported to clients of the module.

## Usage

On a declaration:

<!-- try: -->
    shared void method() {
    }

On a module import:

<!-- try: -->
    module com.example.foo "1.0" {
        shared import org.example.bar "4.5.1";
    }

## Description

## See also

* API documentation for [`shared`](#{site.urls.apidoc_current}/index.html#shared)
* Reference for [annotations in general](../../structure/annotation/)
* [Visibility](#{site.urls.spec_current}#visibility) in the Ceylon 
  language spec
