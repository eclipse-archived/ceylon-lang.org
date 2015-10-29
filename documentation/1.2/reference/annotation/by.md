---
layout: reference12
title_md: '`by` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `by` annotation records an author or contributor to a piece of source code.

## Usage

<!-- try: -->
    by("Tom Bentley")
    void example() {}

## Description

It is usual to use the author's name rather than an email address, for example.

The `by` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool, 
which assumes it contains [Markdown formatted](../markdown/) text.

## See also

* API documentation for [`by`](#{site.urls.apidoc_1_2}/index.html#by)
* Reference for [annotations in general](../../structure/annotation/)

