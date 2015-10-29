---
layout: reference12
title_md: '`see` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `see` annotation documents some other program element which is 
relevant to the annotated program element.

## Usage

The annotation accepts one or more [program element reference 
expressions](/documentation/current/tour/annotations/#the_metamodel).

<!-- try: -->
    see (`class Foo`)
    void example() {
    }
    
    see (`function example`, 
         `package com.example.examples`)
    class Foo() {
    }

## Description

The `see` annotation is processed by the `ceylon doc` tool.

## See also

* [`see`](#{site.urls.apidoc_1_2}/index.html#see)
* Reference for [annotations in general](../../structure/annotation/)
