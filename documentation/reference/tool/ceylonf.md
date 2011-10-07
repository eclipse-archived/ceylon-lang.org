---
layout: reference
title: `ceylonf` - The ceylon source archive extractor
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonf [options] <module-names>...

Options include:

* `-src` specifies the output source directory
* `-rep` specifies a module repository containing dependencies. XXX can be repeated?
* `-d` Disable the default module repositories and source directory.


## Description

The source archive extractor fetches source archives and extracts 
their contents into a source directory. This is especially useful for working 
with example projects.

## See also

* [`ceylonf`](#{site.urls.spec}#thesourcearchiveextractor) in the language specification
* [module names and versions](#{site.urls.spec}#modulenamesandversionidentifiers) in the language specification.
