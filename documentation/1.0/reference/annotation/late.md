---
layout: reference
title: '`late` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `late` annotation prevents the typechecker from performing 
[definite specification](../../statement/specification) checks on a 
[simple value](../../structure/value#simple_values).

## Usage

<!-- try: -->
    class Child() {
        shared late Parent parent;
    }
    class Parent(children) {
        shared Child* children;
        for (child in children) {
            child.parent = this;
        }
    }

## Description

Using the `late` annotation on a simple value prevents the typechecked from
performing definite specification checks. 
Instead code is generated 
which performs a runtime check for accessing the value when it hasn't 
been initialized (and re-initializing a
non-`variable` value that has already been initialized). 

This is intended to permit cyclic references between values

Only simple values may be annotated `late` 
(it doesn't make sense for [value getters](../../structure/value#getters). 

## See also

* [`late`](#{site.urls.apidoc_current}/index.html#late)
* Reference for [annotations in general](../../structure/annotation/)

