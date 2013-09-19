---
layout: reference
title: '`deprecated` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

Marks a declaration which should no longer be used.

## Usage

<!-- try: -->
    deprecated("Doesn't do anything")
    void method() {
    }

## Description

It is considered good practice to use the description 
argument to record why the declaration has been 
deprecated and any alternatives to it that may exist.

The `deprecated` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool, 
which assumes it contains [Markdown formatted](../markdown/) text.

### Note

The JVM compiler will add a JVM-level `@Deprecated` annotation
to declarations marked `deprecated`, so it is clear to 
people dependent on Ceylon-compiled code that the 
declaration is to be avoided.

## See also

* [`deprecated`](#{site.urls.apidoc_current}/index.html#deprecated)
* Reference for [annotations in general](../../structure/annotation/)

