---
layout: reference
title_md: '`ceylon` - The Ceylon command'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `ceylon` command provides access to the Ceylon command line toolset.

## Usage 

<!-- lang: none -->
    ceylon [<options>...] <command> [<command-args>...]


## Description
 
The top level `ceylon` command is the entry point for a particular subcommand. 
There is a [list of the available subcommands](#{site.urls.ceylon_tool_current}/index.html).

The rest of this page will highlight particular tools

### Backend-agnostic commands

* [`ceylon help`](#{site.urls.ceylon_tool_current}/ceylon-help.html)
  provides interactive help about other `ceylon` commands.
* [`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html)
  is the command line interface to the Ceylon documentation compiler
* [`ceylon new`](#{site.urls.ceylon_tool_current}/ceylon-new.html)
  generates Ceylon projects from templates

### JVM-specific commands

* [`ceylon compile`](#{site.urls.ceylon_tool_current}/ceylon-compile.html) 
  is the command line interface to the Ceylon compiler
* [`ceylon run`](#{site.urls.ceylon_tool_current}/ceylon-run.html)
  is the command line interface for launching a Ceylon program on the JVM
* [`ceylon test`](#{site.urls.ceylon_tool_current}/ceylon-test.html)
  is the command line interface for executing tests on the JVM
* [`ceylon import-jar`](#{site.urls.ceylon_tool_current}/ceylon-import-jar.html)
  is the command line interface for launching a Ceylon program on the JVM
  
### JavaScript-specific commands

* [`ceylon compile-js`](#{site.urls.ceylon_tool_current}/ceylon-compile-js.html)
  is the command line interface to the Ceylon compiler for JavaScript
* [`ceylon run-js`](#{site.urls.ceylon_tool_current}/ceylon-run-js.html)
  is the command line interface for launching a Ceylon program on the node.js
 

## See also

* The complete list of [subcommands](#{site.urls.ceylon_tool_current}/index.html).
