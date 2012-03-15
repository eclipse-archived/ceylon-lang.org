---
layout: reference
title: `ceylonr` - The ceylon repository replicator
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 3
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylonr [options] <module-names>...

Options include:

* `-out` Specifies the output module repository (which must be publishable).
* `-rep` specifies a module repository containing dependencies. XXX can be repeated?
* `-d` Disable the default module repositories and source directory.
* `-nosrc` Disables replication of source archives.
* `-nodoc` Disables replication of module documentation directories.

## Description

The repository replicator copies modules from one repository to another. 
For example, it may be used to create local copies of modules in remote 
repositories, or to publish modules to a remote repository.

## See also

* [`ceylonr`](#{page.doc_root}/#{site.urls.spec_relative}#therepositoryreplicator) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.

