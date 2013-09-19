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

The `tagged` annotation is processed by the `ceylon doc` tool.

Its content should be a short keyword or identifier, and
*not* [Markdown formatted](../markdown/) text.

## See also

* [`tagged`](#{site.urls.apidoc_current}/index.html#tagged)
* Reference for [annotations in general](../../structure/annotation/)

