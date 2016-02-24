---
layout: reference12
title_md: Ceylon project structure
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

By default the Ceylon tools look for source files and modules in a predefined
set of directories. We'll list them here and give an explanation what each of
them is for. Below is an example project layout for the ficticious module
`com.example.thing`:

<!-- lang: none -->
    ./source/com/example/thing/module.ceylon
    ./source/com/example/thing/package.ceylon
    ./source/com/example/thing/run.ceylon
    ./doc/com/example/thing/index.html
    ./doc/com/example/thing/logo.png
    ./resource/com/example/thing/values.json
    ./resource/com/example/thing/ROOT/META-INF/MANIFEST.MF
    ./script/com/example/thing/ceylon-thing.plugin
    ./modules/com/example/thing/1.0/com.example.thing-1.0.car
    ./modules/com/example/thing/1.0/com.example.thing-1.0.js
    ./modules/com/example/thing/1.0/com.example.thing-1.0.scripts.zip
    ./modules/com/example/thing/1.0/module-doc/
    ./modules/com/example/thing/1.0/module-resources/com/example/thing/valus.json
    ./modules/com/example/thing/1.0/module-resources/META-INF/MANIFEST.MF
    ./.ceylon/config

This might seem like quite a list, but of all these directories only `source` is
actually required and the `modules` directory is generated for you by the Ceylon
tools. The others you add only when actually needed.

So what are all these directories for? Let's start from the top:

### The `source` directory

This is obviously the most important of all, without this there's no code to
compile and therefore no code to run. In general you should always divide your
code into "modules" (see [Packages and modules](../../../tour/modules/) for more
information).

So if your module is called `com.example.thing`, as in our example
here, then the code must be located inside a set of nested directories following
the structure of the name. In this case starting from the first element `com`,
then inside that must be a directory called `example` and finally, inside that
one, we have `thing`, which will give us:

<!-- lang: none -->
    ./source/com/example/thing

A module needs at least a `module.ceylon` file to describe the module itself
and often has a `package.ceylon` file too. And finally it will need at least a
single `.ceylon` file containing the actual code (the `run.ceylon` in our example).
Putting that all together gives us the same result as the first list at the top:

<!-- lang: none -->
    ./source/com/example/thing/module.ceylon
    ./source/com/example/thing/package.ceylon
    ./source/com/example/thing/run.ceylon

By default the tools that deal with sources (mainly the compilers) look for them
in the `./source` folder of your project, but you can override this by specifying
one or more `--source` arguments.

### The `doc` directory

Ceylon sources may contain inline documentation as explained in the
[Adding inline documentation](../../../tour/basics/#adding_inline_documentation)
section of the tour. And that documentation will be processed by the
[`ceylon doc`](../ceylon/subcommands/ceylon-doc.html) tool and stored in the
`modules` directory (`./modules/com/example/thing/1.0/module-doc/` in our
example).

But it's also possible to add *additional* documentation that isn't part of
the source code. You do this by adding the files that make up your documentation
to a `doc` directory in your project. This directory is not required so if it
doesn't exist yet you may have to create it.

The structure of that directory follows the same rules as for
[`source` directories](#the_source_directory), so in our example that is:

<!-- lang: none -->
    ./doc/com/example/thing

The documentation you store in that directory can be anything you like:
plain text files, HTML files, images, PDFs, etc. They will all just end up
being copied to the `modules` directory.

NB: The inline source documentation is called "API documentation" and will be
stored in `.../module-doc/api` (`./modules/com/example/thing/1.0/module-doc/api`
in our example) while the documentation coming from the `doc` folder is
called "User documentation" and will be stored in `.../module-doc/doc`
(`./modules/com/example/thing/1.0/module-doc/doc` in our example).

By default the tools that deal with documentation (mainly [`ceylon doc`](../ceylon/subcommands/ceylon-doc.html))
look for them in the `./doc` folder of your project, but you can override
this by specifying one or more `--doc` arguments.

### The `resource` directory

Resources are files that are accessible by Ceylon code at runtime. How to access
resources from code is explained in the documentation for the
[`Resource` type](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.1/module-doc/api/Resource.type.html).

The structure of the `resource`  directory follows the same rules as for
[`source` directories](#the_source_directory), so in our example that is:

<!-- lang: none -->
    ./resource/com/example/thing

The files stored in a `resource` directory can be anyting you like: text files of any
type, images, etc. They will all just end up being copied to the `modules` directory.
Some compilers, like the [JVM backend compiler](../ceylon/subcommands/ceylon-compiler.html),
will also include the resources directly in the executable code they generate.

It's exactly for the JVM backend that a special directory exists, named `ROOT`, whose
contents gets treated a little different. Any files in that directory in your module's
resource directory get moved to the "root" of the output. So given the example above:

<!-- lang: none -->
    ./resource/com/example/thing/values.json
    ./resource/com/example/thing/ROOT/META-INF/MANIFEST.MF

the actual result of those files being copied to the `modules` directory is:

<!-- lang: none -->
    ./modules/com/example/thing/1.0/module-resources/com/example/thing/valus.json
    ./modules/com/example/thing/1.0/module-resources/META-INF/MANIFEST.MF

Now for the `modules` folder this isn't really that interesting, but it also means
that the `META-INF/MANIFEST.MF` file ends up exactly in the right place in the
resulting `.car` file used by the Ceylon JVM runtime (CAR files are basically just
Java JAR files with a different name and if you have dealt with them you will probably
know about the importance of the `META-INF` directory inside them).

By default the tools that deal with resources (mainly the compilers) look for them
in the `./resource` folder of your project, but you can override this by specifying
one or more `--resource` arguments.

Also the special treatment of the `ROOT` sub directory by default can be changed
using the `--resource-root` option and passing it the name of the folder you want
to treat as "root" instead,

### The `script` directory

If your module integrates with the `ceylon` command to provide it with new
capabilities, as described in the [Ceylon CLI plugin](../plugin/) section
of the reference, its plugin files must be located in the `./script` directory
of your project.

As with [`source` directories](#the_source_directory) the directory structure
must follow the name of your module. So for our example:

<!-- lang: none -->
    ./script/com/example/thing

And then inside that directory you will either have a `ceylon-mything.plugin` file
or a couple of `ceylon-mything` and `ceylon-mything.bat` command files (possibly
with other supporting files, depending on your needs).

The [`ceylon plugin pack`](../ceylon/subcommands/ceylon-doc.html) command
will pack all the plugin files in a ZIP file, `com.example.thing-1.0.script.zip`
in our example, and store it in the `modules` directory.

If you install this plugin using [`ceylon plugin install`](../ceylon/subcommands/ceylon-doc.html)
your `ceylon` command will have gained a new sub-command named `mything` which you
could execute with `ceylon mything`.

NB: In the text above the plugin name is always referred to as `mything` but this
is just an example, it could be anything you like.

By default the tools that deal with documentation (mainly [`ceylon plugin`](../ceylon/subcommands/ceylon-plugin.html))
look for them in the `./script` folder of your project, but you can override
this by specifying one or more `--script` arguments.

### The `modules` directory

All the directories mentioned above are "input" directories: their files are taken
and processed into something else which in the end will make up what we call a
"Ceylon Module", be it executable code or documentation or resources.

In contrast the `modules` directory is an "output" directory: it's where all the
generated files end up after they have been compiled or packed or otherwise processed.

As with [`source` directories](#the_source_directory) the directory structure
follows the name of the modules being created. So in our example:

<!-- lang: none -->
    ./modules/com/example/thing

If you then look at what was described for each of the above directories, what their
inputs are and what they generate, you end up with the following list that matches
what was shown at the very top:

<!-- lang: none -->
    ./modules/com/example/thing/1.0/com.example.thing-1.0.car
    ./modules/com/example/thing/1.0/com.example.thing-1.0.js
    ./modules/com/example/thing/1.0/com.example.thing-1.0.scripts.zip
    ./modules/com/example/thing/1.0/module-doc/api/
    ./modules/com/example/thing/1.0/module-doc/doc/
    ./modules/com/example/thing/1.0/module-resources/com/example/thing/valus.json
    ./modules/com/example/thing/1.0/module-resources/META-INF/MANIFEST.MF

Running the compilers [`ceylon compile`](../ceylon/subcommands/ceylon-compile.html) and
[`ceylon compile-js`](../ceylon/subcommands/ceylon-compile-js.html) will have generated
the two executable artifacts `.car` and `.js` as well as the `module-resources`
directory.
The documentation compiler [`ceylon doc`](../ceylon/subcommands/ceylon-doc.html) will
have created the `module-doc` directory (with its `api` sub directory and possibly a
`doc` sub directory if the user provided extra documentation).
And finally the [`ceylon plugin pack`](../ceylon/subcommands/ceylon-plugin.html) command
created the `.scripts.zip` file.

By default the tools that generate output will store that output in in the `./modules`
folder of your project, but you can override this by specifying an `--out` argument.

### The `.ceylon` directory

The normally hidden `.ceylon` directory is not an "input" directory like most of the above
nor is it an "output" directory like `modules`, it's more like a "control" directory that
can influence and change the workings of the tools that are executed in the project directory.

The most important file it contains is `config` which can contain configuration and preferences
for all of the [`ceylon` command tools](../ceylon/subcommands/). Its format and many of
its possible settings are explained in [Ceylon toolset configuration](../config).

