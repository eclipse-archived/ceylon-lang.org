---
layout: reference
title: `ceylonc` - The Ceylon JVM compiler
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonc [options] (<module-names> | <source-files>)...

Options include:

* `-src` Specifies a source directory. Defaults to `source`.
* `-out` Specifies the output module repository (which must be publishable).
  Defaults to `modules`.
* `-rep` Specifies a module repository containing dependencies. Can be repeated.
  Defaults to `modules`.
* `-user` User name for output module repository (only if HTTP). <!-- m2 -->
* `-pass` Password for output module repository (only if HTTP). <!-- m2 -->
* `-verbose` Enables debug output.
* `-d` Disable the default module repositories and source directory. <!-- m4 -->
* `-help` Prints a usage help page
* `-version` Prints the Ceylon version

## Description

The Ceylon JVM compiler `ceylonc` compiles Ceylon and Java source code for the
Java platform.

### Output

`ceylonc` outputs a module archive and a source archive for 
each module named on the command line. The compiler produces `.car` files 
directly: it does not produce individual `.class` files as `javac` does.

A `.car` file is Ceylon's equivalent of a `.jar` file.

## See also

* [`ceylon`](../ceylon) the application launcher
* [`ceylonc`](#{page.doc_root}/#{site.urls.spec_relative}#thecompiler) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
