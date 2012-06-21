---
layout: reference
title: `ceylonc-js` - The Ceylon JavaScript compiler
tab: documentation
unique_id: docspage
author: Stef Epardaud
milestone: Milestone 3
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonc-js [options] (<module-names> | <source-files>)...

Options include:

* `-src` Specifies a source directory. Defaults to `source`.
* `-out` Specifies the output module repository (which must be publishable).
  Defaults to `modules`.
* `-rep` Specifies a module repository containing dependencies. Can be repeated.
  Defaults to `modules`.
* `-user` User name for output module repository (only if HTTP).
* `-pass` Password for output module repository (only if HTTP).
* `-d` Disable the default module repositories and source directory. <!-- m4 -->
* `-optimize` Create prototype-style JS code
* `-nomodule` Do NOT wrap generated code as CommonJS module
* `-noindent` Do NOT indent code
* `-nocomments` Do not generate any comments
* `-compact` Same as -noindent -nocomments
* `-profile` Time the compilation phases (results are printed to STDERR)
* `-help` Prints a usage help page
* `-version` Prints the Ceylon version
* `-verbose` Enables debug output.

## Description

The Ceylon JavaScript compiler `ceylonc-js` compiles Ceylon modules to JavaScript. 

### Output

`ceylonc-js` outputs a module archive for 
each module named on the command line. The compiler produces `.js` files 
that contain the whole module in a [`RequireJS`](http://requirejs.org) 
package format.

## See also

* [`ceylon`](../ceylon) the application launcher
* [`ceylonc`](#{page.doc_root}/#{site.urls.spec_relative}#thecompiler) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
