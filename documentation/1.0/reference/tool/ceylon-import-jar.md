---
layout: reference
title: `ceylon-import-jar` - The Ceylon JAR importer
tab: documentation
unique_id: docspage
author: Stef Epardaud
milestone: Milestone 3
doc_root: ../../..
---

# #{page.title}

## Usage 

<!-- lang: none -->
    ceylon-import-jar [options] <module-spec> <jar-file>

Options include:

* `-out` Specifies the output module repository (which must be publishable).
* `-user` User name for output module repository (only if HTTP).
* `-pass` Password for output module repository (only if HTTP).
* `-d` Disable the default module repositories and source directory. <!-- m4 -->
* `-help` Prints a usage help page
* `-version` Prints the Ceylon version
* `-debug` Prints debug output

## Description

The JAR importer allows you to import a Java JAR into a Ceylon repository, so
that you can import this JAR in your Ceylon modules as if it were a normal
Ceylon module.  

## See also

* [`ceylon-import-jar`](#{page.doc_root}/#{site.urls.spec_relative}#jarimporter) in the language specification
* [module names and versions](#{page.doc_root}/#{site.urls.spec_relative}#modulenamesandversionidentifiers) in the language specification.
* [Module repositories](../../repository)