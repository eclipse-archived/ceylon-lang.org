---
layout: reference13
title_md: Ceylon CLI plugin
tab: documentation
unique_id: docspage
author: Stef Epardaud
doc_root: ../../..
---

# #{page.title_md}

The ceylon tools use a `git`-like plugin scheme for declaring new subcommands.

## What is a Ceylon CLI plugin?

If you have any executable in your path (`$PATH` on Unices, `%PATH%` on Windows) whose
name starts with `ceylon-` and is executable, then the `ceylon` command will detect it
and make it available as a subcommand.

For example, the `ceylon-format` executable will be picked up by the `ceylon` CLI tool
as a `format` subcommand, which means you can invoke it with `ceylon format`:

<!-- lang:shell -->
    $ ceylon --help format
    NAME
    
            'ceylon format' - format Ceylon source code
    
    
    SYNOPSIS
    
            ceylon format [OPTION]... ( FILE [--and FILE]... [--to FILE] )...
    ...

## Installing new CLI plugins

You can install the CLI plugin scripts packaged for the module `ceylon.formatter` with:

<!-- lang:shell -->
    $ ceylon plugin install ceylon.formatter/1.2.1

This will install the `ceylon-format` plugin script to `~/.ceylon/bin/ceylon.formatter/ceylon-format`
where the ceylon CLI will look for plugins, as well as from your `PATH` environment variable.

Naturally, you can also manually install plugins in your `PATH`.

You can list every plugin installed with:

<!-- lang:shell -->
    $ ceylon plugin list
    ceylon-build (ceylon.build.engine)
    ceylon-format (ceylon.formatter)

And finally, you can uninstall plugins with:

<!-- lang:shell -->
    $ ceylon plugin uninstall ceylon.formatter

## Writing Ceylon CLI plugins

Suppose we want to write a `compile-doc` plugin which runs the JVM and JS compilers, then the
API documentation.

We actually have two options: using a "command scripts" or a "plugin file".

### Using command scripts

Command scripts are OS dependent, they use shell scripts on Unix-derived systems like Linux
and MacOS and they use batch files on Windows.

We will start with Unices and create a file `ceylon-compile-doc`, with the following
contents:

<!-- lang:shell -->
    #!/bin/sh
    
    USAGE='[any option valid for compile, compile-js and doc]'
    DESCRIPTION='Runs both compilers and the doc tool'
    LONG_USAGE='This will run the `compile`, `compile-js` and `doc` subcommands.
    
    OPTIONS
    
    Any option that is accepted by all of the `compile`, `compile-js` and `doc`
    subcommands.'
    
    . $CEYLON_HOME/bin/ceylon-sh-setup
    
    $CEYLON compile $@
    $CEYLON compile-js $@
    $CEYLON doc $@

As you can see, you need to specify a number of shell variables:

- `USAGE` will be used to document the command-line arguments your plugin accepts,
- `DESCRIPTION` will be used to describe your plugin in `ceylon --help`, and
- `LONG_USAGE` will be used to document your plugin in `ceylon compile-doc --help`.

These variables will then be used in the `ceylon-sh-setup` script which you should invoke,
which will handle exiting from your script when there are `--help` parameters on the command-line
to pass them back to the command-line system.

Once you’ve defined those documentation variables and invoked the `ceylon-sh-setup` script, you can
what you want in the script.

On Windows, your script will be named `ceylon-format.bat` and look like:

<!-- lang:shell -->
    @echo off
    set "USAGE=[any option valid for compile, compile-js and doc]"
    set "DESCRIPTION=Runs both compilers and the doc tool"
    set "LONG_USAGE=This will run the `compile`, `compile-js` and `doc` subcommands."
    set "LONG_USAGE=%LONG_USAGE%"
    set "LONG_USAGE=%LONG_USAGE%OPTIONS"
    set "LONG_USAGE=%LONG_USAGE%"
    set "LONG_USAGE=%LONG_USAGE%Any option that is accepted by all of the `compile`, `compile-js` and `doc`"
    set "LONG_USAGE=%LONG_USAGE%subcommands."
    
    call %CEYLON_HOME%\bin\ceylon-sh-setup.bat %*
    
    if "%errorlevel%" == "1" (
        exit /b 0
    )
    %CEYLON% compile %*
    %CEYLON% compile-js %*
    %CEYLON% doc %*



#### Environment variables given to your script

There are a number of predefined environment variables that the `ceylon` CLI will pass to your
script:

- `CEYLON_HOME` will point to the Ceylon distribution root folder,
- `JAVA_HOME` will point to the current JDK/JRE root folder,
- `CEYLON_VERSION_MAJOR` contains the current Ceylon version major part (`Maj` in `Maj.Min.Rel`),
- `CEYLON_VERSION_MINOR` contains the current Ceylon version minor part (`Min` in `Maj.Min.Rel`),
- `CEYLON_VERSION_RELEASE` contains the current Ceylon version release part (`Rel` in `Maj.Min.Rel`),
- `CEYLON_VERSION` contains the current Ceylon version major part (`Maj.Min.Rel (Name)`),
- `CEYLON_VERSION_NAME` contains the current ceylon version code name,
- `SCRIPT` is the absolute path to your plugin script, and
- `SCRIPT_DIR` is the absolute path to the directory containing your plugin script. 

### Using plugin files

Plugin files are used when the code you're trying to run is available as a Ceylon module and
contains at least one class that implements the `com.redhat.ceylon.common.tools.Tool` interface.
Right now the best way to learn how to write a command using `Tool` is to look at the
[Ceylon tools](https://github.com/eclipse/ceylon/tree/master/compiler-java/src/com/redhat/ceylon/tools)
included in the distribution.

Writing the plugin file itself is easier luckily: you just need a simple text file, in the case
of our example called `ceylon-compile-doc.plugin` with the following contents:

<!-- lang: none -->
    summary=Runs both compilers and the doc tool
    module=your.module/1.0.0
    ;class=your.module.CeylonCompileDocTool # This is the default

The first line contains the summary, a short description of the plugin that will show up in the
list of available commands when you just type `ceylon` without any arguments or when you type
`ceylon --help`.

The second line is the name and version of the module that contains the code for your plugin.

And the last line is the fully qualified name of the class that is the entry point of your
plugin. This class *must* implement the above mentioned `com.redhat.ceylon.common.tools.Tool`
interface. You can leave this line out (or comment it out as in this example) if the name
adheres to the correct rules (basically you start with the plugin file name, remove the
`.plugin` extension, remove all the dashes and capitalize the separate words and add `Tool`
on the end. So `ceylon-compile-doc.plugin` becomes `CeylonCompileDocTool`.)

## Packaging scripts to make them available for users

CLI plugin scripts for the module `your.module` should be put in the `script/your/module` folder 
by convention, although you can override this with the `--script` option.

You can generate a script package for the module `your.module` with:

<!-- lang:shell -->
    $ ceylon plugin pack your.module

Naturally, you can publish your plugins as part of your module to Herd, so that they are available to
users.

