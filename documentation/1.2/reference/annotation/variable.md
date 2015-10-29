---
layout: reference12
title_md: '`variable` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `variable` annotation marks a reference that may be 
[assigned](../../operator/assign) more than once.

## Usage

<!-- try: -->
    void example() {
        variable Integer i;
        i = 1;
        i = 2;
    }

## Description

By default, references are _immutable_. They are assigned
a value once, and may not be reassigned. The Ceylon compiler
statically verifies that a reference not declared `variable` 
is never assigned more than once. The `variable` annotation
disables this verification, allowing a reference to be
assigned multiple times.

## See also

* [`variable`](#{site.urls.apidoc_1_2}/index.html#variable)
* Reference for [annotations in general](../../structure/annotation/)
