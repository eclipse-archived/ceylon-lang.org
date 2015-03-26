---
layout: reference12
title_md: '`sealed` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `sealed` annotation prevents certain kinds of use of the 
declaration outside the module containing the declaration.

A `sealed` interface cannot by satisfied by a class or interface 
outside the module in which it is defined.

A `sealed` class cannot be extended or instantiated 
outside the module in which it is defined.

## Usage

On a declaration:

<!-- try: -->
    shared sealed class SealedClass() {
    }
    shared sealed interface SealedInterface {
    }


## Description

The sealed annotation allowed the program author the means to provide 
client modules with access to sealed class and interface types 
without losing control over their subtypes or instances.

## See also

* API documentation for [`sealed`](#{site.urls.apidoc_1_1}/index.html#sealed)
* Reference for [annotations in general](../../structure/annotation/)
* [Sealed classes](#{site.urls.spec_current}#abstractandformalclasses) in the Ceylon 
  language spec
* [Sealed interfaces](#{site.urls.spec_current}#sealedinterfaces) in the Ceylon 
  language spec
