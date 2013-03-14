---
title: Ceylon M4 and Ceylon IDE M4 released!
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M4]
---

[M4]: /documentation/1.0/roadmap/?utm_source=blog&utm_medium=web&utm_content=roadmap_m4&utm_campaign=latestrelease#milestone_4_done
[Ceylon Herd]: http://modules.ceylon-lang.org?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease
[Ceylon IDE]: /documentation/1.0/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease
[Eclipse update site]: /documentation/1.0/ide/install?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease

Ceylon M4 "Analytical Engine" is now available for download, along with a 
simultaneous compatible release of [Ceylon IDE][]. The compiler now 
implements almost all of the language specification, for both Java and 
JavaScript virtual machines as execution environments. New Ceylon platform 
modules are available in [Ceylon Herd][], the community module repository. 

You can download the Ceylon command line distribution here:

[http://ceylon-lang.org/download](http://ceylon-lang.org/download?utm_source=blog&utm_medium=web&utm_content=download&utm_campaign=latestrelease)

Or you can install Ceylon IDE from Eclipse Marketplace or from our 
[Eclipse update site].

Ceylon M4 and Ceylon IDE M4 require Java 7.

The Ceylon team hopes to release Ceylon 1.0 beta in January.

### Language features

M4 is an almost-complete implementation of the Ceylon language,
including the following new features compared to M3:

* [member class refinement](/documentation/1.0/reference/structure/class/#member_class_refinement) (type families)
* [class and interface aliases](/documentation/1.0/reference/structure/class/#aliases)
* [union and intersection aliases](/documentation/1.0/reference/structure/type/#type_aliases)
* [new syntax for package and module descriptors](/documentation/1.0/reference/structure/module/#descriptor)
* [assertions](/documentation/1.0/reference/statement/assert/)
* [condition lists](/documentation/1.0/reference/statement/conditions/#condition_lists)
* support for calling super-interface implementations of refined members
* [maven repositories](/documentation/1.0/reference/repository/#legacy_repositories)
* [pluggable command-line tools, git-style](/documentation/1.0/reference/tool/ceylon/)
* [better support for optional types in Java](/documentation/1.0/reference/interoperability/java-from-ceylon/#calling_java_code_with_unsafe_nulls_milestone_4)
* [JDK/Jigsaw modules](/documentation/1.0/reference/interoperability/java-from-ceylon/#importing_jdk_modules_milestone_4)
* [all-new API doc redesign](#{site.urls.apidoc_current}/ceylon/language/0.5/module-doc/)
* more than 300 features and bug fixes

The following language features are not yet supported in M4:

* reified generics
* user-defined annotations, interceptors, and the type safe metamodel
* serialization

[This page](/documentation/1.0/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease) 
provides a quick introduction to the language. [The draft language specification](/documentation/1.0/spec/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease)
is the complete definition.

### Ceylon IDE

[Ceylon IDE][] is a complete development environment for Ceylon, based 
on the Eclipse platform. This release of Ceylon IDE introduces:

* support for JavaScript compilation and execution,
* module import completion,
* the brand new Ceylon Repository Explorer view,
* support for Maven repositories, and
* more than 30 other improvements and bug fixes.

Ceylon IDE M4 requires Java 7. Users of Ceylon IDE on Mac OS should 
install [Eclipse Juno](http://eclipse.org/juno/). Users on other 
platforms may run Ceylon IDE in either Eclipse Indigo or Eclipse Juno 
on Java 7. _Ceylon IDE will not work if Eclipse is run on Java 6._

### Compilation and execution on the JVM and JavaScript VMs

The Ceylon command-line tools and IDE both support compilation to
either or both of the JVM or JavaScript.

Ceylon programs compiled to JavaScript execute on standard JavaScript 
virtual machines. The Ceylon command line distribution and IDE include 
a launcher for running Ceylon programs on Node.js.

### Interoperation with Java

Interoperation with Java code is robust and well-tested. As usual, 
this release fixes several bugs that affected Java interoperation in 
the previous release.

Contrary to previous releases, the JDK is no longer automatically
imported, so you need to import the JDK using the modularised JDK
module names as defined by Jigsaw (Java 9).

### Platform modules

The following new platform modules are now available in [Ceylon Herd][]:

* `ceylon.net` provides URI and HTTP support
* `ceylon.io` provides charset and socket (blocking and non-blocking) support
* `ceylon.json` provides JSON parsing and serialization
* `ceylon.collection` collection implementations organized into mutable array-based 
  collections, mutable hashtable-based collections and immutable linked-list based 
  collections

The language module, `ceylon.language` is included in the distribution.

### Modularity and runtime

The toolset and runtime for Ceylon are based around `.car` module 
archives and module repositories. The runtime supports a modular, 
peer-to-peer class loading architecture, with full support for module 
versioning and multiple repositories, including support for local and 
remote module repositories, using the local file system, HTTP, WebDAV,
or even Maven repositories for interoperation with Java.

The shared community repository, Ceylon Herd is now online:

<http://modules.ceylon-lang.org>

### Source code

The source code for Ceylon, its specification, and its website, is 
freely available from GitHub:

<https://github.com/ceylon>

### Issues

Bugs and suggestions may be reported in GitHub's issue tracker.

### Community

The Ceylon community site includes 
[documentation](/documentation/1.0/?utm_source=blog&utm_medium=web&utm_content=documentation&utm_campaign=latestrelease), 
the [current draft of the language specification](/documentation/1.0/spec/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease), 
the [roadmap](/documentation/1.0/roadmap?utm_source=blog&utm_medium=web&utm_content=roadmap&utm_campaign=latestrelease),
and information about [getting involved](/code?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=latestrelease).

<http://ceylon-lang.org>

### Acknowledgement

We're deeply indebted to the community volunteers who contributed a 
substantial part of the current Ceylon codebase, working in their own 
spare time. The following people have contributed to this release:

*Gavin King, Stéphane Épardaud, Tako Schotanus, Emmanuel Bernard, 
Tom Bentley, Aleš Justin, David Festal, Flavio Oliveri, 
Max Rydahl Andersen, Mladen Turk, James Cobb, Tomáš Hradec, 
Michael Brackx, Ross Tate, Ivo Kasiuk, Enrique Zamudio,
Julien Ponge, Julien Viet, Pete Muir, Nicolas Leroux, Brett Cannon, 
Geoffrey De Smet, Guillaume Lours, Gunnar Morling, Jeff Parsons, 
Jesse Sightler, Oleg Kulikov, Raimund Klein, Sergej Koščejev, 
Chris Marshall, Simon Thum, Maia Kozheva, Shelby, Aslak Knutsen, 
Fabien Meurisse, Paco Soberón, sjur, Xavier Coulon.*
