---
layout: reference
title: `ceylonc` - The ceylon compiler
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonc [options] <module-names>...

Options include:

* `-src` Specifies a source directory. XXX can be repeated?
* `-out` specifies the output module repository (which must be publishable).
  If not given, the output is published to the user's repository
  (`~/.ceylon/repo` or `%HOME%\.ceylon\repo`).
* `-rep` specifies a module repository containing dependencies. XXX can be repeated?
* `-d` Disable the default module repositories and source directory.

## Description

The ceylon compiler `ceylonc` compiles Ceylon and Java source code. 

### Output

`ceylonc` outputs a module archive and a source archive for 
each module named on the command line. The compiler produceds `.car` files 
directly is does not produce individual `.class` files as `javac` does.

A `.car` file is Ceylon's equivalent of a `.jar` file.

## See also

* [`ceylon`](../ceylon) the application launcher
* [`ceylonc`](#{site.urls.spec}#thecompiler) in the language specification
* [module names and versions](#{site.urls.spec}#modulenamesandversionidentifiers) in the language specification.
