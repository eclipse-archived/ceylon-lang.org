---
layout: reference12
title_md: Modules
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

A *module* is a set of [packages](../package) together with a 
[module descriptor](#descriptor). A module is packaged as a 
*module archive*, which serves as a unit of distribution.

## Usage 

An example module descriptor:

<!-- check:none -->
<!-- try: -->
    module com.example.foo "1.2.0" {
        import com.example.bar "3.4.1";
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
    module com.example.foo "1.2.0" {
        import com.example.bar "3.4.1";
        import org.example.whizzbang "0.5";
    }

The `module` declaration may be preceeded by [annotations](../annotation), 
including:

* [`doc`](#{site.urls.apidoc_1_2}/index.html#doc) 
  to let you to specify module-level documentation,
* [`license`](#{site.urls.apidoc_1_2}/index.html#license) 
  to let you specify the module's license,
* [`by`](#{site.urls.apidoc_1_2}/index.html#by) 
  to document the module's author or authors. 

The module declaration itself starts with the `module` keyword 
followed by the module name and version and a list of `import`s 
enclosed in braces.

Each dependency of the module must be declared with an `import` 
declaration specifying the module name of the dependency and 
its version. 

The `import` declarations can also be annotated. Annotations 
particularly worth noting are:

* [`shared`](#{site.urls.apidoc_1_2}/index.html#shared) to mark the 
  imported module as also being exported to clients of this 
  module. If your module uses types from an imported module in 
  its API then the `import` for that module must be annotated 
  `shared` in the module descriptor.
* [`optional`](#{site.urls.apidoc_1_2}/index.html#optional) to mark
  the imported module as being an optional dependency.
* [`doc`](#{site.urls.apidoc_1_2}/index.html#doc), 
  if there is something about the dependency which is worthy of documentation.


### Distribution

Modules are distributed in `.car` files, which are essentially 
`.jar` files with a different extension, and with a 
[module descriptor](#descriptor).

Modules are kept in a [module repository](../../repository). The 
list of module repositories to use is passed to 
[`ceylon compile`](#{site.urls.ceylon_tool_current}/ceylon-compile.html), 
[`ceylon run`](##{site.urls.ceylon_tool_current}/ceylon-run.html), 
and [other tools](#{page.doc_root}/reference/#tools).

### Legacy modules

For interoperability with Java it's possible to convert Java `.jar` files into Ceylon
compatible modules. But for that they need a module descriptor telling Ceylon what it
needs to know.

If there is any module descriptor in the jar in the following locations, it will be used:

- `META-INF/jbossmodules/module/name/version/module.xml` in the jar, or
- `META-INF/jbossmodules/module/name/version/module.properties` in the jar, or
- `META-INF/MANIFEST.MF` for OSGi modules in the jar, or
- `META-INF/maven/module/name/pom.xml` for Maven modules in the jar.

If there are no module descriptors in the jar, you can provide one externally:

* Using a `module.properties` file whose format is explained [here](../module-properties)
* Or using a JBoss Modules `module.xml` file whose detailed explanation can be found
[here](https://docs.jboss.org/author/display/MODULES/Module+descriptors)

In both cases the file must be placed in the same folder as the `.jar` file it belongs to.
The name of the `.jar` file itself and the folder structure must adhere to the same rules
as those for `.car` files.

Alternatively, you can use a [flat repository](../../interoperability/ceylon-on-jvm#flat_repositories)
to define external `module.xml` or `module.properties` descriptors in a flat folder.

### Metamodel

Modules can be manipulated at runtime via their representation as
[`Module`](#{site.urls.apidoc_1_2}/meta/declaration/Module.type.html) instances. 
A module's `import` declarations are represented as
[`Import`](#{site.urls.apidoc_1_2}/meta/declaration/Import.type.html) instances.
The [`modules`](#{site.urls.apidoc_1_2}/meta/modules.object.html) object can be 
used to list the modules currently loaded in the virtual machine.

## See also

* Modules contain [packages](../package)
* [Module repositories](../../repository)
* [Module system](#{site.urls.spec_current}#modulesystem)
  in the Ceylon specification
* You can [override dependencies](./overrides) for Maven or Ceylon modules
* [Packages and modules](/documentation/1.0/tour/modules/) in the tour
* [`ceylon import-jar`](#{site.urls.ceylon_tool_current}/ceylon-import-jar.html) command
* [`<ceylon-import-jar>`](../../tool/ant-ceylon-import-jar) ant task
