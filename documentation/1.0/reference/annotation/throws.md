---
layout: reference
title: '`throws` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `throws` annotation documents a exception that can be thrown by some code. 

## Usage

<!-- try: -->
    throws(`class AssertionException`, "If i < 0")
    void example(Integer i)

## Description

The `throws` annotation is processed by the `ceylon doc` tool.

## See also

* [`throws`](#{site.urls.apidoc_current}/#throws)

