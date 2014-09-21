---
layout: reference11
title_md: '`default` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `default` annotation marks a member which has a default 
implementation, but may be refined by subtypes.

## Usage

<!-- try: -->
    class Example() {
        shared default void method() {
        }
    }

## Description

Methods, attributes, and member classes may be annotated `default`.

Because a member that is refinable must be visible outside the 
scope of the type it's defined in, a `default` member is necessarily
`shared`.

## See also

* API documentation for [`default`](#{site.urls.apidoc_current}/index.html#default)
* Reference for [annotations in general](../../structure/annotation/)

