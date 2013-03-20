---
layout: reference
title: Annotations
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 6
doc_root: ../../..
---

# #{page.title}

An annotation encodes metadata about a [program element](#program_elements).

## Usage 

Some example annotation declarations:

<!-- check:none -->
    shared Deprecated deprecated() {
        return Deprecated();
    }
    shared Description doc(String description) {
        return Description(description.normalized);
    }
    shared Authors by(String... authors) {
        return Authors { for (name in authors) name.normalized };
    }

## Description

### Types of annotation

An annotation is a 
[toplevel](../type#top_level_declarations) 
[method](../method) 
that returns a subtype of 
[`ConstrainedAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_ConstrainedAnnotation.html).
`ConstrainedAnnotation` has enumerated subtypes:

* [`OptionalAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_OptionalAnnotation.html) 
  for annotations which occur at most once on a given program element.
* [`SequencedAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_SequencedAnnotation.html)
  which can occur more than once on a given program element.

### Program elements

An annotation may constrain the program elements where it is allowed to 
be used to any of the types satisfying 
[`Annotated`](#{site.urls.apidoc_current}/metamodel/interface_Annotated.html) in the 
[metamodel](#{site.urls.apidoc_current}/metamodel).

### Language module annotations

* [`abstract`](#{site.urls.apidoc_current}/#abstract)
* [`actual`](#{site.urls.apidoc_current}/#actual)
* [`default`](#{site.urls.apidoc_current}/#default)
* [`deprecated`](#{site.urls.apidoc_current}/#deprecated)
* [`doc`](#{site.urls.apidoc_current}/#doc)
* [`by`](#{site.urls.apidoc_current}/#by)
* [`formal`](#{site.urls.apidoc_current}/#formal)
* [`final`](#{site.urls.apidoc_current}/#final)
* [`late`](#{site.urls.apidoc_current}/#late)
* [`license`](#{site.urls.apidoc_current}/#license)
* [`native`](#{site.urls.apidoc_current}/#native)
* [`optional`](#{site.urls.apidoc_current}/#optional)
* [`see`](#{site.urls.apidoc_current}/#see)
* [`shared`](#{site.urls.apidoc_current}/#shared)
* [`throws`](#{site.urls.apidoc_current}/#throws)
* [`tagged`](#{site.urls.apidoc_current}/#tagged)
* [`variable`](#{site.urls.apidoc_current}/#variable)

## See also

* [Annotations](../../../tour/annotations) on the Tour of Ceylon
* [Keywords](../keyword)

