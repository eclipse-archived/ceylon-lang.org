---
layout: reference
title: '`tagged` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

Marks a declaration with an arbitrary tag.

## Usage

<!-- try: -->

    tagged("thread-safe")
    class Example() {
        tagged("blocks")
        void m() {
        }
    }

## Description

Its content should be a short keyword or identifier.

The `tagged` annotation is processed by the `ceylon doc` tool. 

## See also

* [`tagged`](#{site.urls.apidoc_current}/#tagged)

