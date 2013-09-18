---
layout: reference
title: '`doc` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `doc` annotation adds documentation to a declaration.

## Usage

    doc("Some documentation")
    void example(){
    }
    
    "More documentation"
    void furtherExample() {
    }

## Description

The `doc` annotation is processed by the `ceylon doc` tool.

### Anonymous annotation

As shown above, the annotation can be used in two forms, 

* explicitly invocation of `doc`, or
* as a string literal, when it is the first annotation 
  in the list of annotations of the declaration

The anonymous form is preferred.

### Markdown syntax

The `ceylon doc` tool expects the documentation the be formatted using 
[Markdown syntax](http://daringfireball.net/projects/markdown/syntax).

### Wiki-style links

An alternatve syntax is supported for linking between pieces of documentation, 
as an extension to Markdown syntax.

TODO

## See also

* [`doc`](#{site.urls.apidoc_current}/#doc)

