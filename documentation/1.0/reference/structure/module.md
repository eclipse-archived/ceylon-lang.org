---
layout: reference
title: Modules
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

A *module* is a set of [packages](../package) together with a 
[module descriptor](#descriptor). A module is packaged as a 
*module archive*, which serves as a unit of distribution.

## Usage 

An example module descriptor:

<!-- check:none -->
<!-- try: -->
    module com.example.foo '1.2.0' {
        import com.example.bar '3.4.1';
    }
    
This would occur in the source file 
`<source-dir>/com/example/foo/module.ceylon` where `<source-dir>` 
is a directory containing ceylon source code, conventionally 
`source`.

## Description

### Member packages

The names of the packages in a module must begin with the name 
of the module, so for example in a module called `com.example.foo` 
all package names must begin `com.example.foo`.

### Descriptor

The module descriptor holds metadata about the module and is 
declared in a source file called
`module.ceylon` in the base package of the module (that is the 
package whose name is the same as the module name). Here's an 
example:

<!-- check:none -->
<!-- try: -->
    "An example module."
    module com.example.foo '1.2.0' {
        import com.example.bar '3.4.1';
        import org.example.whizzbang '0.5';
    }

The `module` declaration may be preceeded by [annotations](../annotation), 
including:

* [`doc`](#{site.urls.apidoc_current}/index.html#doc) 
  to let you to specify module-level documentation,
* [`license`](#{site.urls.apidoc_current}/index.html#license) 
  to let you specify the module's license,
* [`by`](#{site.urls.apidoc_current}/index.html#by) 
  to document the module's author or authors. 

The module declaration itself starts with the `module` keyword 
followed by the module name and version and a list of `import`s 
enclosed in braces.

Each dependency of the module must be declared with an `import` 
declaration specifying the module name of the dependency and 
its version. 

The `import` declarations can also be annotated. Annotations 
particularly worth noting are:

* [`shared`](#{site.urls.apidoc_current}/index.html#shared) to mark the 
  imported module as also being exported to clients of this 
  module. If your module uses types from an imported module in 
  its API then the `import` for that module must be annotated 
  `shared` in the module descriptor.
* [`optional`](#{site.urls.apidoc_current}/index.html#optional) to mark
  the imported module as being an optional dependency.
* `doc`, if there is something about the dependency which is 
  worthy of documentation.


### Distribution

Modules are distributed in `.car` files, which are essentially 
`.jar` files with a different extension, and with a 
[module descriptor](#descriptor).

Modules are kept in a [module repository](../../repository). The 
list of module repositories to use is passed to 
[`ceylon compile`](#{site.urls.ceylon_tool_current}/ceylon-compile.html), 
[`ceylon run`](##{site.urls.ceylon_tool_current}/ceylon-run.html), 
and [other tools](#{page.doc_root}/reference/#tools).

## See also

* Modules contain [packages](../package)
* [Module repositories](../../repository)
* [Module system](#{site.urls.spec_current}#modulesystem)
  in the Ceylon specification
* [Packages and modules](/documentation/1.0/tour/modules/) in the tour
