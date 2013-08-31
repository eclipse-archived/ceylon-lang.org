---
layout: reference
title: '`ceylon` - The Ceylon command'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `ceylon` command provides access to the Ceylon command line toolset.

## Usage 

<!-- lang: none -->
    ceylon [<options>...] <command> [<command-args>...]


## Description
 
The top level `ceylon` command is the entry point for a particular subcommand. 
There is a [list of the available subcommands](subcommands).

The rest of this page will highlight particular tools

### Backend-agnostic commands

* [`ceylon help`](subcommands/ceylon-help.html)
  provides interactive help about other `ceylon` commands.
* [`ceylon doc`](subcommands/ceylon-doc.html)
  is the command line interface to the Ceylon documentation compiler
* [`ceylon new`](subcommands/ceylon-new.html)
  generates Ceylon projects from templates

### JVM-specific commands

* [`ceylon compile`](subcommands/ceylon-compile.html) 
  is the command line interface to the Ceylon compiler
* [`ceylon run`](subcommands/ceylon-run.html)
  is the command line interface for launching a Celyon program on the JVM
* [`ceylon import-jar`](subcommands/ceylon-import-jar.html)
  is the command line interface for launching a Celyon program on the JVM
  
### JavaScript-specific commands

* [`ceylon compile-js`](subcommands/ceylon-compile-js.html)
  is the command line interface to the Ceylon compiler for JavaScript
* [`ceylon run-js`](subcommands/ceylon-run-js.html)
  is the command line interface for launching a Celyon program on the node.js
 

## See also

* [`ceylon`](#{page.doc_root}/#{site.urls.spec_relative}#vmfrontent) in the language specification

