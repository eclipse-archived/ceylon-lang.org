---
layout: reference
title_md: Format of module.properties files
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

Ceylon module archives (`.car` files) come with compiled-in metadata declaring 
their dependencies to other module versions. This metadata is understood by 
the Ceylon compiler, module runtime, and IDE. A Java `.jar` archive, on the
other hand, does not include any native metadata describing dependencies of the 
`.jar`. Therefore, when importing a Java `.jar` into a Ceylon module repository, 
we must provide this metadata in a separate file, either:

- a JBoss Modules [module.xml](https://docs.jboss.org/author/display/MODULES/Module+descriptors)
  descriptor, or
- a Ceylon `module.properties` file.

The format of `module.properties` is extremely simple. Each line specifies the
name and version of a dependency. For example:

<!-- check:none -->
<!-- try: -->
    ceylon.collection=1.1.0
    com.redhat.example.hello=1.0.0

Then:

- to specify that a module is a `shared` dependency, a '+' is *prepended* to 
  the module name, or 
- to specify that a module is an `optional` dependency, a `?` is *appended* 
  to the module name.

For example:

<!-- check:none -->
<!-- try: -->
    +ceylon.collection=1.0.0
    com.redhat.example.hello?=0.5

## See also

* About [modules](../module)
* The [module.xml](https://docs.jboss.org/author/display/MODULES/Module+descriptors) specification

