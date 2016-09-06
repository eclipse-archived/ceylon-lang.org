---
layout: reference13
title_md: Module repositories
tab: documentation
unique_id: docspage
author: Stéphane Épardaud
doc_root: ../..
---

# #{page.title_md}

Ceylon supports modules natively. Ceylon Modules contain the following:

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

Ceylon module archives contain the compiled code and are packaged in a `.car`
file using the ZIP file format.

Ceylon source archives contain the source code and are packaged in a `.src`
file using the ZIP file format.

Ceylon API documentation archives contain the API documentation in a `module-doc`
folder, which holds HTML documentation.

Legacy Java archives contain the compiled code and are packaged in a `.jar`
file using the ZIP file format just as they are for Java. They are used instead
of the corresponding `.car` archive (you can have on or the other, not both).
A legacy archive needs to follow the same naming rules and folder structure
as defined for `.car` archives (see below). Also if the legacy archive has
dependencies on other modules [they can be defined](../structure/module#legacy_modules)
using a `modules.xml` or `module.properties` file or other external files.

## Repository structure

Ceylon module repositories are organised using the following structure
(using a module `com.foo.bar` of versions `0.1` and `1.0` as example):

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

At the moment, the Ceylon tools are able to use the following repository types:

- File system repository
- HTTP repository (for reading)
- WebDAV repository (for reading and publishing). You can specify the user name 
  and password to use for WebDAV publishing in the [tools](../#tools)
- A [_flat_ repository](../interoperability/ceylon-on-jvm#flat_repositories) for interop
- [Legacy repositories](maven) (Maven…)

## Standard repositories

The Ceylon tools use a number of standard repositories and support command line arguments
to add references to your own. All of that is explained in detail on the section on
[Dealing with repositories on the command line](tools).

If you want to know more about how the Ceylon configuration file can be used to change the
default behavior of the tools when looking up modules in repositories you can read the
section on [tool configuration](../tool/config).

## Legacy repositories

Ceylon also integrates with other [legacy repositories](maven) such as Maven.

## Dependency overrides

You can [override dependencies](./overrides) for Maven or Ceylon modules.
