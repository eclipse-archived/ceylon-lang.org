---
layout: reference13
title_md: '`formal` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `formal` annotation marks a member as not having a concrete implementation;
one must be provided by subtypes.

## Usage

<!-- try: -->

    class abstract Example() {
        shared formal void method() {
        }
    }

## Description

Methods, attributes, and member classes may be annotated `formal`.

Because a member that is refinable must be visible outside the 
scope of the type it's defined in, a `formal` member is necessarily
`shared`.

Only `abstract` classes and interfaces are permitted to have `formal` members.

`formal` is the Ceylon equivalent of Java's `abstract` modifier on methods.

## See also

* API documentation for [`formal`](#{site.urls.apidoc_1_3}/index.html#formal)
* Reference for [annotations in general](../../structure/annotation/)

