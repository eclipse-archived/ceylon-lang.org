---
layout: reference
title: '`ceylon` - The Ceylon JVM launcher'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylon [options] <module-spec> [args...]

Options include:

* `-run` Specifies the fully qualified name of a toplevel method or class with no parameters.
* `-src` Specifies a source directory. <!-- m4 -->
* `-rep` specifies a module repository containing dependencies. Can be repeated. Defaults to `modules`.
* `-d` Disable the default module repositories and source directory. <!-- m4 -->
* `-help` Prints a usage help page
* `-version` Prints the Ceylon version

## Description

The Ceylon JVM launcher is used to execute a Ceylon program on the JVM. Because Ceylon programs
are just Java classes, `ceylon` is effectively 'just' a front-end to the 
`java` application launcher, however `ceylon` has support for modules where 
`java` does not.

Any argument passed after the module name and version will be passed directly
to the Ceylon module being run.

## See also

* [`ceylon`](#{page.doc_root}/#{site.urls.spec_relative}#thevmfrontent) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
