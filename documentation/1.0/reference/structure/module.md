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

<!-- check:none -->
    module com.example.foo 1.2.0 {
        import com.example.bar 3.4.1
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
holds metadata about the module and is declared in a source file called
`module.ceylon` in the base package of the module (that is the package whose 
name is the same as the module name). Here's an example:

<!-- check:none -->
    doc "An example module."
    module com.example.foo 1.2.0 {
        import com.example.bar 3.4.1
        import org.example.whizzbang 0.5;
    }

The `module` declaration may be preceeded by [annotations](../annotation), including:

* [`doc`](#{site.urls.apidoc_current}/ceylon/language/#doc) 
  to let you to specify module-level documentation,
* [`license`](#{site.urls.apidoc_current}/ceylon/language/#license) 
  to let you specify the module's license,
* [`by`](#{site.urls.apidoc_current}/ceylon/language/#by) 
  to document the module's author or authors. 

The module declaration itself starts with the `module` keyword followed by the 
module name and version and a block of other declarations.

Each dependency of the module needs to be declared with an `import` declaration
specifying the module name of the dependency and its version. The `import` 
declarations can also be annotated.

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
