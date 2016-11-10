---
layout: reference13
title_md: '`static` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `static` annotation marks a class member as being static, that is
accessible via the class itself and not requiring an instance to access.

## Usage

The annotation is applied to the member definition. `static` members must be 
declared before the first initializer statement, which means that only classes with
constructors can have `static` members.

<!-- try: -->
    class StaticExample {
        shared static String greeting = "Hello";
        shared static void greet(String name) {
            print("``greeting`` name");
        }
        shared new () {}
    }

The annotation can be applied to attributes, methods, member types and aliases of 
toplevel classes.

## Description

A `static` member is one that conceptually belongs to the class itself, and consequently 
does not need an instance of the class in order to access the member. 

Unlike in Java, type parameters of the containing class are in scope of `static` members:

    class GenericStatic<Element> {
        shared static GenericStatic<Element> factory(Element element) {
            // ...
        }
        new create() {
        }
    }

## See also

* API documentation for [`static`](#{site.urls.apidoc_1_3}/index.html#static)
* Reference for [annotations in general](../../structure/annotation/)

