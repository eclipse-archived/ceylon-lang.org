---
layout: reference
title: `ceylond` - The ceylon documentation compiler
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylond [options] <module-spec>...

Options include:

* `-out` Specifies the output module repository (which must be publishable).
* `-src` Specifies a source directory. Defaults to `sources`.
* `-rep` specifies a module repository containing dependencies. Can be repeated.
  Defaults to `modules`.
* `-non-shared` Includes documentation for package-private declarations.
* `-source-code` Includes source code to the generated documentation.   
* `-d` Disable the default module repositories and source directory. <!-- m3 -->

## Description

The documentation compiler generates HTML 5 documentation from Ceylon 
source files.

## See also

* [`ceylond`](#{page.doc_root}/#{site.urls.spec_relative}#thedocumentationcompiler) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
