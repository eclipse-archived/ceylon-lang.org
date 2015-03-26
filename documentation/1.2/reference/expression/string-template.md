---
layout: reference12
title_md: 'String templates'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A String template is a easy was to concatenate text and the `string` value of 
other expressions.

## Usage 

<!-- try: -->
    void example(String name, DateTime now) {
        "Hello ``name``, good ``timeOfDay(now)``!";
    }

## Description

### Syntax

A string template is simply a String literal containing paired double backticks, 
between which are the expressions which get interpolated into the resulting String.

### Type 

The type of a String template is `String`.

## See also

* [String templates](#{site.urls.spec_current}#stringtemplates) in the spec
