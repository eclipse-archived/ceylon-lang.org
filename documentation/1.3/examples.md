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

Furthermore:

- The [Ceylon Services Example](http://try.ceylon-lang.org/?gist=796bc92790af4cd3db54a88853518c56)
  demonstrates the use of Ceylon service providers, an 
  abstraction of the Java service loader facility, on the 
  JavaScript platform.

## Examples of server-side Ceylon

Ceylon is a fantastic language for writing microservices:

- [Wildfly Swarm and Ceylon][] demonstrates the use of Ceylon 
  to write a Java EE-based microservice and of the `ceylon swarm` 
  command to package it as a "fat" jar.

[Wildfly Swarm and Ceylon]: https://github.com/DiegoCoronel/ceylon-jboss-swarm/

## Examples of full-stack applications

- The [Ceylon Web IDE][] is a great example of how to build a 
  modern web application using Ceylon, making use of Ceylon's 
  HTTP and JSON APIs, and interoperation with native Java 
  libraries. The example even supports deployment to 
  the [OpenShift][] cloud platform.
- The Ceylon [DDDSample][] demonstrates the use of Ceylon in 
  Java EE.

[Ceylon Web IDE]: https://github.com/ceylon/ceylon-web-ide-backend
[OpenShift]: https://openshift.redhat.com/
[DDDSample]: https://github.com/sgalles/ceylon-dddsample 

## Simple examples

Learn how to use Ceylon with these Java frameworks:

- For Java-style dependency injection, check out 
  [Weld and Guice with Ceylon][], based on 
  [this blog post](/blog/2015/12/01/weld-guice/).

[Weld and Guice with Ceylon]: https://github.com/ceylon/ceylon-examples-di

## Examples of libraries

The [Ceylon SDK](https://github.com/ceylon/ceylon-sdk) includes 
plenty of good examples of Ceylon code, including:

- [`ceylon.collection`][] demonstrates some very typical usage 
  of generics.
- [`ceylon.file`][] demonstrates the use of enumerated types 
  and shows how to wrap a native Java API.
- [`ceylon.regex`][]
  is a cross-platform module that demonstrates the use of 
  `native` declarations and `dynamic` blocks.
- [`ceylon.locale`][] is a cross-platform module that 
  demonstrates the use of resource loading.
- [`ceylon.test`][] demonstrates some very typical usage of 
  the metamodel.
- [`ceylon.promise`][] demonstrates advanced use of abstraction 
  over function types.
- [`ceylon.json`][] illustrates a 
  [rather cool use of union types][ceylon.json::Value].

[`ceylon.collection`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/collection
[`ceylon.file`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/file
[`ceylon.regex`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/regex
[`ceylon.locale`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/locale
[`ceylon.test`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/test
[`ceylon.promise`]: https://github.com/ceylon/ceylon-sdk/tree/master/source/ceylon/promise
[`ceylon.json`]: https://github.com/ceylon/ceylon-sdk/blob/master/source/ceylon/json/
[ceylon.json::Value]: https://github.com/ceylon/ceylon-sdk/blob/master/source/ceylon/json/Value.ceylon

## Example `ceylon` plugins

A plugin for the `ceylon` command is a great way to improve
your productivity.

- [`ceylon swarm`][] is a super-simple plugin that just wraps an
  existing Java library.
- [`ceylon format`][] is much more elaborate.

[`ceylon swarm`]: https://github.com/ceylon/ceylon.swarm
[`ceylon format`]: https://github.com/ceylon/ceylon.formatter

## Examples of real life warts-'n-all production code

The [Ceylon IDE Common][] and [Ceylon IDE for IntelliJ][] 
projects sure aren't beautiful polished example code, but they 
do show how cleanly Ceylon interoperates with hairy, real-world, 
legacy Java APIs.

[Ceylon IDE Common]: https://github.com/ceylon/ceylon-ide-common
[Ceylon IDE for IntelliJ]: https://github.com/ceylon/ceylon-ide-intellij

The [Ceylon plugin for VS Code][] exhibits a whole completely
different approach to implementing tooling in Ceylon.

[Ceylon plugin for VS Code]: https://github.com/jvasileff/vscode-ceylon

The [Ceylon Dart][] project shows that it's possible to write a 
whole backend for the Ceylon compiler in Ceylon:

[Ceylon Dart]: https://github.com/jvasileff/ceylon-dart 
