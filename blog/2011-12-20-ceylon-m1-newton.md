---
title: First official release of Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M1]
---

[M1]: /documentation/roadmap/#milestone_1?utm_source=blog&utm_medium=web&utm_content=roadmap_m1&utm_campaign=1_0_M1release
[M2]: /documentation/roadmap/#milestone_2?utm_source=blog&utm_medium=web&utm_content=roadmap_m2&utm_campaign=1_0_M1release
[spec]: /documentation/spec?utm_source=blog&utm_medium=web&utm_content=spec&utm_campaign=1_0_M1release

Today, we're proud to announce the release of Ceylon M1 "Newton". 
This is the first official release of the Ceylon command line
compiler, documentation compiler, language module, and runtime, 
and a [major step down the roadmap][M1] toward Ceylon 1.0.

You can get it here:

[http://ceylon-lang.org/download](http://ceylon-lang.org/download?utm_source=blog&utm_medium=web&utm_content=download&utm_campaign=1_0_M1release)

We plan a compatible M1 release of 
[Ceylon IDE](/documentation/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=1_0_M1release)
later this week.

### Language features

In terms of the language itself, M1 has essentially all the features 
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

Support for the following language features is not yet available:

* first-class and higher-order functions
* comprehensions
* algebraic types, enumerated types, and `switch/case`
* mixin inheritance
* member class refinement
* reified generics
* user-defined annotations and the type safe metamodel

Furthermore, numeric operators are not currently optimized by the
compiler, so numeric code is expected to perform poorly.

[This page](/documentation/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=1_0_M1release) 
provides a quick 
introduction to the language. [The draft language specification][spec]
is the complete definition.

### Modularity and runtime

Ceylon modules may be executed on any standard JVM. The toolset and 
runtime for Ceylon is based around `.car` module archives and module 
repositories. The runtime supports a modular, peer-to-peer class 
loading architecture, with full support for module versioning and 
multiple repositories. 

This release of Ceylon includes support for local module repositories. 
Support for remote repositories and the shared community repository 
`modules.ceylon-lang.org` will be available in the [next release][M2].

Chapter 7 of [the language specification][spec] contains much more
information about the Ceylon module system and command line tools.

### SDK

At this time, the only module available is the language module 
`ceylon.language`, included in the distribution.

### Java interoperability

There are a number of issues that currently affect interoperability 
with Java. These issues are a top priority for the [next release][M2].

### Source code

The source code for Ceylon, its specification, and its website, is 
freely available from GitHub:

<https://github.com/ceylon>

### Issues

Bugs and suggestions may be reported in GitHub's issue tracker.

### Community

The Ceylon community site includes 
[documentation](/documentation?utm_source=blog&utm_medium=web&utm_content=documentation&utm_campaign=1_0_M1release), 
the 
[current draft of the language specification][spec], 
the [roadmap](/documentation/roadmap?utm_source=blog&utm_medium=web&utm_content=roadmap&utm_campaign=1_0_M1release) 
and information about [getting involved](/code?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=1_0_M1release).

<http://ceylon-lang.org>

### Acknowledgement

We're deeply indebted to the community volunteers who contributed a 
substantial part of the current Ceylon codebase, working in their own 
spare time. The following people have contributed to this release:

*Stephane Epardaud, Tako Schotanus, Gary Benson, Emmanuel Bernard, 
Andrew Haley, Tom Bentley, Ales Justin, David Festal, Flavio Oliveri, 
Sergej Koshchejev, Max Rydahl Andersen, Mladen Turk, James Cobb, 
Ben Keating, Michael Brackx, Ross Tate, Ivo Kasiuk, Gertjan Assies*
