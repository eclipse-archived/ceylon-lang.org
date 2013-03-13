---
title: Ceylon M5 and Ceylon IDE M5 now available!
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M5]
---

[M5]: /documentation/1.0/roadmap/?utm_source=blog&utm_medium=web&utm_content=roadmap_m5&utm_campaign=latestrelease#milestone_5_done
[Ceylon Herd]: http://modules.ceylon-lang.org?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease
[Ceylon IDE]: /documentation/1.0/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease
[Eclipse update site]: /documentation/1.0/ide/install?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=latestrelease
[spec]: /documentation/1.0/spec/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease
[tour]: /documentation/1.0/tour/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease
[intro]: /documentation/1.0/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=latestrelease
[roadmap]: /documentation/1.0/roadmap?utm_source=blog&utm_medium=web&utm_content=roadmap&utm_campaign=latestrelease
[documentation]: /documentation/1.0/?utm_source=blog&utm_medium=web&utm_content=documentation&utm_campaign=latestrelease
[code]: /code?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=latestrelease

Ceylon M5 _&ldquo;Nesa Pong&rdquo;_ is now available for download, along with 
a simultaneous compatible release of Ceylon IDE. This is a huge 
release, with the following headline features:

- a fully-reified type system with generic type arguments 
  available at runtime,
- direct interoperation with native JavaScript,
- tuples,
- several important syntax changes in response to community 
  feedback and practical experience, and
- a datetime module and a HTTP server.

You can download the Ceylon command line distribution here:

[http://ceylon-lang.org/download](http://ceylon-lang.org/download?utm_source=blog&utm_medium=web&utm_content=download&utm_campaign=latestrelease)

Or you can install Ceylon IDE from our [Eclipse update site].

### Language features

M5 is an almost-complete implementation of the Ceylon language,
including the following new features compared to M4:

- [tuples](/documentation/1.0/tour/sequences/#tuples)
- direct interop with native JavaScript APIs via the new `dynamic` block
- [the `:` operator](/documentation/1.0/tour/attributes-control-structures/#for)
- [verbatim strings](/documentation/1.0/tour/basics/#verbatim_strings)
- [fat arrow](/documentation/1.0/tour/basics/#fat_arrows_and_forward_declaration) 
  `=>` abbreviation for defining single-expression functions
- [syntactic sugar for iterables](/documentation/1.0/tour/sequences/#iterables)
- more powerful [spread operator](/documentation/1.0/tour/functions/#the_spread_operator)
- [the `late` annotation](/documentation/1.0/tour/initialization/#circular_references)
- [binary and hexadecimal numeric literals](/documentation/1.0/tour/language-module/#numeric_literals)
- defaulted type parameters
- [reified generics](/documentation/1.0/tour/generics/#fully_reified_generic_types)
- _many_ miscellaneous minor improvements to the syntax and typing 
  rules of the language
- `ceylon.time` module
- `ceylon.net.http.server` package (a HTTP server)
- the `compose()` and `curry()` functions
- reworked interop with Java arrays
- more than 500 features and bug fixes

In addition, the [language specification][spec] and 
[documentation][tour] have been substantially revised and 
improved.

The following language features are not yet supported in M5:

* the type safe metamodel
* user-defined annotations 
* serialization

[This page][intro] provides a quick introduction to the language. 
[The draft language specification][spec] is the complete definition.

### Source code

The source code for Ceylon, its specification, and its website, is 
freely available from GitHub:

<https://github.com/ceylon>

### Issues

Bugs and suggestions may be reported in GitHub's 
[issue tracker](/code/issues).

### Community

The Ceylon community site includes [documentation][], the [current 
draft of the language specification][spec], the [roadmap][], and 
information about [getting involved][code].

<http://ceylon-lang.org>

### SDK

The new platform modules are available in the shared community 
repository, [Ceylon Herd][].

<http://modules.ceylon-lang.org>

### Acknowledgement

We're deeply indebted to the community volunteers who contributed a 
substantial part of the current Ceylon codebase, working in their own 
spare time. The following people have contributed to this release:

*Gavin King, Stéphane Épardaud, Tako Schotanus, Emmanuel Bernard, 
Tom Bentley, Aleš Justin, David Festal, Flavio Oliveri, 
Max Rydahl Andersen, Mladen Turk, James Cobb, Tomáš Hradec, 
Michael Brackx, Ross Tate, Ivo Kasiuk, Enrique Zamudio, Roland Tepp,
Diego Coronel, Brent Douglas, Corbin Uselton, Loic Rouchon,
Lukas Eder, Markus Rydh, Matej Lazar,
Julien Ponge, Julien Viet, Pete Muir, Nicolas Leroux, Brett Cannon, 
Geoffrey De Smet, Guillaume Lours, Gunnar Morling, Jeff Parsons, 
Jesse Sightler, Oleg Kulikov, Raimund Klein, Sergej Koščejev, 
Chris Marshall, Simon Thum, Maia Kozheva, Shelby, Aslak Knutsen, 
Fabien Meurisse, Paco Soberón, sjur, Xavier Coulon.*
