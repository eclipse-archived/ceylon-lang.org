---
title: Ceylon Fat Jars
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [interop, runtime, modularity]
---

Ceylon 1.2.3 is looming closer, and so we should start talking about some of the new features that
it will contain. One of those new features is the new `ceylon fat-jar` command.

`ceylon fat-jar my.module/1` lets you generate a jar which contains the `my.module/1` module and
every required dependency. Once you have that jar, you can execute it with `java -jar my.module-1.jar`
and it will execute the module.

Naturally, you can customise the function or class to execute with the `--run` option, but the default
is the `run` method in your module (`my.module::run` in our case).

The modules are executed in a "flat classpath" mode, without JBoss Modules or any sort of module isolation,
and with the metamodel already set up statically when the fat jar was created, so it's a little bit different
to the older alternative of running Ceylon modules using the
[Main API](/documentation/1.2/reference/interoperability/ceylon-on-jvm/#using_the_main_api)
and `ceylon classpath` tool, which did not deal
with packing all the dependencies. It is also different to the `ceylon run --flat-classpath` in that it does
not require a module repository at run-time, since `ceylon fat-jar` packs it all together. 

Try it out, it's pretty useful to distribute Ceylon programs and run them in places without having to
install the Ceylon distribution.
