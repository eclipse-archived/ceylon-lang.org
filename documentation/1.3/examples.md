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

- The [Ceylon Services Example][] demonstrates the use of 
  Ceylon service providers, an abstraction of the Java 
  service loader facility, on the JavaScript platform.

[Ceylon Services Example]: http://try.ceylon-lang.org/?gist=796bc92790af4cd3db54a88853518c56

## Examples of Ceylon on mobile platforms

[This example project][DisplayingBitmaps] shows how to use
Ceylon to create an Android application in Android Studio.
It uses the [Ceylon Gradle plugin for Android][] to integrate
with the Android toolchain.

The [Universal Media Player][] is a much more elaborate sample,
but depends on Ceylon 1.3.3, which is not yet released. The
process of developing the example application is discussed in 
[this presentation][Android presentation].

[DisplayingBitmaps]: https://github.com/gavinking/DisplayingBitmaps
[Universal Media Player]: https://github.com/gavinking/UniversalMusicPlayer
[Ceylon Gradle plugin for Android]: https://github.com/ceylon/ceylon-gradle-android
[Android presentation]: /community/presentations/ceylon-on-android.pdf

## Examples of server-side Ceylon

Ceylon is a fantastic language for writing microservices:

- [Wildfly Swarm and Ceylon][] demonstrates the use of Ceylon 
  to write a Java EE-based microservice for [Swarm][], using
  JPA, CDI, and JAX-RS, and of the `ceylon swarm` command to 
  package it as a "fat" jar. Alternatively, you can use 
  `ceylon war` to package it as a web archive and run it on a 
  Java EE application server! The technologies demonstrated
  here are discussed in [this presentation][Swarm presentation].
- [Spring Boot and Ceylon][] demonstrates the use of Ceylon
  with [Spring Boot][] and Spring Data.
- The [Vert.x examples][] include several samples showing how
  to use Ceylon in [Vert.x][]. 
- [Spark with Ceylon][] demonstrates how to use the Spark web
  framework in Ceylon.
- [Jooby with Ceylon][] contains a very simple example of the
  Jooby web framework.
- The [gyokuro demos][] show off the [gyokuro][] web 
  framework, which is written in Ceylon.

Documentation for Ceylon and Vert.x can be found at the 
[Vert.x site](http://vertx.io/docs/vertx-core/ceylon/).

[Wildfly Swarm and Ceylon]: https://github.com/DiegoCoronel/ceylon-jboss-swarm/
[Spring Boot and Ceylon]: https://github.com/DiegoCoronel/ceylon-spring-boot
[Vert.x examples]: https://github.com/vert-x3/vertx-examples/tree/master/ceylon
[Swarm]: http://wildfly-swarm.io/
[Vert.x]: http://vertx.io/
[Spring Boot]: https://projects.spring.io/spring-boot/
[Spark with Ceylon]: https://github.com/ceylon/ceylon-examples-spark
[Jooby with Ceylon]: https://github.com/ceylon/ceylon-examples-jooby
[gyokuro demos]: https://github.com/bjansen/gyokuro/tree/master/demos/gyokuro/demo
[gyokuro]: http://bjansen.github.io/gyokuro/
[Swarm presentation]: /community/presentations/ceylon-swarm.pdf

## Examples of full-stack applications

- The [Ceylon Web IDE][] is a great example of how to build a 
  modern web application using Ceylon, making use of Ceylon's 
  HTTP and JSON APIs, and interoperation with native Java 
  libraries. The example even supports deployment to 
  the [OpenShift][] cloud platform.
- The Ceylon [DDDSample][] demonstrates the use of Ceylon to 
  write a complete Java EE application, making use of JPA, 
  CDI, EJB, JAX-RS, JMS, JSF, and Facelets.

[Ceylon Web IDE]: https://github.com/ceylon/ceylon-web-ide-backend
[OpenShift]: https://openshift.redhat.com/
[DDDSample]: https://github.com/sgalles/ceylon-dddsample 

## Simple examples

Learn how to use Ceylon with these Java frameworks:

- [JDK Collections and Streams in Ceylon][] shows how easy
  and natural it is to use Java's collections and streams
  APIs directly from Ceylon.
- [Java Persistence in Ceylon][] demonstrates the use of JPA
  for Object/Relational Mapping.
- For Java-style dependency injection, check out 
  [Weld and Guice with Ceylon][], based on 
  [this blog post](/blog/2015/12/01/weld-guice/).
- The [JavaFX Samples for Ceylon][] show how to write a 
  JavaFX UI in Ceylon. 
- The [RxJava examples][] project is a port of the basic
  [RxJava][] examples from the [RxJava documentation][] to 
  Ceylon.
- [OpenGL in Ceylon][] shows the use of [JOGL][] in a Swing 
  application.
- This [IntelliJ UI designer example][] shows how to use
  IntelliJ IDEA's [GUI Designer][].
- The [jOOQ Ceylon example][] demonstrates the use of the 
  jOOQ library, as documented in [this blog post][jOOQ blog].

[JDK Collections and Streams in Ceylon]: https://github.com/ceylon/ceylon-examples-jdk
[Java Persistence in Ceylon]: https://github.com/ceylon/ceylon-examples-jpa
[Weld and Guice with Ceylon]: https://github.com/ceylon/ceylon-examples-di
[OpenGL in Ceylon]: https://github.com/ceylon/ceylon-examples-jogl
[GUI Designer]: https://www.jetbrains.com/help/idea/2016.2/gui-designer-reference.html
[IntelliJ UI designer example]: https://github.com/xkr47/ceylon-swing-with-intellij-ui-designer
[JavaFX Samples for Ceylon]: https://github.com/ceylon/ceylon-examples-javafx
[RxJava examples]: https://github.com/ceylon/ceylon-examples-rx
[RxJava]: https://github.com/ReactiveX/RxJava
[RxJava documentation]: https://github.com/ReactiveX/RxJava/wiki/How-To-Use-RxJava
[JOGL]: http://jogamp.org/
[jOOQ Ceylon example]: https://github.com/bjansen/ceylon-jooq-example
[jOOQ blog]: http://bjansen.github.io/ceylon/2015/08/24/ceylon-plus-jooq-equals-heart.html

## OSGi examples

The [Ceylon OSGi examples][] demonstrate how to use Ceylon
modules as OSGi bundles, and how to:

- run the Ceylon [HTTP server][] inside an OSGi container,
- call standard OSGi services,
- integrate with [Pax Web][] in order to produce a web 
  application packaged as a single Ceylon module, or
- write an Eclipse plugin.

[Ceylon OSGi examples]: https://github.com/davidfestal/Ceylon-Osgi-Examples
[HTTP server]: https://herd.ceylon-lang.org/modules/ceylon.http.server
[Pax Web]: https://ops4j1.jira.com/wiki/display/paxweb/Pax+Web

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
whole backend for the Ceylon compiler in Ceylon.

[Ceylon Dart]: https://github.com/jvasileff/ceylon-dart 
