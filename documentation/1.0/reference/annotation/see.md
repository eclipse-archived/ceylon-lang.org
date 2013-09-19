---
layout: reference
title: '`see` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `see` annotation documents some other declaration which 
is relevant to the declaration it is applied to.

## Usage

<!-- try: -->
    see(`class Foo`)
    void example() {
    }
    
    see(`function example`)
    class Foo() {
    }

## Description

The `see` annotation is processed by the `ceylon doc` tool.

## See also

* [`see`](#{site.urls.apidoc_current}/index.html#see)
* Reference for [annotations in general](../../structure/annotation/)

