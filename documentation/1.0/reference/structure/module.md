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
[module descriptor](#descriptor) that serves as a unit of distribution.

## Usage 

An example module descriptor:

<!-- no-check -->
    Module module {
        name = 'com.example.foo';
        version = '1.0';
    }
    
Conventionally this would be in a source file located in
`<source-dir>/com/example/foo/module.ceylon` where `<source-dir>` is the
directory containing ceylon source code.

## Description

### Member packages

The names of the packages in a module must begin with the name of the module,
so for example is a module called `com.example.foo` all the the package names
must begin `com.example.foo.`.

### Descriptor

The 
[module descriptor](#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Module.html) 
holds metadata about the module, including its name, version,
module-level documentation, what packages the module exports and what other 
modules it depends on 

### Distribution

Modules are distributed in `.car` files, which are essentially `.jar` files 
with a different extension, and with a [module descriptor](#descriptor).

Modules are kept in a [module repository](../../repository). The list of module 
repositories to use is passed to 
[`ceylonc`](#{page.doc_root}/reference/tool/ceylonc), 
[`ceylon`](#{page.doc_root}/reference/tool/ceylon),  and 
[other tools](#{page.doc_root}/reference/#tools)

## See also

* Modules contain [packages](../package)
* [Module repositories](../../repository)
* ceylond documentation of the 
  [Module](#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Module.html) 
  type (the type of the module descriptor)
