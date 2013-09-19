---
layout: reference
title: '`default` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `default` annotation marks a member which has a default 
implementation, but may be refined by subtypes.

## Usage

<!-- try: -->
    class Example() {
        shared default void method() {
        }
    }

## Description

Because a member that is refinable must be visible outside the 
scope of the type its defined in a `default` member is necessarily
`shared`.

## See also

* [`default`](#{site.urls.apidoc_current}/index.html#default)
* Reference for [annotations in general](../../structure/annotation/)

