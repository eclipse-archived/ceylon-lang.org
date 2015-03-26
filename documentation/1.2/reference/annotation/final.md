---
layout: reference12
title_md: '`final` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `final` annotation marks a class as not having subclasses.

## Usage

<!-- try: -->
    final class Example() {
    }

## Description

### Advice

Apart from annotation classes, most classes are not typically 
annotated `final`. The semantics of the `formal`, `default` and 
`actual` annotations are intended so that the author of a class 
or interface decides which members may be refined. It shouldn't 
be possible for it to be broken by a subclasses, because the 
subclass can only refine those members it is explicitly permitted 
to refine.

However, the `final` annotation is occasionally useful to allow
the compiler to detect that two types are 
[_disjoint_](#{site.urls.spec_current}#disjointtypes).

## See also

* API documentation for [`final`](#{site.urls.apidoc_1_1}/index.html#final)
* Reference for [annotations in general](../../structure/annotation/)
* [Disjoint types](#{site.urls.spec_current}#disjointtypes) in the 
  Ceylon language spec

