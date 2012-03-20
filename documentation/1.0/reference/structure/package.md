---
layout: reference
title: Packages
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

In Ceylon, a *package* is a collection of top-level declarations
contained in one or more 
[compilation units](../compilation-unit) together with an 
optional [package descriptor](#descriptor).

## Usage 

An simple example [package descriptor](#descriptor):

<!-- check:none -->
    Package package {
        name = 'com.example.foo.a';
        shared = true;
    }
    
Conventionally this would be in a source file located in
`<source-dir>/com/example/foo/a/package.ceylon` where `<source-dir>` is the
directory containing ceylon source code.

## Description

### Members

A package's members are the top-level declarations contained in its 
[compliation unit(s)](../compilation-unit).

### Descriptor

The 
[package descriptor](\#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Package.html) 
holds metadata about the package, including its name, 
package-level documentation and whether the package is visible outside the 
containing module. It is conventionally declared in a source file called
`package.ceylon`.

Note that the package descriptor makes use of 
[single quoted literals](../../literal/single-quoted) even though they are not 
generally supported in Ceylon 1.0.

## See also

* Packages are contained in [modules](../module)
* Packages contains [compilation units](../compilation-unit)
* ceylond documentation of the 
  [Package](\#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Package.html) 
  type (the type of the package descriptor)
