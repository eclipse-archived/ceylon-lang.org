---
layout: reference13
title_md: Module repositories
tab: documentation
unique_id: docspage
author: Stéphane Épardaud
doc_root: ../..
---

# #{page.title_md}

Ceylon supports modules natively. Ceylon modules contain the following:

- A [module descriptor](../structure/module), which contains:
  - A unique name and version
  - Meta-data such as author, license, documentation
  - A list of module dependencies
- A list of packages
- Optionally, a source archive
- Optionally, an API documentation archive

Ceylon modules are published in Ceylon repositories, which are then used
by Ceylon tools to consume and produce modules natively.

## Archive types

The module system defines the following archive types:

- *module archives* contain the compiled code and are packaged in a `.car` 
  file using the ZIP file format.
- *source archives* contain the source code and are packaged in a `.src` 
  file using the ZIP file format.
- *documentation archives* contain the HTML-format API documentation in a 
  `module-doc` folder.

Finally, legacy Java archives contain compiled Java code and are packaged 
in a `.jar` file using the ZIP file format just as they are for Java. They 
are used instead of the corresponding `.car` archive (you can have on or the 
other, but not both).

A legacy archive needs to follow the same naming rules and folder structure
as defined for `.car` archives (see below). Furthermore, if the legacy archive 
has dependencies on other modules [they must be specified][legacy modules] 
using a `modules.xml` or `module.properties` file.

[legacy modules]: ../structure/module#legacy_modules

## Repository structure

Ceylon module repositories are organized according to the following structure,
for a module `com.foo.bar` with versions `0.1` and `1.0` as an example:

<!-- lang: none -->
    root/
        com/
            foo/
                bar/
                    1.0/
                        com.foo.bar-1.0.car      -- Ceylon module archive
                        com.foo.bar-1.0.car.sha1 -- Checksum file
                        com.foo.bar-1.0.src      -- Ceylon source archive
                        com.foo.bar-1.0.src.sha1 -- Checksum file
                        module-doc/              -- API documentation 
                            index.html           -- Index page
                            [...]                -- API documentation files
        com/
            foo/
                bar/
                    0.1/
                        com.foo.bar-0.1.jar      -- Java legacy archive
                        module.properties        -- Dependencies for legacy archive

## Supported repository types

The Ceylon tools support the following repository types:

- File system repositories
- HTTP repositories (read-only)
- WebDAV repositories (for reading and publishing)
- [Maven repositories](maven) 
- The `npm` repository
- [Flat repositories][] &mdash; when integrating Ceylon in a foreign module 
  runtime programmatically

You can specify the user name and password to use for WebDAV publishing in the 
[tools](../#tools).

[Flat repositories]: ../interoperability/ceylon-on-jvm#flat_repositories

## Standard repositories

The Ceylon tools use a number of standard repositories and support command line 
arguments to add references to your own. All of that is explained in detail on 
the section on [dealing with repositories on the command line](tools).

If you want to know more about how the Ceylon configuration file can be used to 
change the default behavior of the tools when looking up modules in repositories 
you can read the section on [tool configuration](../tool/config).

## Legacy repositories

Ceylon also integrates with other [legacy repositories](maven) such as Maven.

## Dependency overrides

You can [override dependencies](./overrides) for Maven or Ceylon modules.
