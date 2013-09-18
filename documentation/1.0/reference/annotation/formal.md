---
layout: reference
title: '`formal` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `formal` annotation marks a member as not having a concrete implementation;
one must be provided by subtypes.

## Usage

<!-- try: -->

    class abstract Example() {
        shared formal void method() {
        }
    }

## Description

Methods, attributes, member classes and member interfaces may be annotated `formal`.

Because a member that is refinable must be visible outside the 
scope of the type its defined in a `default` member is necessarily
`shared`.

Only `abstract` classes and interfaces are permitted to have `formal` members.

`formal` is the Ceylon equivalent of Java's `abstract` modifier on methods.

## See also

* [`formal`](#{site.urls.apidoc_current}/#formal)

