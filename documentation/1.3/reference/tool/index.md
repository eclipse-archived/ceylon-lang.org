---
layout: reference13
title_md: Command line tooling and build tools
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../../..
---

# #{page.title_md}

Because the Ceylon compiler and runtime come with build-in dependency
management, many Ceylon projects don't even need a separate build 
system. So to build Ceylon projects from the command line, we have
four options:

- the `ceylon` command itself,
- Apache `ant`,
- Gradle, and
- Maven.

### The `ceylon` command

The [`ceylon` command](ceylon/) comes packed with functionality for 
compiling, managing, and executing Ceylon modules. It even features 
a powerful [plugin architecture](plugin/) that lets you develop new 
subcommands and easily install subcommands created by the Ceylon 
community.

It's possible to customize the behavior of the `ceylon` command for
a particular project using a [configuration file](config/).

You can find a list of the built-in subcommands 
[here](ceylon/subcommands/index.html).

### Apache `ant`

The Ceylon command line distribution somes with several 
[`ant` tasks](ant/) for building Ceylon projects.

### Gradle

There is a [Gradle plugin](https://github.com/renatoathaydes/ceylon-gradle-plugin) 
for Ceylon that offers some very useful functionality for managing 
dependencies to Java libraries.

### Maven

There is also a [Maven plugin](https://github.com/ceylon/ceylon-maven-plugin)
for Ceylon. You can learn about it [here](../interoperability/maven).
