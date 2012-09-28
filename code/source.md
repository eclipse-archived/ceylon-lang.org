---
title: Getting the source
layout: code
tab: code
unique_id: codepage
author: Emmanuel Bernard
---
# #{page.title}

We publish everything on GitHub under the [Ceylon organization](https://ceylon.github.com).

## Ceylon projects

The Ceylon project is actually made up of several smaller projects:

- [Parser, typechecker and specification](#parser_typechecker_and_specification)
- [Compiler and documentation compiler](#compiler_and_documentation_compiler)
- [JavaScript compiler](#javascript_compiler)
- [Ceylon language module](#ceylonlanguage_module)
- [Ceylon Eclipse IDE plugin](#ceylon_eclipse_ide_plugin)
- [Module system](#module_system)
- [Launcher](#launcher)
- [Common code library](#common_code_library)
- [Ceylon Herd](#ceylon_herd)
- [Ceylon SDK platform modules](#ceylon_sdk_platform_modules)

You can also view [all our git projects](http://ceylon.github.com) at quick glance.

Information on how to set up your development environment, how to build the projects and how to contribute to the project can be found [HERE](/code/contribute).

### Parser, typechecker and specification

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-spec">https://github.com/ceylon/ceylon-spec</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-spec/issues">https://github.com/ceylon/ceylon-spec/issues</a></td></tr>
</table>

This is a library that parses Ceylon source files, and runs type analysis on them, 
producing a list of warnings and errors, and a the model of the analyzed source
code. This is the compiler frontend.

The Ceylon language specification is also kept in this project.

There's more info in the [README](https://github.com/ceylon/ceylon-spec/blob/master/README.md).

### Compiler and documentation compiler

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-compiler">https://github.com/ceylon/ceylon-compiler</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-compiler/issues">https://github.com/ceylon/ceylon-compiler/issues</a></td></tr>
</table>

This is where you'll find the `ceylonc` compiler and the `ceylond` API documentation compiler,
as well as the Ceylon ant tasks.

You can find out how to run these commands from the [documentation](#{site.urls.spec_current}#tools).

Feeling adventurous and want to help us with the compiler backend? Read [how to work on that project](/code/contribute).

There's more info in the [README](https://github.com/ceylon/ceylon-compiler/blob/master/README.md).

### JavaScript compiler

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-js">https://github.com/ceylon/ceylon-js</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-js/issues">https://github.com/ceylon/ceylon-js/issues</a></td></tr>
</table>

This project contains the JavaScript compiler.

There's more info in the [README](https://github.com/ceylon/ceylon-js/blob/master/README.md).

### `ceylon.language` module

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon.language">https://github.com/ceylon/ceylon.language</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon.language/issues">https://github.com/ceylon/ceylon.language/issues</a></td></tr>
</table>

This project contains the module `ceylon.language`, the core classes 
mentioned in the language specification.

See the [API documentation](#{site.urls.apidoc_current}/ceylon/language/) for more information.

There's more info in the [README](https://github.com/ceylon/ceylon.language/blob/master/README.md).

### Module system

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-module-resolver">https://github.com/ceylon/ceylon-module-resolver</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-module-resolver/issues">https://github.com/ceylon/ceylon-module-resolver/issues</a></td></tr>
</table>

This is where you'll find the Ceylon module system, based on JBoss Modules.

There's more info in the [README](https://github.com/ceylon/ceylon-module-resolver/blob/master/README.md).

### Launcher

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-runtime">https://github.com/ceylon/ceylon-runtime</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-runtime/issues">https://github.com/ceylon/ceylon-runtime/issues</a></td></tr>
</table>

This is where you'll find the Ceylon `ceylon` launcher command, which runs Ceylon modules.

There's more info in the [README](https://github.com/ceylon/ceylon-runtime/blob/master/README).

### Common code library

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-common">https://github.com/ceylon/ceylon-common</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-common/issues">https://github.com/ceylon/ceylon-common/issues</a></td></tr>
</table>

This is where you'll find code that is commonly used by the other projects. It handles configuration files, repositories, authentication, proxies and more things.

There's more info in the [README](https://github.com/ceylon/ceylon-common/blob/master/README).

### Ceylon Eclipse IDE plugin

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-ide-eclipse">https://github.com/ceylon/ceylon-ide-eclipse</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-ide-eclipse/issues">https://github.com/ceylon/ceylon-ide-eclipse/issues</a></td></tr>
</table>

This project contain the Ceylon IDE Eclipse plugin.

There's more info in the [README](https://github.com/ceylon/ceylon-ide-eclipse/blob/master/README.md).

### Ceylon Herd

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-herd">https://github.com/ceylon/ceylon-herd</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-herd/issues">https://github.com/ceylon/ceylon-herd/issues</a></td></tr>
</table>

This project contain the Ceylon Herd application.

There's more info in the [README](https://github.com/ceylon/ceylon-herd/blob/master/README.md).

### Ceylon SDK platform modules

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-sdk">https://github.com/ceylon/ceylon-sdk</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-sdk/issues">https://github.com/ceylon-sdk/issues</a></td></tr>
</table>

This project contains the platform modules belonging to the Ceylon SDK.

There's more info in the [README](https://github.com/ceylon/ceylon-sdk/blob/master/README.md).
