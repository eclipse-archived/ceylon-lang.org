---
layout: reference
title: String templates
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

A `String` template is a simple way of constructing a String from a number of 
expressions, a feature also known as *`String` interpolation*.

## Usage 

Here's a simple example:

    String m(String name, String timeOfDay) {
        return "Hello ``name`` how are you ``timeOfDay``?";
    }

## Description

### Syntax

A string template is a 
[string literals](../../literal/string) with embedded expressions 
(whose type must be assignable to `Object`) enclosed within 
double backticks (` `` `).


## See also

* [`String` literal](../../literal/string]
