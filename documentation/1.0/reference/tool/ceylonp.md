---
layout: reference
title: `ceylonp` - The ceylon module tool
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonp [options] <module-names>...

Options include:

* `-src` Specifies a source directory. XXX can be repeated?
* `-rep` specifies a module repository containing dependencies. XXX can be repeated?
* `-d` Disable the default module repositories and source directory.

## Description

The module info tool prints information about the contents of a module 
archive, its description, its licence, and its dependencies to the console.

## See also

* [`ceylonp`](#{page.doc_root}/#{site.urls.spec_relative}#themoduleinfotool) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
