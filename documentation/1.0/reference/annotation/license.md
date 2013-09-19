---
layout: reference
title: '`license` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `license` annotation is applied to a module to record its license.

## Usage

<!-- try: -->
    license("http://www.apache.org/licenses/LICENSE-2.0.html")
    module com.example.foo "1.0" {
    }

## Description

The `license` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool, 
which assumes it contains [Markdown formatted](../markdown/) text.

It is strongly recommended that the argument to 
license is an `http:` 
URL to a license document, rather than a license name 
(which could be ambiguous or unknown to the reader), 
or the full license test.

## See also

* [`license`](#{site.urls.apidoc_current}/index.html#license)
* Reference for [annotations in general](../../structure/annotation/)

