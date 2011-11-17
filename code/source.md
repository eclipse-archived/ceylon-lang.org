---
title: Getting the source
layout: code
tab: code
author: Emmanuel Bernard
---
# #{page.title}

We publish everything on GitHub under the [Ceylon organization](https://github.com/ceylon).

You need to install the Java Development Kit 6 or above (from Oracle or OpenJDK). 
You also need to install `git`.

## Ceylon projects

The Ceylon project is still up in several independant parts:

- [Parser, typechecker and specification](#parser_typechecker_and_specification)
- [Compiler, documentation generator and runner](#compiler_documentation_generator_and_runner)
- [Ceylon language module](#ceylonlanguage_module)
- [Ceylon Eclipse IDE plugin](#ceylon_eclipse_ide_plugin)

### Parser, typechecker and specification

Git repository: <https://github.com/ceylon/ceylon-spec>

This consists in a library that parses Ceylon source files, and runs a type-checking analysis
on them, builds a list of warnings and errors, and produces all the model of the analysed source
code. This is the compiler frontend.

The Ceylon specification is also contained in that project.

#### Building

You can build and publish the typechecker in the local Ceylon repository (`~/.ceylon`) with this:

<!-- lang: bash -->
    ant publish

You can also build the specification:

<!-- lang: bash -->
    ant doc

The generated documentation will be available in `build/en/html/index.html`

Find more info in the project's [README](https://github.com/ceylon/ceylon-spec/blob/master/README.md).

### Compiler, documentation generator and runner

Git repository: <https://github.com/ceylon/ceylon-compiler>

This consists in the `ceylonc` compiler command, the `ceylond` API documentation generator, and
the `ceylon` runner command.

You can find out how to run those commands from the [documentation](/documentation/spec/modulesandtools.html#tools).

#### Building

This project depends on the [Parser and typechecker](#parser_typechecker_and_specification) and 
[Ceylon language module](#ceylonlanguage_module) projects. You
should check them out and build them first.

You can build the compiler project with this:

<!-- lang: bash -->
    ant build

Find more info in the project's [README](https://github.com/ceylon/ceylon-compiler/blob/master/README.md).

### `ceylon.language` module

Git repository: <https://github.com/ceylon/ceylon.language>

This consists in the `ceylon.language` module, which contains the core of the Ceylon runtime.

See the API [documentation](#{site.urls.apidoc}/) for more information.

#### Building

You can build and publish the language module in the local Ceylon repository (`~/.ceylon`) with this:

<!-- lang: bash -->
    ant publish

Find more info in the project's [README](https://github.com/ceylon/ceylon.language/blob/master/README.md).

### Ceylon Eclipse IDE plugin

Git repository: <https://github.com/ceylon/ceylon-ide-eclipse>

This contains our Eclipse IDE plugin for Ceylon.

#### Building

Building and running instructions are located in the project's 
[README](https://github.com/ceylon/ceylon-ide-eclipse/blob/master/README.md).