---
layout: reference13
title_md: '`doc` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `doc` annotation adds freeform API documentation to a declaration.

## Usage

Explict `doc` annotation:

<!-- try: -->
    doc ("Some documentation")
    void example(){
    }

Implict use of `doc` via the "anonymous annotation":

<!-- try: -->
    "More documentation"
    void furtherExample() {
    }

## Description

The `doc` annotation is processed by the 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) tool, 
which assumes it contains [Markdown formatted](../markdown/) text.

### Anonymous annotation

As shown above, the annotation can be used in two forms, either

* using explicit invocation of `doc`, or
* as a string literal, when it is the first annotation in the list of 
  annotations of the declaration

The anonymous form is very strongly preferred.

## See also

* [`doc`](#{site.urls.apidoc_1_3}/index.html#doc)
* Reference for [annotations in general](../../structure/annotation/)

