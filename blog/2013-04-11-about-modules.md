---
title: About modules
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [design interop herd]
---

Modules, ah, modules. The albatross of Java. I frequently joke that modules are scheduled for Java N+1 where N moves forward with
each release. I remember perfectly the first time I heard of Java getting modules at Devoxx, back when they were still planned for
Java 7. I remember I heard the announcement and what I saw made a lot of sense, I couldn't wait to get them. I agreed completely,
and still do, with the assertion that modules belong in the language, just like packages, and that they should not be delegated to
third-party external systems which will never be able to have the level of integration that you can achieve by being an integral
part of the language. And then, they pushed it to Java 8. And then to Java 9. It's a shame because it looks like a really well
thought-out module system.

Meanwhile, Ceylon already supports modules, in a generally awesome way. But why do we need modules? Here are some easy answers:

- To serve as a larger container than packages. Everyone ships Java code into jars which are generally accepted to be modules: they
  represent a group of packages that implement a library or program and have a version.
- To express and resolve dependencies: your module (jar) is going to depend on other modules (jars), so we should know which they are
  and how to find them.
- To distribute modules: Linux distributions have been doing this forever. With a modular system where modules have names and versions,
  you can organise them in a standard hierarchy, which can then be used by tools to obtain those modules in a standard way. With
  dependencies, the tools can then download/upload the dependencies too, which means distribution becomes a lot simpler.
- To isolate modules at runtime. This is part of escaping the infamous _classpath hell_: if you isolate your modules at runtime, then
  you can have multiple programs that depend on different versions of the same module loaded at the same time.

So why is it better if we have modules in the language, rather than outside of it?

- It's standard and tools have to support it. You could view this as a downside, but really, what part of the Java language would you
  rather have left unspecified? Would you be ready to delegage the implementation of packages to third-party tools? Having a single
  way to deal with modules helps a lot, both users and implementors.
- You get rid of external tools, because suddenly `javac`, `java` and friends know how to publish, fetch and execute modules and their
  dependencies. No more plumbing and sub-par fittings.
- It gets integrated with reflection. Modules are visible at runtime, fully reified and hopefully dynamic too, just like classes and
  packages are.
- Dependencies and modules are separated from the build system. There's absolutely no good reason why the two should be confused with
  one another.

These are the reasons why I can't wait for Java N+1 to have modules, I think they'll be great. But if you need modules _now_, then
you can use Ceylon :)

Ceylon support modules in the language, from the start, with:

- a super small `ceylon.language` base module, which is all you need to start using Ceylon
- a modular SDK
- a great module repository: [Herd](http://modules.ceylon-lang.org)
- support for module repositories in all the tools, be it the command-line or the IDE. They know how to deal with dependencies, fetch
  or publish modules to/from local or remote repositories
- superb support for Herd repositories from the IDE, with the ability to search for modules, have auto-completion and all
- support for a modular JDK, using the same module map as the Jigsaw project (Java's planned modular SDK)
- and even interoperability with Maven repositories, so that you can use Maven modules as if they were Ceylon modules

## Other existing third-party module systems

As I mentioned, we support using Maven repositories from Ceylon, and we will probably support OSGi too, in time. Those are the two
main third-party module systems for Java. OSGi is used a lot in application servers or IDEs, but rarely by most Java programmers,
which prefer Maven. Maven was the first system that provided both modularity and a build system for the JVM. Prior to that we had
Ant, which only provided the build system. Maven essentially prevailed over Ant because it supported modularity, which meant that
people no longer had to worry about how to get their dependencies. Even applying the modularity solution to itself, it became
easier to distribute Maven modules than Ant modules.

Maven supports modularity and dependencies, in order to resolve and download them, but once they are downloaded, the dependencies are
crammed into the classpath, so as far as the Java compiler or runner are concerned, modularity has been erased. There is no support
for multiple versions of the same module at runtime, or any kind of validation of dependencies.

### The undeclared transitive dependency problem

We recently had bug reports for Ceylon where our users has trouble using Maven modules from Ceylon, due to missing dependencies. Since
we do use the dependencies provided by Maven, we found that a bit weird. After checking, it appears that we've been hit by the modularity
erasure of Maven. Here's a simple example of something you can do with Maven modules:

- You write a module A, which uses module B and C, but you only declare a dependency on module B
- Module B depends on module C
- Module C does not depend on anything

In Ceylon, if you tried to compile module A, the compiler would not let you because you failed to depend on C. With Maven, it just works,
because Maven fetches modules B and C and puts them in the classpath, which means all implicit transitive dependencies end up visible
to your module. Modularity is erased. This may seem convenient, but it really means that dependencies are not checked and cannot be trusted.

Due to that, we can't rely on Maven modules to properly declare their dependencies, so we cannot run Maven modules in isolation.

### The undeclared implicit dependency problem

There's something more subtly wrong with unchecked module systems: implicit dependencies. This is something you're allowed to do with Maven:

- Module A uses module B
- Module B depends on module C and declares it
- Module B uses types from module C in it public API, such as parameter types, method or field types, or even super classes

This is a variant of the first kind of problem, except that in this case nobody can use module B without also importing module C directly,
because it's not possible to use the types of module B without seeing the types of modules C.

In Ceylon, if you tried to compile module B, the compiler would not let you unless you _export_ your module C dependency. This way,
when you depend on module B, you automatically also depend on module C, because you really need both to be visible to be able to
use module B's API.

## Another point in favour of integrated module systems

If we had an integrated module system from the start, in Java, with proper module isolation, we would not have the issues I just described
with missing dependencies that are so widespread in Maven, because there are no tools to prevent you from making these mistakes. Compilers
do not let you use packages unless you import them, there's no reason to expect that the same would not hold for modules.

I still think the modules project for Java will be a great leap forward, but since Java N+1 is still not here, 
and there's a huge library of Maven modules that we want to be able to use, we have to find a way to
bypass the limitations of Maven's dependency declarations to let you use them in Ceylon. We have various ideas of how to do that, from automatic
detection of dependencies through bytecode analysis, to storing Maven modules in a "flat classpath" container, or even via dependency overrides
where users could "fix" Maven dependencies. We're still in the process of evaluating each of these solutions, but if you have other 
suggestions, feel free to pitch in :)