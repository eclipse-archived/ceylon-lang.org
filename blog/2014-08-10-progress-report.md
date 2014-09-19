---
title: Ceylon 1.1 progress report
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Ceylon 1.1 has been in development for 6 months already, so
it's way past time for a progress report! Since the release
is nearly ready, this is going to have to take the form of a 
summary of what we've been working on. Well, that's a 
daunting task, since we've already closed more than 650 
issues in the compiler and language module, and 300 in the 
IDE. Phew!

The top priorities for Ceylon 1.1 were:

- Finalize and freeze the language module APIs.
- Clean up and minimize the use of Java and JavaScript 
  native code in the language module. 
- Mop up remaining issues affecting Java interop.
- Performance.
- IDE build performance.

Naturally, we've also fixed hundreds of bugs unrelated to 
those priorities. 

## Language changes

There have been very few changes to the language, which has
been considered stable since last year's 1.0 release. The
big new features in 1.1 are:

- Support for [use-site variance](/blog/2014/07/14/wildcards).
- Introduction of a `Byte` class that may be optimized by 
  the compiler to `byte` on the JVM.
- Type inference for parameters of anonymous functions that
  occur as arguments in positional argument lists.

Other notable changes are:

- Powerful disjointness analysis for sequence and tuple 
  types.
- Allow comprehensions to begin with an `if` clause.
- New `sealed` annotation to prevent extension or
  instantiation of a type outside the module in which it is 
  defined.
- Introduction of `dynamic` interfaces, designed for 
  wrapping native JavaScript APIs.
- Redefined `-` operator to work for any `Invertible`.
- Allow metamodel references to `object`s and members of 
  `object`s.
- `try (x)` was changed to distinguish between the
  lifecycles of `Obtainable` and `Destroyable` resources.
- The type of the expression `{}` is now `{Nothing*}` 
  instead of `[]`.
- Allow refinement of multiple overloaded versions of a Java
  supertype method.
- Added ability to `catch` instances of `Throwable`.
- Minor adjustment to type argument inference algorithm for
  covariant and contravariant type parameters.
- Change to the syntax for dynamic enumeration expressions
  in native JavaScript interop.

The last two changes are breaking changes but should not
impact very many programs.

## Language module changes

For the 1.1 release, we've invested a lot of thought and 
development effort in the language module, carefully 
reviewing its design and scope, reducing the use of native 
code to an absolute minimum, optimizing performance, and 
picking on anything that looked like a mistake.

Therefore, this release makes several breaking changes, 
which will impact existing programs. As of Ceylon 1.1, the
language module is considered stable, and we won't make 
further breaking changes.

- Addition of a raft of new methods and functions for 
  working with streams.
- Optimization of the performance of `Array`, along with 
  some minor improvements to interop with Java native arrays.
- Removal of the `Cloneable` interface, and addition of a 
  `clone()` method to `Collection`.
- Addition of `Throwable`.
- Replacement of `Closeable` with `Obtainable` and 
  `Destroyable`.
- `Correspondence.items()` changed to `getAll()`.
- `Map`s and `Entry`s may now have null items.
- Various minor changes to the operations of `Iterable`, 
  `List`, and `Map`, including breaking changes to the 
  signatures of `Iterable.sequence()` and `Iterable.fold()`.
- `ArraySequence` is now `sealed` and may be instantiated
  via the `sequence()` function.
- Substantial redesign of `Enumerable` and `Range`.
- Several changes to the type hierarchy for numeric types.
- Removal of `SequenceBuilder` and move of `StringBuilder` 
  to `ceylon.collection`.
- Removal of superfluous functions `entries()` and 
  `coalesce()`.
- Removal of `LazyList`, `LazySet`, and `LazyMap`.
- Addition of `Array.sortInPlace()`.

## Modularity

We're currently investing effort in trying to make it easier
to use Ceylon modules outside of the Ceylon module runtime.

- Ceylon `.car` archives now include automatically generated
  OSGi and Maven metadata, and can execute in an OSGi
  container.
- New API for cross-platform resource loading.
- Support for deploying Ceylon modules to 
  [Vert.x](http://vertx.io).

## SDK

Notable changes to the SDK include:

- Introduction of `ceylon.locale`, `ceylon.logging`, and
  `ceylon.promise`.
- Many enhancements to `ceylon.collection`, including 
  addition of `ArrayList`, `TreeSet`, `TreeMap`, and
  `PriorityQueue` classes, along with `Stack` and `Queue` 
  interfaces.
- Various improvements to `ceylon.dbc`.

The collections module is now considered stable, and its API
is frozen.

Additionally, the `ceylon.test` module has been 
significantly enhanced, including the following improvements: 

- New `testSuit`, `testListeners`, and `testExecutor`
  annotations.
- Redesigned events model.
- HTML report generation in `ceylon.test`.
- Support for TAP v13 (Test Anything Protocol).
- Many improvements to `ceylon.test`.
- Addition of `ceylon test-js` command.

## IDE

Development of the IDE has been extremely active, with many
new features and major performance enhancements.

- Complete rework of build process, for much improved
  performance.
- New refactorings: Move Out, Make Receiver, Move to Unit,
  Extract Parameter, Collect Parameters, Invert Boolean, 
  Safe Delete.
- Major enhancements to the Change Parameters refactoring.
- Inline refactoring now works for shared class/interface 
  members.
- Much better handling of anonymous functions and function
  references in Extract and Inline refactorings.
- Brand new high quality code formatter.
- Rewritten Ceylon Explorer with much better presentation of 
  modules and modular dependencies.
- New navigation actions: Open in Type Hierarchy View,
  Go to Refined Declaration.
- Popup Quick Find References and Recently Edited Files.
- Graphical Visualize Modular Dependencies.
- Further integration of "linked mode" with refactorings and
  quick assists.
- Useful Format Block source action.
- Auto-escape special characters when pasting into string
  literals.
- Synchronization of all keyboard accelerators with JDT 
  equivalents (by popular request).
- Save actions in Ceylon Editor preferences.
- IntelliJ-style "chain completion" (hit ctrl-space twice).
- Propose toplevel functions applying to a type alongside
  members of the type.
- Several new options for customizing autocompletion and
  appearance in Ceylon Editor preferences.
- New quick fixes/assists: convert between string 
  interpolation and concatenation, convert to/from verbatim 
  string, add satisfied interfaces, add type parameter, 
  change named argument list to positional, fill in 
  argument names, export module, convert to verbose form 
  refinement, print expression, fix refining method signature,
  change to `if (exists)`, change module version, assign to
  `for`/`try`/`if (exists)`/`if (nonempty)`/`if (is)`.
- Run As Ceylon Test on node.js.
- Support for running all tests in a project or source 
  folder.
- New default color scheme for syntax highlighting and many
  other aesthetic improvements.
