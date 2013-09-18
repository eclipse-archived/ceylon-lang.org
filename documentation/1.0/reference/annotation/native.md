---
layout: reference
title: '`native` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `native` annotation marks a declaration that is not implemented in the Ceylon
programming language.

## Usage

<!-- try: -->
     native class Example() {
     }

## Description

Currently Ceylon does not offer a well defined "native interface", 
and therefore this annotation is intended to be used only by 
the language module and dedicated interoperability modules.

## See also

* [`native`](#{site.urls.apidoc_current}/#native)

