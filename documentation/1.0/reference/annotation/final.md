---
layout: reference
title: '`final` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `final` annotation marks a class as not allowing subclasses

## Usage

<!-- try -->
    final class Example() {
    }

## Description

### Advice

Apart from annotation classes, 'normal' classes should not 
need to be annotated `final`. 
The semantics of the `formal`, `default` and `actual` annotations
are intended so that the author of a class or interface decides 
which members may be refined. It shouldn't be possible for 
it to be broken by a subclasses, because the subclass can only 
refine those members it is permitted to refine.

## See also

* [`final`](#{site.urls.apidoc_current}/#final)

