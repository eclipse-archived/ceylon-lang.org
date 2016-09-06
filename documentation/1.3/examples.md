---
layout: documentation13
title: Example programs and applications
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ..
---

# #{page.title}

We're collecting examples here.

## Examples of client-side Ceylon

We have three small demo application which illustrate the use
of Ceylon in a web browser:

- [Solar System Example](http://try.ceylon-lang.org/?gist=bd41b47f325b6d32514a)
- [Oscilloscope Example](http://try.ceylon-lang.org/?gist=4b2cfe43bfa7571e73e7)
- [Game of Life Example](http://try.ceylon-lang.org/?gist=8860a7a70fb92e306f1f)

## Examples of full-stack applications

- The [Ceylon Web IDE](https://github.com/ceylon/ceylon-web-ide-backend)
  is a great example of how to build a modern web application
  using Ceylon, making use of Ceylon's HTTP and JSON APIs, and 
  interoperation with native Java libraries. The example even
  supports deployment to [OpenShift](https://openshift.redhat.com/).
- The [DDDSample](https://github.com/sgalles/ceylon-dddsample) 
  demonstrates the use of Ceylon in Java EE.

## Simple examples

Learn how to use Ceylon with these Java frameworks:

- [Weld and Guice with Ceylon](https://github.com/ceylon/ceylon-examples-di),
  based on [this blog post](/blog/2015/12/01/weld-guice/).

## Examples of libraries

The [Ceylon SDK](https://github.com/ceylon/ceylon-sdk) includes 
plenty of good examples of Ceylon code, including:

- [`ceylon.collection`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/collection)
  demonstrates some very typical usage of generics.
- [`ceylon.file`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/file)
  demonstrates the use of enumerated types and shows how to 
  wrap a native Java API.
- [`ceylon.regex`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/regex)
  is a cross-platform module that demonstrates the use of 
  `native` declarations and `dynamic` blocks.
- [`ceylon.locale`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/locale)
  is a cross-platform module that demonstrates the use of 
  resource loading.
- [`ceylon.test`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/test)
  demonstrates some very typical usage of the metamodel.
- [`ceylon.promise`](https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/promise)
  demonstrates advanced use of abstraction over function 
  types.
- [`ceylon.json`](https://github.com/ceylon/ceylon-sdk/blob/master/source/ceylon/json/)
  illustrates a [rather cool use of union types](https://github.com/ceylon/ceylon-sdk/blob/master/source/ceylon/json/Value.ceylon).
  
