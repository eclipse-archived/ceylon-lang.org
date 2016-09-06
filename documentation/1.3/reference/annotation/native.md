---
layout: reference13
title_md: '`native` annotation'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `native` annotation marks a declaration that is either not implemented
in the Ceylon programming language, it is implemented only for a specific
"backend" or it might be implemented in different ways for different backends.

## Usage

In case of an external implementation in a different language an example
might be a simple as the following:

<!-- try: -->
     native shared class Example() {
     }

While a more complex example of different implementations for different
backends might look something like this:

<!-- try: -->
     native shared class Example() {
        native shared String time();
     }

     native("jvm") shared class Example() {
        native("jvm") shared String time() {
            return Date().string;
        }
     }

     native("js") shared class Example() {
        native("js") shared String time() {
            dynamic {
                return Date().toString();
            }
        }
     }

## Description

The native annotation is used to mark code that is either implemented
using the native code for each of the supported backend, meaning it's
implemented in Java for the JVM backend or in JavaScript for the
JavaScript backend, or it's code written in Ceylon but only for
a specific backend so it can use features specific to that backend.

## See also

* [How to use native annotations](../../interoperability/native)
* [`native`](#{site.urls.apidoc_1_3}/index.html#native) documentation
* Reference for [annotations in general](../../structure/annotation/)

