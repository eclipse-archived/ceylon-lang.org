---
title: Second official release of Ceylon
author: Stéphane Épardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M2]
---

[M1]: /documentation/1.0/roadmap/?utm_source=blog&utm_medium=web&utm_content=roadmap_m1&utm_campaign=1_0_M2release#milestone_1
[M2]: /documentation/1.0/roadmap/?utm_source=blog&utm_medium=web&utm_content=roadmap_m2&utm_campaign=1_0_M2release#milestone_2
[M3]: /documentation/1.0/roadmap/?utm_source=blog&utm_medium=web&utm_content=roadmap_m3&utm_campaign=1_0_M2release#milestone_3
[spec]: /documentation/1.0/spec?utm_source=blog&utm_medium=web&utm_content=spec&utm_campaign=1_0_M2release

Today, we're proud to announce the release of Ceylon M2 "Minitel". 
This is the second official release of the Ceylon command line
compiler, documentation compiler, language module, and runtime, 
and a [major step down the roadmap][M2] toward Ceylon 1.0, with
most of the Java interoperability fully specified and implemented. 

You can get it here:

[http://ceylon-lang.org/download](http://ceylon-lang.org/download?utm_source=blog&utm_medium=web&utm_content=download&utm_campaign=1_0_M2release)

We plan a compatible M2 release of 
[Ceylon IDE](/documentation/1.0/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=1_0_M2release)
later this week.

### Language features

In terms of the language itself, M2 has essentially all the features 
of Java except enumerated types, user-defined annotations, and 
reflection. It even incorporates a number of improvements over Java, 
including:

* JVM-level primitive types are ordinary classes in Ceylon
* type inference and type argument inference based on analysis of 
  principal types
* streamlined class definitions via elimination of getters, setters, 
  and constructors
* optional parameters with default values
* named arguments and the "object builder" syntax
* intersection types, union types, and the bottom type
* static typing of the `null` value and empty sequences
* declaration-site covariance and contravariance instead of wildcard 
  types
* more elegant syntax for type constraints
* top-level function and value declarations instead of `static` 
  members
* nested functions
* richer set of operators
* more elegant syntax for annotations
* immutability by default
* first-class and higher-order functions except anonymous functions
* method and attribute specifiers
* algebraic types, enumerated types, and `switch/case`

Support for the following language features is not yet available:

* anonymous functions
* multiple parameter lists
* comprehensions
* mixin inheritance
* member class refinement
* reified generics
* user-defined annotations and the type safe metamodel

[This page](/documentation/1.0/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=1_0_M2release) 
provides a quick 
introduction to the language. [The draft language specification][spec]
is the complete definition.

### Java interoperability

There were many improvements to Java interoperability in this release,
which makes it very easy to [call Java from Ceylon](/documentation/1.0/reference/interoperability/java-from-ceylon/).

Most of the interoperability issues with Java have been fixed, and
there are very few remaining issues that we will fix for the [next release][M3],
though they only concern corner-cases that we don't expect users to meet.

### Performance

We spent a lot of time improving performance for this release, in
particular arithmetic operator performance, but we still have a lot
of areas we expect to improve for the [next release][M3], such as
the speed of interoperability with Java arrays and improvements on
boxing.

### Modularity and runtime

Ceylon modules may be executed on any standard Java 6 compatible JVM. The toolset and 
runtime for Ceylon is based around `.car` module archives and module 
repositories. The runtime supports a modular, peer-to-peer class 
loading architecture, with full support for module versioning and 
multiple repositories. 

This release of Ceylon includes support for local and remote module 
repositories, using the local file system, HTTP or WebDAV. In order
to make it easy to use Java libraries from Ceylon you can even use
Maven repositories.

Support for the shared community repository 
`modules.ceylon-lang.org` will be available in the [next release][M3].

Chapter 7 of [the language specification][spec] contains much more
information about the Ceylon module system and command line tools.

### SDK

At this time, the only module available is the language module 
`ceylon.language`, included in the distribution.

### Source code

The source code for Ceylon, its specification, and its website, is 
freely available from GitHub:

<https://github.com/ceylon>

### Issues

Bugs and suggestions may be reported in GitHub's issue tracker.

### Community

The Ceylon community site includes 
[documentation](/documentation/1.0/?utm_source=blog&utm_medium=web&utm_content=documentation&utm_campaign=1_0_M2release), 
the 
[current draft of the language specification][spec], 
the [roadmap](/documentation/1.0/roadmap?utm_source=blog&utm_medium=web&utm_content=roadmap&utm_campaign=1_0_M2release) 
and information about [getting involved](/code?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=1_0_M2release).

<http://ceylon-lang.org>

### Acknowledgement

We're deeply indebted to the community volunteers who contributed a 
substantial part of the current Ceylon codebase, working in their own 
spare time. The following people have contributed to this release:

*Gavin King, Stéphane Épardaud, Tako Schotanus, Emmanuel Bernard, 
Tom Bentley, Aleš Justin, David Festal, Flavio Oliveri, 
Max Rydahl Andersen, Mladen Turk, James Cobb, Tomáš Hradec, 
Michael Brackx, Ross Tate, Ivo Kasiuk, Enrique Zamudio,
Julien Ponge, Julien Viet, Pete Muir, Nicolas Leroux.*
