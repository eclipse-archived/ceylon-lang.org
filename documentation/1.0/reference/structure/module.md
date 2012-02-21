---
layout: reference
title: Modules
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

In Ceylon, a *module* is a collection of [packages](../package) together with a 
*module descriptor* that serves as a unit of distribution.

## Usage 

An example module descriptor:

TODO

## Description

### Member packages

The names of the packages in a module must begin with the name of the module,
so for example is a module called `com.example.foo` all the the package names
must begin `com.example.foo.`.

### Distribution

Modules are distributed in `.car` files, which are essentially `.jar` files 
with a different extension, and with a [module descriptor](#usage).

Modules are kept in a *module repository*. The list of module 
repositories to use is passed to the 
[`ceylonc`](#{page.doc_root}/reference/tool/ceylonc), 
[`ceylon`](#{page.doc_root}/reference/tool/ceylon),  and 
[other tools](#{page.doc_root}/reference/#tools)

### Naming






## See also


