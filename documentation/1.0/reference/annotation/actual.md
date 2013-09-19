---
layout: reference
title: '`actual` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `actual` annotation marks a member as refining an inherited member.

## Usage

<!-- try: -->
    class Example() {
        shared actual String string = "example";
    }

## Description

Methods, attributes, member classes and member interfaces may be annotated `actual`, 
and only when the member that they are refining was annotated `default` for `formal`.

Because a member that is refinable must be visible outside the 
scope of the type its defined in an `actual` member is necessarily
`shared`.

`actual` is the Ceylon equivalent of Java's `@Override` annotation, but unlike 
`@Override` is *must* be used when refining a member.


## See also

* API documentation for [`actual`](#{site.urls.apidoc_current}/index.html#actual)
* Reference for [annotations in general](../../structure/annotation/)

