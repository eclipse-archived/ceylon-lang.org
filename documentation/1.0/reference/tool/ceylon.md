---
layout: reference
title: `ceylon` - The ceylon launcher
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylon [options] <module-name>

Options include:

* `-run` Specifies the fully qualified name of a toplevel method or class with no parameters.
* `-src` Specifies a source directory. XXX can be repeated?
* `-rep` specifies a module repository containing dependencies. XXX can be repeated?
* `-d` Disable the default module repositories and source directory.

## Description

The Ceylon launcher is used to execute a Ceylon program. Because Ceylon programs
are just Java classes, `ceylon` is effectively 'just' a front-end to the 
`java` application launcher, however `ceylon` has support for modules where 
`java` does not.

## See also

* [`ceylon`](#{page.doc_root}/#{site.urls.spec_relative}#thevmfrontent) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
