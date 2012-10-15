---
layout: reference
title: '`ceylon-js` - The Ceylon JavaScript launcher'
tab: documentation
unique_id: docspage
author: Stef Epardaud
milestone: Milestone 3
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylon-js [options] <module-spec>

Options include:

* `-run` Specifies the fully qualified name of a toplevel method with no parameters.
* `-src` Specifies a source directory. <!-- m4 -->
* `-rep` specifies a module repository containing dependencies. Can be repeated. Defaults to `modules`.
* `-d` Disable the default module repositories and source directory. <!-- m4 -->
* `-help` Prints a usage help page
* `-version` Prints the Ceylon version

## Description

The Ceylon JavaScript launcher is used to execute a Ceylon program on `node.js`. Because Ceylon programs
are just JavaScript modules, `ceylon-js` is effectively 'just' a front-end to the 
`node` application launcher (from `node.js`).

Note that you cannot currently use non-local repositories or pass program arguments, but this
will be fixed in the next release.

## See also

* [`ceylon`](#{page.doc_root}/#{site.urls.spec_relative}#thevmfrontent) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
