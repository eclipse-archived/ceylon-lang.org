---
layout: reference11
title_md: '`shared` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `shared` annotation marks a declaration as being visible outside 
the scope in which it is defined, or a package as being visible 
outside the module to which it belongs.

It is also applied to module imports which are visible in the API of 
the module, and therefore must be exported to clients of the module.

## Usage

On a declaration:

<!-- try: -->
    shared void method() {
    }

On a package:

<!-- try: -->
    shared package org.example.bar;

On a module import:

<!-- try: -->
    module com.example.foo "1.0" {
        shared import org.example.bar "4.5.1";
    }

## Description

_Visibility_ is a critical concern when building modular systems.
Clients of a module should not be able to come to 'accidently' 
depend upon details of the module which are not considered part
of its well-defined API. Therefore, Ceylon requires that exported 
program elements be _explicitly_ marked as such.

By default, a declaration may not be referred to outside the scope 
in which it is declared. The `shared` annotation makes a declaration
visible to any client of the package or type to which it belongs.

## See also

* API documentation for [`shared`](#{site.urls.apidoc_current}/index.html#shared)
* Reference for [annotations in general](../../structure/annotation/)
* [Visibility](#{site.urls.spec_current}#visibility) in the Ceylon 
  language spec
