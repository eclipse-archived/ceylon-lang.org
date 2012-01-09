---
title: First official release of Ceylon IDE
author: David Festal
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M1, ide]
---

[ide_install]: /documentation/ide/install?utm_source=blog&utm_medium=web&utm_content=ide_install&utm_campaign=1_0_M1release
[ide]: /documentation/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=1_0_M1release
[newton]: /blog/2011/12/20/ceylon-m1-newton?utm_source=blog&utm_medium=web&utm_content=blog&utm_campaign=1_0_M1release

Today, we're proud to announce the first official release of the Ceylon M1 "Newton" IDE.

It is fully compatible with the already-released [Ceylon M1 "Newton" distribution][newton] which contains
the command line compiler, documentation compiler, language module, and runtime.

However it can also be used as a lightweight standalone Ceylon development tool, even if
the full Ceylon distribution is not already installed.

You can get it by [installing it][ide_install] from our Eclipse plugin update site ...
... and start playing with Ceylon thanks to the cheat sheets available in the Ceylon [Welcome page](/documentation/ide/screenshots#welcome_page).


### Main features

A full list of features with screenshots can be found [here][ide].

However among the features that have greatly enriched the IDE since its first pre-release versions,
the following can be considered as the most important :


* New wizards to create Ceylon projects, modules, packages, units : Start working directly on
  Ceylon-specific Eclipse resources.

* Cross-project dependencies and navigation : Add another Ceylon project on the build path, and all
  the dependencies are correctly managed.
  
* Enhanced Ceylon search facilities : For example, with 'Search Assignments', find all the places where a 
  variable is assigned a specific value.

* Greatly enhanced user-experience : Easily configure your syntax highlighting rules, and get better auto-completion.

* Many new quick-fixes : For example, when an identifier is unknown, automatically create the missing declaration
  as a toplevel declaration in a new unit.

* New refactorings such as Extract Function, Convert To Named Arguments, and Clean Imports.

* Ability to refactor even in dirty (unsaved) editors.

* Export Ceylon Module to Module Repository wizard : Export your Ceylon project as a module to the selected
  repository, in order to run your Ceylon project from the command-line.
  
* And, of course, many adjustments and bug fixes to provide a stable release.


### About Ceylon

[This page](/documentation/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=1_0_M1release) 
provides a quick 
introduction to the language. [The draft language specification][spec]
is the complete definition.

### Source code

The source code for Ceylon, its specification, and its website, and its IDE is 
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
