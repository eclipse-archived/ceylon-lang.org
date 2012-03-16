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

A string template is a simple way of constructing a String from a number of 
expressions.


## Usage 

Here's a simple example:

    String m(String name, String timeOfDay) {
        return "Hello " name " how are you " timeOfDay "";
    }


## Description

### Syntax

A string template is a whitespace separated alternating sequence of 
[string literals](../../literal/string) and
`String`-typed expressions that starts and ends with a string literal.

The following is invalid syntax because the would-be string template
does not end with a string literal:

    String greeting = "Hello" name; // ERROR


## See also

