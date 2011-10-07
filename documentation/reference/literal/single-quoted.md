---
layout: reference
title: Single quoted literals
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

Single-quoted literals are character sequences enclosed between single 
quotes (`'`).


    Regex pattern = '[Cc]eylon';
    Date date = '2011-10-04';

## Description

The purpose of single-quoted literals is to express literal values for 
types with a string-like representation. Examples might include 
regular expressions, date times, durations, RGB colours, URIs etc.

### Unicode characters

Since Ceylon source files are preprocessed for unicode escapes prior to parsing
you can use unicode escapes within single quoted literals, like this:


    Regex quotation = 'I think \u2234 I am|To be or not to be'; // an escaped Unicode therefore symbol

### Escaping

TODO

### Line spanning

TODO

## See also

* [Single quoted literals in the language specification](#{site.urls.spec}#singlequotedliterals)

