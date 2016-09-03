---
layout: reference12
title_md: '`aliased` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `aliased` annotation documents alternative names for a declaration.

## Usage

The annotation accepts a list of alternative names for the declaration.

<!-- try: -->
    aliased("absolute")
    Integer magnitude(Integer n) {
        return if (n >= 0) then n else -n;
    }

## Description

The `aliased` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool. 
It should also be used by IDEs so that features such as autocomplete 
can find the declaration by any of its alternative names in addition 
to the declaration name.

## See also

* Reference for [annotations in general](../../structure/annotation/)

