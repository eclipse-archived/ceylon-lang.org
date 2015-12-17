---
title: Ceylon on Java 9 + Jigsaw
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [interop, progress, compiler, java, modularity]
---

Everyone is talking about modules these days. New languages try to incorporate them,
and older languages try to retrofit them in. Which is great news, because modules are
essential. Java 9 is around the corner, because it's supposed to come out next year,
and the really big new feature is modularity, which it calls the 
[Jigsaw project](http://openjdk.java.net/projects/jigsaw/).

Ceylon is a language that featured modularity from the start, as part of the language
and not as an afterthought requiring complex third-party tool integration. In fact,
at the time we designed our Java JDK integration (at the time of Java 7), we went
as far as using the Jigsaw modularity plans for the JDK (yes Jigsaw got delayed a
few times) from the start, requiring JDK users to 
[import Jigsaw modules](/documentation/1.2/reference/interoperability/java-from-ceylon/#importing_jdk_modules)
as they were
planned at the time, rather than import the whole JDK in one go. So perhaps we were the
first ones with a modular JDK, in some sense :)

## Java 9’s Jigsaw

Jigsaw is a very large project, which includes the following changes:

- [Modularisation of the JDK](http://openjdk.java.net/jeps/200) into smaller units, 
  such as `java.base`, `java.xml` that Ceylon users of the JDK are already familiar with.
- This modularisation means removal of `rt.jar` that contained every JDK class. In fact
  it's been replaced by a `bootmodules.jimage` file which is not a jar, but whose contents
  [can be accessed by a virtual NIO `FileSystem` at `jrt:/`](http://openjdk.java.net/jeps/220).
- You can [write your own modules](http://openjdk.java.net/projects/jigsaw/spec/). 
  To turn your Java code into a Java 9 module, you simply
  add a module descriptor in a file called `module-info.java` (much like Ceylon module 
  descriptors, or Java package descriptors), which describes your module and the Java 9
  compiler and jar tools will then generate a jar with a `module-info.class` descriptor
  at the root of the jar. 
- That [module descriptor](http://cr.openjdk.java.net/~mr/jigsaw/spec/lang-vm.html) 
  allows you to specify the module name, the packages it exports,
  the name of the modules it imports and a few other things. But not versions, unfortunately,
  which are currently "out of scope" in Java 9.
- You can run your code as previously from the classpath, or as modules from the
  _module path_. The module path is just a folder in which you can place your modules and
  the JRE will look them up for you based on module name alone.

## Ceylon and Jigsaw

Java 9 has two _early-access_ (EA) downloads for users to try the module system. Only 
[one of them includes user modules](https://jdk9.java.net/jigsaw/). 
Make sure you use that one if you want to try out Ceylon running on Java 9.

Over the past weeks I've worked on getting Ceylon compiling and running on Java 9. This
involved (among other details) the following things:

- Generating `module-info.class` files from Ceylon module descriptors.
- Generating `module-info.class` files for the Ceylon distribution modules which are not
  written in Ceylon (like the compilers or runtime system).
- Making use of the Java 9 module descriptors for the `shared` packages information it contains
  (something supported by Ceylon since the beginning, but which was lacking for plain Java jars).
- Backporting Java 9 code that deals with modules to the `javac` fork we use to compile Java
  files and generate bytecode.
- Dealing with the removal of `rt.jar` and the _boot classpath_.
- Creating a new tool `ceylon jigsaw` which allows for the creation of a Java 9 _module path_.
- Making sure we can run Ceylon modules as Java 9 modules as an alternative to the four existing
  JVM runtimes which are the classpath, OSGi, Java EE or JBoss Modules.
- Make sure we can build and run on any of Java 7,8,9. This means that by default we do not
  generate Java 9 module descriptors, because several tools have problems dealing with them
  at this time.
- We have split some things out of the `ceylon.language` module so that it no longer depends
  on the compilers and type-checker, which means a lighter minimal runtime, which will be even
  further improved in the next weeks with more dependency removals :)

## Just tell me how to try this!

I will spare you the many details of this work, but with help from the Java 9 team, this is how
you can run your Ceylon modules on a Java 9 runtime:

- Download the [Java 9 EA with Jigsaw](https://jdk9.java.net/jigsaw/).
- Get the [Ceylon distribution code](https://github.com/ceylon/ceylon), 
  and compile it with `ant -Djigsaw=true clean dist` to get the Java 9 module descriptors.
- Write your Ceylon module normally, but compile it with 
  `.../ceylon/dist/dist/bin/ceylon compile --generate-module-info` to generate the Java 9 module
  descriptors.
- Create your Java 9 module path in an `mlib` folder with 
  `.../ceylon/dist/dist/bin/ceylon jigsaw create-mlib my.module/1`.
- Run your Ceylon module on Java 9 with 
  `.../jdk1.9.0-jigsaw/bin/java -mp mlib -m ceylon.language my.module/1`. At the moment, the
  `ceylon.language` module acts as main module and does the required setting up of the Ceylon
  runtime before loading and invoking your Ceylon module.

That's all there is to it!

## Caveats

Java 9 is not complete yet, and our support for Java 9 is also not complete. There will be issues
and bugs, and in fact we already know of several limitations, such as the following:

- While you can import a _pure_ Java 9 module from Ceylon, we will respect its exported packages,
  but we will not respect its dependencies, because Java 9 modules do not include dependency versions.
  In fact, even the module's version is not stored in the source module descriptor, but added by
  an optional flag to the Java 9 `jar` tool. Ceylon requires module dependencies to describe a
  version, so we have to combine the Java 9 module descriptor with another descriptor such as an
  OSGi descriptor or a Maven `pom.xml` descriptor. This merging of information is not currently done.
- Java 9 does not currently support optional modules or module cycles. It is not clear if they
  will support them at this time, unfortunately.
- The `ceylon import-jar` tool may complain about module visibility artifacts. We intend to fix this
  in time, but for now you can use `--force`.
- The JDK module list we used in Ceylon has slightly changed in Java 9. This is what we get for
  being the first to support Jigsaw ;) For example, the `javax.xml` module has been renamed to
  `java.xml`. We have set up aliases so that it "just" works, but there are modules that have
  been merged, and packages that have changed module, so it will not always work.
- The Java 9 runtime has been tested, but not as thoroughly as the existing classpath, OSGi,
  Java EE or JBoss Modules runtimes. We expect a few issues in the Ceylon metamodel.
