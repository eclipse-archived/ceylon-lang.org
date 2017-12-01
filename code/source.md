---
title: Getting the source
layout: code
tab: code
unique_id: codepage
author: Emmanuel Bernard
---
# #{page.title}

We publish everything on GitHub under the [Ceylon organization](http://ceylon.github.com).

## Ceylon projects

The Ceylon project is actually made up of several smaller components:

- [Parser, typechecker and specification](#parser_typechecker_and_specification)
- [Model](#model)
- [Java compiler and other command line tools](#java_compiler_and_other_command_line_tools)
- [JavaScript compiler](#javascript_compiler)
- [Ceylon language module](#ceylonlanguage_module)
- [Module system](#module_system)
- [Launcher](#launcher)
- [Common code library](#common_code_library)
- [Packaging and distribution](#packaging_and_distribution)
- [Ceylon IDE for Eclipse](#ceylon_ide_for_eclipse)
- [Ceylon IDE for IntelliJ](#ceylon_ide_for_intellij)
- [Ceylon IDE for NetBeans](#ceylon_ide_for_netbeans)
- [Ceylon IDE common code](#ceylon_ide_common_code)
- [Ceylon Web IDE](#ceylon_web_ide)
- [Ceylon Herd](#ceylon_herd)
- [Ceylon SDK platform modules](#ceylon_sdk_platform_modules)

You can also view [all our git projects](http://ceylon.github.com) at quick glance.

Information on how to set up your development environment, how to build the projects 
and how to contribute to the project can be found [HERE](/code/contribute).

### Parser, typechecker and specification

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/typechecker">https://github.com/ceylon/ceylon/tree/master/typechecker</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-typechecker">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is a library that parses Ceylon source files, and runs type analysis on them, 
producing a list of warnings and errors, and an AST for the analyzed source
code. This is the compiler frontend.

The Ceylon language specification is also kept in this project.

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/typechecker/README.md).

### Model

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/model">https://github.com/ceylon/ceylon/tree/master/model</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-model">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is an independently reusable library that implements most of the type system.
 
There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/model/README.md).

### Java compiler and other command line tools

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/compiler-java">https://github.com/ceylon/ceylon/tree/master/compiler-java</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-compiler-java">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is where you'll find the `ceylon compile` compiler and the 
`ceylon doc` API documentation compiler, some other command line tools,
as well as the Ceylon ant tasks.

You can find out how to run these commands from the [documentation](#{site.urls.spec_current}#tools).

Feeling adventurous and want to help us with the compiler backend? Read [how to work on that project](/code/contribute).

There's more info in the [README](https://github.com/ceylon/ceylon-compiler/blob/master/compiler-java/README.md).

### JavaScript compiler

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/compiler-js">https://github.com/ceylon/ceylon/tree/master/compiler-js</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-compiler-js">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This project contains the JavaScript compiler.

There's more info in the [README](https://github.com/ceylon/ceylon-js/blob/master/compiler-js/README.md).

### Language module

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/language">https://github.com/ceylon/ceylon/tree/master/language</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-language">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This project contains the module `ceylon.language`, the core classes 
mentioned in the language specification.

See the [API documentation](#{site.urls.apidoc_current}/index.html) for more information.

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/language/README.md).

### Module system

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/cmr">https://github.com/ceylon/ceylon/tree/master/cmr</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-cmr">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is where you'll find the Ceylon module system, based on JBoss Modules.

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/cmr/README.md).

### Launcher

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/runtime">https://github.com/ceylon/ceylon/tree/master/runtime</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-runtime">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is where you'll find the Ceylon `ceylon` launcher command, which runs Ceylon modules.

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/runtime/README.md).

### Common code library

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/common">https://github.com/ceylon/ceylon/tree/master/common</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-common">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is where you'll find code that is commonly used by the other projects. It handles configuration files, repositories, authentication, proxies and more things.

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/common/README.md).

### Packaging and distribution

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon/tree/master/dist">https://github.com/ceylon/ceylon/tree/master/dist</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon/issues?q=is%3Aopen+is%3Aissue+label%3Ac-dist">https://github.com/ceylon/ceylon/issues</a></td></tr>
</table>

This is the project that pulls together all the distributable files from the other projects and bundles them into a coherent whole
that can be distributed publicly. It also serves as the base directory from which to work when as a developer you don't have an
official Ceylon installation on your system (you might be working on several different versiosn afterall).

There's more info in the [README](https://github.com/ceylon/ceylon/blob/master/dist/README.md).

### Ceylon IDE for Eclipse

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-ide-eclipse">https://github.com/ceylon/ceylon-ide-eclipse</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-ide-eclipse/issues">https://github.com/ceylon/ceylon-ide-eclipse/issues</a></td></tr>
</table>

This project contains the Ceylon IDE Eclipse plugin.

There's more info in the [README](https://github.com/ceylon/ceylon-ide-eclipse/blob/master/README.md).

### Ceylon IDE for IntelliJ

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-ide-intellij">https://github.com/ceylon/ceylon-ide-intellij</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-ide-intellij/issues">https://github.com/ceylon/ceylon-ide-intellij/issues</a></td></tr>
</table>

This project contains the Ceylon IDE IntelliJ plugin.

There's more info in the [README](https://github.com/ceylon/ceylon-ide-intellij/blob/master/README.md).

### Ceylon IDE for NetBeans

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-ide-netbeans">https://github.com/ceylon/ceylon-ide-netbeans</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-ide-netbeans/issues">https://github.com/ceylon/ceylon-ide-netbeans/issues</a></td></tr>
</table>

This project contains the Ceylon IDE NetBeans plugin. (This is currently a work in progress.)

There's more info in the [README](https://github.com/ceylon/ceylon-ide-netbeans/blob/master/README.md).

### Ceylon IDE common code

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-ide-common">https://github.com/ceylon/ceylon-ide-eclipse</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-ide-common/issues">https://github.com/ceylon/ceylon-ide-common/issues</a></td></tr>
</table>

This project contains the common code shared by the various incarnations of Ceylon IDE.

There's more info in the [README](https://github.com/ceylon/ceylon-ide-common/blob/master/README.md).

### Ceylon Web IDE

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-web-ide-backend">https://github.com/ceylon/ceylon-web-ide-backend</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-web-ide-backend/issues">https://github.com/ceylon/ceylon-web-ide-backend/issues</a></td></tr>
</table>

This project contains the Ceylon Web IDE.

There's more info in the [README](https://github.com/ceylon/ceylon-web-ide-backend/blob/master/README.md).

### Ceylon Herd

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-herd">https://github.com/ceylon/ceylon-herd</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-herd/issues">https://github.com/ceylon/ceylon-herd/issues</a></td></tr>
</table>

This project contains the Ceylon Herd application.

There's more info in the [README](https://github.com/ceylon/ceylon-herd/blob/master/README.md).

### Ceylon SDK platform modules

<table>
 <tr><th>Git repository</th><td><a href="https://github.com/ceylon/ceylon-sdk">https://github.com/ceylon/ceylon-sdk</a></td></tr>
 <tr><th>Issue reporting</th><td><a href="https://github.com/ceylon/ceylon-sdk/issues">https://github.com/ceylon-sdk/issues</a></td></tr>
</table>

This project contains the platform modules belonging to the Ceylon SDK.

There's more info in the [README](https://github.com/ceylon/ceylon-sdk/blob/master/README.md).
