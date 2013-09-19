---
layout: reference
title: '`annotation` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `annotation` annotation marks a class as being an 
[annotation class](../../structure/annotation/#annotation_class), 
or a function as being an 
[annotation constructor](../../structure/annotation/#annotation_constructor).

## Usage

The annotation is applied to the class defintion:

<!-- try: -->
    final annotation class Example() 
            satisfies OptionalAnnotation<Example, ClassDecaration>

Or to the function definition:

<!-- try: -->
    annotation class Example example() 
        => Example()

## Description

When applied to a class, the `final` annotation is also required and the class 
must satisfy [`Annotation`](#{site.urls.apidoc_current}/Annotation.type.html)

## See also

* API documentation for [`annotation`](#{site.urls.apidoc_current}/index.html#annotation)
* Reference for [annotations in general](../../structure/annotation/)

