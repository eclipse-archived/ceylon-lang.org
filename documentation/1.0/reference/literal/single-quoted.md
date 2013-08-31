---
layout: reference
title: Single quoted literals
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

Single-quoted literals are character sequences enclosed between single 
quotes (`'`).

## Usage 


<!-- check:none -->
    Regex pattern = '[Cc]eylon';
    Date date = '2011-10-04';

## Description

The purpose of single-quoted literals is to express literal values for 
types with a string-like representation. Examples might include 
regular expressions, date times, durations, RGB colours, URIs etc.

### Implementation

Single quoted literals will be implemented in Ceylon 1.1. As a 
special case their use in 
[module](../../structure/module#descriptor) and 
[package](../../structure/package#descriptor) descriptors
is permitted in Ceylon 1.0.

### Unicode characters

Since Ceylon source files are preprocessed for unicode escapes prior to parsing
you can use unicode escapes within single quoted literals, like this:

<!-- check:none -->
    Regex quotation = 'I think \u2234 I am|To be or not to be'; // an escaped Unicode therefore symbol

### Escaping

How single quoted literals will be escaped has not been decided yet.

### Line spanning

Whether single quoted literals will be allowed to span lines has not been 
decided yet.

## See also

* [Single quoted literals in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#singlequotedliterals)

