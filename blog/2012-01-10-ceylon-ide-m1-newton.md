---
title: First official release of Ceylon IDE
author: David Festal
layout: blog
unique_id: blogpage
tab: blog
tags: [release, progress, M1, ide]
---

[ide_install]: /documentation/1.0/ide/install?utm_source=blog&utm_medium=web&utm_content=ide_install&utm_campaign=IDE_1_0_M1release
[ide]: /documentation/1.0/ide?utm_source=blog&utm_medium=web&utm_content=ide&utm_campaign=IDE_1_0_M1release
[newton]: /blog/2011/12/20/ceylon-m1-newton?utm_source=blog&utm_medium=web&utm_content=blog&utm_campaign=IDE_1_0_M1release

Today, we're proud to announce the first official release of the [Ceylon IDE](/documentation/1.0/ide).

![teaser](/images/screenshots/teaser2.png)

This release is fully compatible with the already-released [Ceylon M1 "Newton" 
command line distribution][newton] which contains the compiler, documentation 
compiler, language module, and runtime. On the other hand, Ceylon IDE can be 
used as a standalone Ceylon development tool, even if the full Ceylon 
distribution is not already separately installed.

You can install Ceylon IDE from our [Eclipse plugin update site][ide_install].
The [welcome page](/documentation/1.0/ide/screenshots#welcome_page) is a gentle 
way to get started with Ceylon.


### Main features

A full list of features with screenshots can be found [here][ide].

Among the features that have greatly enriched the IDE since its first 
pre-release builds, the following stand out:

* A Ceylon perspective, welcome page, and cheat sheets.
* Wizards to create new Ceylon projects, modules, packages, and units.
* Cross-project dependencies and navigation: add another Ceylon project on 
  the build path, and dependencies are automatically handled.
* Full integration with the Ceylon module architecture: resolve dependencies
  in an external module repository, and easily export your Ceylon project 
  as a module to a selected repository.
* Enhancements to refactorings, including the ability to refactor even in 
  dirty (unsaved) editors.
* New quick-fixes: for example, when an identifier is unknown, automatically 
  create a new file containing a stub for the missing declaration.
* Improved autocompletion: proposals are now sorted to prioritize those
  which are assignable to the expected type, as well as those which are
  declared nearby.
* Customization: easily configure your own colors for syntax highlighting.
* And, of course, many adjustments and bug fixes to provide a stable release.


### About Ceylon

[This page](/documentation/1.0/introduction/?utm_source=blog&utm_medium=web&utm_content=introduction&utm_campaign=IDE_1_0_M1release) 
provides a quick introduction to the language. [The draft language specification](/documentation/1.0/spec)
is the complete definition.

### Source code

The source code for Ceylon, its specification, and its website, and its IDE is 
freely available from GitHub:

<https://github.com/ceylon>

### Issues

Bugs and suggestions may be reported in GitHub's issue tracker.

### Community

The Ceylon community site includes 
[documentation](/documentation/1.0/?utm_source=blog&utm_medium=web&utm_content=documentation&utm_campaign=IDE_1_0_M1release), 
the [current draft of the language specification](/documentation/1.0/spec), 
the [roadmap](/documentation/1.0/roadmap?utm_source=blog&utm_medium=web&utm_content=roadmap&utm_campaign=IDE_1_0_M1release) 
and information about [getting involved](/code?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=IDE_1_0_M1release).

<http://ceylon-lang.org>
