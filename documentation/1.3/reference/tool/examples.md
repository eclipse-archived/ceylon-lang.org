---
layout: reference13
title_md: 'Project layout and tooling'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

Ceylon's command line tools, accessible via the [`ceylon`](../ceylon)
work best if you follow the standard project layout.

- Ceylon source goes in the `./source` directory,
- sources go in the `./resource` directory, and
- compiler output is generated into the `./modules` directory. 

### Compiling a module with no dependencies

Let's suppose you're writing `net.example.foo`. Your project directory 
might be layed out like this:

<!-- lang: none -->
    README
    source/
      net/
        example/
          foo/
            Foo.ceylon
            FooService.ceylon
            module.ceylon
    documentation/
      manual.html

Here, the source code is in a directory called `source` (which is the 
default and saves us having to pass a `--src` command line option to 
[`ceylon compile`][]). From the project directory (the directory which 
contains the `source` directory) you can compile using the command:
    
<!-- lang: bash -->
    ceylon compile net.example.foo
    
This command will compile the source code files (`Foo.ceylon` and 
`FooService.ceylon`) into a module archive and publish it to the default 
output repository, `modules`. (You'd use the `--out build` option to 
publish to `build` instead). Now your project directory looks something 
like this:

<!-- lang: none -->
    README
    source/
      net/
        example/
          foo/
            Foo.ceylon
            FooService.ceylon
            module.ceylon
    modules/
      net/
        example/
          foo/
            1.0/
              net.example.foo-1.0.car
              net.example.foo-1.0.car.sha1
              net.example.foo-1.0.src
              net.example.foo-1.0.src.sha1
    documentation/
      manual.html

The `.src` is file is the source archive which can be used by tools such 
as the IDE, for source code browsing. The `.sha1` files each contains a 
checksum of the like-named `.car` file and can be used to detect corrupted 
archives.

### Compiling a module with dependencies

Now, let's suppose your project gains a dependency on `com.example.bar` 
version `3.1.4`. Having declared that module and version as a dependency 
in your `module.ceylon` [descriptor](#dependencies_and_module_descriptors) 
you'd need to tell `ceylon compile` which repositories to look in to find 
the dependencies. 

One possibility is that you already have a repository containing 
`com.example.bar/3.1.4` locally on your machine. If it's in your default 
repository (`~/.ceylon/repo`) then you don't need to do anything, the same 
commands will work:

<!-- lang: bash -->
    ceylon compile net.example.foo

Alternatively if you have some other local repository you can specify it 
using the `--rep` option.

The [Ceylon Herd][] is an online module repository which contains open 
source Ceylon modules. As it happens, the Herd is one of the default 
repositories `ceylon compile` knows about. So if `com.example.bar/3.1.4` 
is in the Herd then the command to compile `net.example.foo` would remain 
pleasingly short:

<!-- lang: bash -->
    ceylon compile net.example.foo

(That's right, it's the same as before.) By the way, you can disable the 
default repositories with the `--no-default-repositories` option if you 
want to.

If `com.example.bar/3.1.4` were in *another* repository, let's say 
`http://repo.example.com`, then the command would be:

<!-- lang: bash -->
    ceylon compile
      --rep http://repo.example.com 
      net.example.foo

(We're breaking the command across multiple lines for clarity here, you 
would need to write the command on a single line.) You can specify multiple 
`--rep` options as necessary if you have dependencies coming from multiple 
repositories.

### Including resources

To include resources in the module archive, you must place them in the
_resource directory_, named `resource` by default:

<!-- lang: none -->
    README
    source/
      net/
        example/
          foo/
            Foo.ceylon
            FooService.ceylon
            module.ceylon
    resource/
      net/
        example/
          foo/
            foo.properties

Resources in the subdirectory `resource/net/example/foo` are packaged into 
the module archive for `net.example.foo`.

### Compiling API documentation

You can generate API documentation using [`ceylon doc`][] like this:

<!-- lang: bash -->
    ceylon doc net.example.foo
    
This will create a the directory `modules/net/example/foo/1.0/module-doc/`
containing the HTML-format documentation.

### publishing to a local or remote repository

When you are ready, you can publish the module somewhere other people can 
use it. Let's say that you want to publish to `http://ceylon.example.net/repo`. 
You can just compile again, this time specifying an `--out` option:

<!-- lang: bash -->
    ceylon compile
      --rep http://repo.example.com 
      --out http://ceylon.example.net/repo
      net.example.foo

Or, if your module is already compiled, you can publish it using 
[`ceylon copy`][] to replicate the existing artifacts to a the output 
repository. 

<!-- lang: bash -->
    ceylon copy
      --out http://ceylon.example.net/repo
      net.example.foo/1.0

It's worth noting that by taking advantage of the sensible defaults for 
things like source code directory and output repository, as we have here, 
you save yourself a lot of typing.

### Running a module

Let's continue the example we had before where `net.example.foo` version `1.0` 
was published to `http://ceylon.example.net/repo`. Now suppose you want to 
actually run the module (possibly from another computer). 

If the dependencies (`com.example.bar/3.1.4`, from before) can be found in the 
default repositories the [`ceylon run`][] command is:

<!-- lang: bash -->
    ceylon run
      --rep http://ceylon.example.net/repo
      net.example.foo/1.0
      
You can pass options too (which are available to the program via the top level 
`process` object):

<!-- lang: bash -->
    ceylon run
      --rep http://ceylon.example.net/repo
      net.example.foo/1.0
      my options

If one of the dependencies isn't available from a default repository you will 
need to specify a repository that contains it using another `--rep`:

<!-- lang: bash -->
    ceylon run
      --rep http://ceylon.example.net/repo
      --rep http://repo.example.com
      net.example.foo/1.0
      my options

The easiest case, of course, is where the module and its dependencies are all 
available in the default repositories (such as the Herd, or `~/.ceylon/repo`):

<!-- lang: bash -->
    ceylon run net.example.foo/1.0

But when you really do need to override the defaults, there's a great way to
do it just once.

