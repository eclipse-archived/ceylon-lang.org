---
layout: reference12
title_md: '`license` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `license` annotation is applied to a module to record its license.

## Usage

<!-- try: -->
    license("[ASL 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)")
    module com.example.foo "1.0" {
    }

## Description

The `license` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool, 
which assumes it contains [Markdown formatted](../markdown/) text.

It is strongly recommended that the argument to license contain a 
link to a license document, or the full text of the license, rather 
than a license name (which might be ambiguous or unknown to the reader).

## See also

* API documentation for [`license`](#{site.urls.apidoc_1_2}/index.html#license)
* Reference for [annotations in general](../../structure/annotation/)

