---
layout: reference
title: `ceylonp` - The ceylon module tool
tab: documentation
author: Tom Bentley
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

* [`ceylonp`](#{site.urls.spec}#themoduleinfotool) in the language specification
* [module names and versions](#{site.urls.spec}#modulenamesandversionidentifiers) in the language specification.
