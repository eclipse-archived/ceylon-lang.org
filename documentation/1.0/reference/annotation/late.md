---
layout: reference
title_md: '`late` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `late` annotation prevents the typechecker from performing 
[definite specification](../../statement/specification) checks on a 
[reference](../../structure/value#simple_values).

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

Using the `late` annotation on a reference prevents the typechecked 
from performing definite specification checks. Instead, code is 
generated which performs a runtime check and throws an exception if 
the reference:

- is accessed when it hasn't been initialized, or 
- is reinitialized and not annotated `variable`. 

This is intended to permit cyclic references between objects.

Only references may be annotated `late` (it doesn't make sense for 
[getters](../../structure/value#getters). 

## See also

* API documentation for [`late`](#{site.urls.apidoc_1_0}/index.html#late)
* Reference for [annotations in general](../../structure/annotation/)
