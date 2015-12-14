---
title: First maintenance update for the Ceylon IDE version 1.2.0
author: David Festal
layout: blog
unique_id: blogpage
tab: blog
tags: [release, news, ide, 1.2.0]
---

[ide]: /documentation/1.2/ide/
[license]: /code/licenses/
[quick-intro]: /documentation/1.2/introduction/
[update-site]: /eclipse/updatesite/
[release-notes]: https://github.com/ceylon/ceylon-ide-eclipse/releases/tag/com.redhat.ceylon.eclipse.feature_1.2.0.v20151214-1608-Final
[commits]: https://github.com/ceylon/ceylon-ide-eclipse/compare/1.2.0...com.redhat.ceylon.eclipse.feature_1.2.0.v20151214-1608-Final
[issues]: /code/issues
[install]: /documentation/1.2/ide/install

## Introducing the first Ceylon IDE maintenance update

Just after the release of [Ceylon 1.2.0](/blog/2015/10/29/ceylon-1-2-0/), we started managing a __maintenance branch__ of the IDE-related
code, that will always be __fully compatible__ with the last release of the Ceylon (Command line distribution and SDK).

This way we've already been able to very easily backport to this branch many bug fixes or enhancements
implemented on the main development branch.

As a result, the first maintenance update of the [Ceylon IDE plugin for Eclipse][ide], which fixes about 30 issues, has just been
published onto the main Ceylon IDE [update site][update-site].

So if you currently use the version 1.2.0 of the Ceylon IDE Eclipse plugin, simply run the 
`Check For Updates` command in the Eclipse `Help` menu, and Eclipse should propose you to update the Ceylon IDE
features.

And if you still don't use the Ceylon IDE Eclipse plugin, just [install][install] it and give it a try now.

## Source tracking

Of course each maintenance update will be tagged inside the GitHub source repositories.

So as soon as we know the version of the `Ceylon IDE` feature, visible from the Eclipse `About` dialog:

<div style="text-align:center;">
<img src="/images/screenshots/blog/2015-12-14-maintenance-update-for-1.2.0-IDE/about-ceylon-ide.png" style="box-shadow: 0 0 10px #888;margin-left:5px;" width="679px" height="auto"/>
</div>

we can immediately checkout the __precise__ source code corresponding to a Ceylon IDE installation.

This will help us __reproducing more easily__, and __fixing more quickly__, any issue encountered on the production Ceylon IDE.

## Maintenance update release notes

Detailed release notes of this maintenance update can be found [here][release-notes],
and related commits can be found [here][commits].

## Issues

Bugs and suggestions may be reported in GitHub's 
[issue tracker][issues].

## About Ceylon 

Ceylon is a highly understandable object-oriented language 
with static typing. The language features:

- an emphasis upon __readability__ and a strong bias toward 
  __omission or elimination of potentially-harmful or 
  potentially-ambiguous constructs__ and toward highly 
  __disciplined use of static types__,
- an extremely powerful and uncommonly elegant type system 
  combining subtype and parametric polymorphism with:
  - first-class __union and intersection types__, 
  - both __declaration-site and use-site variance__, and
  - the use of principal types for __local type inference__ 
    and __flow-sensitive typing__,
- a unique treatment of __function and tuple types__, 
  enabling powerful abstractions, along with the most 
  __elegant approach to `null`__ of any modern language, 
- first-class constructs for defining __modules and 
  dependencies between modules__,
- a very flexible syntax including __comprehensions__ and 
  support for expressing __tree-like structures__,
- __fully-reified generic types__, on both the JVM and
  JavaScript virtual machines, and a unique __typesafe 
  metamodel__.

More information about these language features may be
found in the [feature list](/features) and 
[quick introduction][quick-intro].

