---
title: "Command-line interface: attention to details"
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [tools]
---

# About the Ceylon command-line interface

We’re programmers, so let’s face it, we spend lots of time in those small obscure windows with tiny text, preferably
with a green or black background, that Hollywood movies often display scrolling a lot, really fast, you know? Terminals.

While good IDEs are required, and the [Ceylon IDE](/documentation/1.0/ide/) is a must-have for Ceylon developers, they 
can never replace a good terminal session with the proper command-line interface (CLI) tools.

Oh, I know Eclipse has good Git support and I know a few colleagues who use it for committing and branching and other
daily, nay, hourly push/pull command. But I really love my CLI when it comes to using Git, I never use Eclipse for that,
so I spend a lot of time in my terminal.

Also, it’s essential to be able to build a Ceylon project from the command-line, and not just from the IDE. Imagine trying
to build your project in a remote machine using an IDE with a remote X session? No, that doesn’t cut it, sorry.

So from the start, Ceylon had a CLI. Actually, we had a CLI before we had an IDE, but that didn’t last long. And in the
beginning we copied Java and had a few commands such as `ceylonc` to compile, and `ceylon` to run. Then we added the API
generator tool called `ceylondoc`, and very soon after that we figured we were doing something horribly wrong.

Back when Java came out in 1995 it was sorta cute and useful that all its commands started with the `java` prefix, but
after you got around to remembering what `javac` and `javadoc` stood for, you started to wonder what the hell `javap`
or `javah` could possibly mean.

Then Git came around and revolutionised not only distributed version-control, it also revolutionised command-line
interfaces. Suddenly you could start with remembering a single command called `git` and find out from here what
the full list of subcommands would be. You add `--help` and it spits out a man page. You have completion out of the
box. And everyone can write plugins very easily in just a few lines of shell script. Not only that, but most options
can be stored and retrieved in a really straightforward config file, with useful and logical lookup in your project,
then home.

It’s really a treasure trove of good ideas, and much more modern than the Java CLI we started copying. So we stopped
and rewrote our CLI to copy the Git CLI, and I have to say I’m really glad we did, because [we really have a great CLI
now](/download/).

## Discovery

> One Command to rule them all, One Command to find them,
> One Command to bring them all and in the CLI bind them
> In the Land of Terminal where the Shell lie.

We have a single command called `ceylon`, and if you do `ceylon help` or `ceylon --help` you will get the following:

<!-- try: -->
<!-- lang: none -->
    NAME
    
            'ceylon' - The top level Ceylon tool is used to execute other Ceylon tools
    
    
    SYNOPSIS
    
            ceylon --version
            ceylon [--stacktraces] [--] <command> [<command‑options...>] [<command‑args...>]
    
    
    DESCRIPTION
    
            If '--version' is present, print version information and exit. Otherwise '<tool-arguments>' should 
            begin with the name of a ceylon tool. The named tool is loaded and configured with the remaining
            command line arguments and control passes to that tool.
    
            * 'all' - Compiles ceylon modules for JVM and JS and documents them
    
            * 'compile' - Compiles Ceylon and Java source code and directly produces module and source archives 
                          in a module repository.
    
            * 'compile-js' - Compiles Ceylon source code to JavaScript and directly produces module and source 
                             archives in a module repository
    
            * 'config' - Manages Ceylon configuration files
    
            * 'doc' - Generates Ceylon API documentation from Ceylon source files
    
            * 'doc-tool' - Generates documentation about a tool
    
            * 'help' - Displays help information about other Ceylon tools
    
            * 'import-jar' - Imports a jar file into a Ceylon module repository
    
            * 'info' - Prints information about modules in repositories
    
            * 'new' - Generates a new Ceylon project
    
            * 'run' - Executes a Ceylon program
    
            * 'run-js' - Executes a Ceylon program
    
            * 'src' - Fetches source archives from a repository and extracts their contents into a source directory
    
            * 'test' - Executes tests
    
            * 'version' - Shows and updates version numbers in module descriptors
    
            See 'ceylon help <command>' for more information about a particular subcommand.
    
    
    OPTIONS
    
            --stacktraces
                If an error propagates to the top level tool, print its stack trace.
    
    
            --version
                Print version information and exit, ignoring all other options and arguments.

Yes it’s a man page, this is what is useful and will help you find your way out of the many `ceylon` subcommands we
have.

A similar thing will happen if you type `ceylon compile --help` or `ceylon help compile`.

## Completion

We ship with completion support for `bash`:

<!-- try: -->
<!-- lang:bash -->
    $ . /usr/share/ceylon/1.0.0/contrib/scripts/ceylon-completion.bash 
    $ ceylon [TAB]
    all         compile-js  doc         help        info        run         src         version     
    compile     config      doc-tool    import-jar  new         run-js      test        
    $ ceylon compile[TAB]
    compile     compile-js  
    $ ceylon compile --re[TAB]
    --rep\=       --resource\=  

As you can see, it’s quite useful, and again, that’s what you expect in this day and age.

## Documentation

The tool system that we wrote (well, mostly that Tom Bentley wrote) even allows us to generate HTML, XML and text
documentation automatically, for example, the [tool documentation pages](/documentation/current/reference/tool/ceylon/subcommands)
are entirely generated, and the man pages that we ship in the [Ceylon CLI distribution](/download/) are also generated.

## Plugins, plugins

You may not have noticed it but if you type `ceylon help` on your system, it will likely not include that line:

<!-- try: -->
<!-- lang:none -->
    [...]
    DESCRIPTION
    
            [...]
    
            * 'all' - Compiles ceylon modules for JVM and JS and documents them

And that’s because, like Git, we support CLI plugins, and `ceylon all` is a plugin I wrote for myself, that
aggregates a bunch of subcommands in a single one.

Ceylon CLI plugins are as straightforward as Git CLI plugins: any executable in your path which starts with `ceylon-`
will be picked up to be a plugin. It will be listed and documented too. If you add documentation in your plugin
it will be used.

Here’s my `ceylon-all` shell script for example:

<!-- try: -->
<!-- lang:bash -->
    #!/bin/sh
    
    USAGE='[generic options] module...'
    DESCRIPTION='Compiles ceylon modules for JVM and JS and documents them'
    LONG_USAGE='ceylon-all allows you to build the specified ceylon modules for the
    JVM and JS backends, and generates the API documentation in a single command.'
    
    . $CEYLON_HOME/bin/ceylon-sh-setup
    
    $CEYLON_HOME/bin/ceylon compile $@
    $CEYLON_HOME/bin/ceylon compile-js $@
    $CEYLON_HOME/bin/ceylon doc $@

As you can see, our CLI will use the `USAGE`, `DESCRIPTION` and `LONG_USAGE` environment variables for completion
and documentation. You only have to source the provided `$CEYLON_HOME/bin/ceylon-sh-setup` shell script to benefit
from this. Then you can run whatever you want.

## Configuration

There are a lot of options the CLI and IDE have good defaults for, such as the source path, or the output module
repository, or the list of module repositories. But when you need something different it gets tiring really fast
to have to specify them for every command, so we support configuration files just like Git, in the form of INI
files located in your project at `.ceylon/config`. If that file does not exist or a particular configuration
option is not defined in it, we will also try the user’s config in `$HOME/.ceylon/config` as a fallback.

The syntax is straightforward, take for example the `.ceylon/config` for the Ceylon SDK:

<!-- try: -->
<!-- lang:none -->
    [repositories]
    output=./modules
    lookup=./test-deps
    
    [defaults]
    encoding=UTF-8

It just specifies that the output repository is `modules`, the additional lookup repository is `test-deps`
(for test dependencies) and the source encoding is `UTF-8`.

There’s a `ceylon config` command which allows you to edit this file if you don’t want to fire up `vim` for
that, and the best part is that this config file is actually used and edited by the IDE too! So no more
hassle to keep the CLI and IDE settings in sync.

Welcome to the future! :)
