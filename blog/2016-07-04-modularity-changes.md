---
title: Modularity Changes
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [runtime, modularity]
---

TL;DR: This article describes the modularity changes in the Ceylon run-time and distribution, in order
to make them lighter at run-time. Skip to the [Final runtime dependencies](#final_runtime_dependencies)
section if you just want the outcome.

Ceylon has featured a [modular architecture](/documentation/1.2/tour/modules/#modularity) from the start.
Not just for Ceylon users who write
modules, but also within the Ceylon distribution. Historically we used to have very few modules,
that were directly related to separate Git projects. Adding a new module meant a new repository
and lots of changes in the build. Naturally, as the project grew, each of those modules also
grew, and got new third-party dependencies, and occasionally adding a feature in one module
was made tremendously easier by just adding that "one more" dependency between distribution modules,
resulting in a big spaghetti graph of distribution modules that is common in older/evolved systems.

As we initially expected most Ceylon users to run their code using the 
[`ceylon run` command](/documentation/current/reference/tool/ceylon/subcommands/ceylon-run.html), we
figured that since they have the Ceylon distribution installed, it does not matter if they depend
on more modules from that distribution than strictly necessary. Those modules had to be there
anyway, so it would not save any bandwidth to reduce those dependencies.

Naturally, we were wrong, and between the Ceylon Eclipse or IntelliJ IDEs, running Ceylon on
OpenShift, WildFly, Vert.x or on Android, people started running Ceylon without the distribution
installed, using just the standard `java` runner. It became soon apparent that we had to untangle
those dependencies to make the runtime requirements lighter.

Historically we had the following modules:

- common module used by other modules
- typechecker (the shared compiler front-end)
- Java compiler back-end
- JavaScript compiler back-end
- module repository system
- JBoss modules runtime

# The model module

When we implemented [reified generics](/documentation/1.2/tour/generics/#fully_reified_generic_types), 
we had to add subtyping to the runtime, so that we'd be able
to figure out if `is T bar` was true or not. The easiest thing at the time was to "just" depend
on the typechecker (compiler front-end) which dealt with the language model and subtyping, and the Java 
compiler back-end, which had infrastructure to load a language model from JVM information such as
class files, or in this case reflection.

This essentially made the runtime depend on the compiler front-end and back-end, which we realised
was not ideal, so during the Ceylon 1.2 development, we extracted all model description, loading
and subtyping to a new `ceylon-model` module, but we did not have enough time to do more and so
these dependencies remained due to other causes.

# Supporting Java 9

During our work on [supporting Java 9 / Jigsaw modules in Ceylon](/blog/2015/12/17/java9-jigsaw/),
it became clear that having kept
our "fork" of `javalang` tools (that we use for `javac`) under its original package name would not
work anymore, we renamed its package and used the opportunity to prune away parts of the java tools
we did not use. We also extracted the class-file reader part to its own module so we could use it
outside of the compiler to remove our dependency to `jandex` (a class-file scanner).

Finally, when we created the `ceylon jigsaw` tool (which populates a folder with the jar files required
by a Ceylon module, to run it on a Java 9 VM) it became evident that the runtime still depended not
just on the compiler front-end and Java back-end, but even on the JavaScript back-end, which frankly
made little sense in most JVM executions.

These dependencies were due to the 
[Ceylon Tool Provider API](/documentation/1.2/reference/interoperability/ceylon-on-jvm/#using_the_ceylontoolprovider_api)
having snuck into the `ceylon.language` module
as a convenience (at the time). Since that allowed you to compile and run Ceylon programmatically
for both Java and JavaScript back-ends, it had to depend on the tools.

We decided to split the Ceylon Tool Provider into its own module and got rid of the final dependencies from
the language module to the compilers and typechecker, but had no more time to get rid of further
dependencies such as JBoss Modules and Aether in time for Ceylon 1.2.2.

# Supporting Android

Initial [work on running Ceylon on Android](/blog/2016/06/02/ceylon-on-android/) revealed that what passes for 
small dependencies on ordinary
JVM executions, or even on Java EE deployments, was not an option on Android where every method counts.

At this point we had to bite the bullet and make every non-required transitive dependency go.

We noticed that the old `common` module had grew to include the 
[Command-Line Tooling API](/documentation/1.2/reference/tool/#the_ceylon_command) that makes the `ceylon`
command and its subcommands and plugins work. That in turn depended on a Markdown renderer used by
`ceylon doc`. It was pretty trivial to extract it to its own module because this was never used
in Ceylon user programs.

Next in line was our Shrinkwrap Resolver dependency, which our module repository system uses to 
[interoperate with Maven repositories](/documentation/1.2/reference/repository/maven/#maven_repositories).
This was a fat-jar with all its dependencies included, including some Apache
Commons modules, and an outdated version of Eclipse Aether. That fat-jar had already been problematic
in our Maven module, which already had its version of Aether, so getting rid of the fat-jar was a good
idea. We also realised that some of its Apache Commons dependencies were already included outside the
fat-jar in our distribution repository, so there was that duplication to fix too.

So what we did was remove the Shrinkwrap Resolver dependency and use Aether directly, by incorporating
all its subcomponents into our distribution. It turns out that because the latest version of Aether
requires Google Guava, our distribution grew in size rather than shrink (that jar is huge). But to offset
that, we made the Aether dependency optional, and made sure it was possible to run Ceylon without it
as long as there was some compilation step beforehand that provided all the Maven dependencies that
you may use in interop. [`ceylon fat-jar`](/blog/2016/06/29/ceylon-fat-jars/) or `ceylon jigsaw` 
would do that for you, for example.

Our module repository system also provided support for 
[writing to WebDAV or Herd repositories](/documentation/1.2/reference/repository/#supported_repository_types), which
required some dependencies on Apache Http Client or Sardine, and we made these dependencies optional
as well, because at runtime your Ceylon program is very unlikely to write to HTTP repositories. This
is something only the compiler and other tools do.

We also removed a dependency to JBoss Modules from the language module using abstraction, since that
platform was optional and never used on Android or other flat-classpath runtimes.

Finally, the language module only had one dependency left on the (much slimmer) module repository system 
via the presence of the 
[`Main API`](/documentation/1.2/reference/interoperability/ceylon-on-jvm/#using_the_main_api) in there, 
and we moved that class to its own module.

# Final runtime dependencies

After all this pruning, the language module on the JVM is back down to requiring the following set
of transitive dependencies:

- common (small and free of tooling and dependencies)
- model (which depends only on the class-file reader)
- class-file reader

So your Ceylon module will only depend on four jars (these three and the language module), the sum 
size of which is 2.4 Mb, which is much smaller than initially, and has dramatically less methods,
at around 17148 methods. This is still too much, but can be brought down by tooling such as ProGuard
to remove unused classes. Remember this includes a runtime for an entire language, so it's not
_that_ big, all things considered.

# SDK changes

In order to be able to use Ceylon's HTTP client on Android, we also split up the `ceylon.net` module from the
Ceylon SDK into client and server modules. Otherwise the HTTP server and its dependencies were
too much drag for Android's method count.
