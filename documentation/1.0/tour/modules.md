---
layout: tour
title: Packages and modules
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the tenth part of the Tour of Ceylon. If you found the 
[previous part](../generics) on generic types a little overwhelming, don't 
worry; this part is going to cover some material which should be much easier 
going. We're turning our attention to a very different subject: modularity. 
We're going to learn about *packages* and *modules*.

## Packages and imports

There's no `package` statement in Ceylon source files. The compiler determines 
the package and module to which a toplevel program element belongs by the 
location of the source file in which it is declared. A class named `Hello` in 
the package `org.jboss.hello` must be defined in the file 
`source/org/jboss/hello/Hello.ceylon` where `source` is the source directory.

When a source file in one package refers to a toplevel program element in 
another package, it must explicitly import that program element. Ceylon, 
unlike Java, does not support the use of qualified names within the source 
file. We can't write `org.jboss.hello.Hello` in Ceylon.

The syntax of the `import` statement is slightly different to Java. To import 
a program element, we write:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar }

To import several program elements from the same package, we write:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar, pi }

To import all toplevel program elements of a package, we write:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { ... }

To resolve a name conflict, we can rename an imported declaration:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { PolarCoord=Polar }

We think renaming is a much cleaner solution than the use of qualified 
names. We can even rename members of type:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar { r=radius, theta=angle } }

Now here's a big gotcha for folks new to Ceylon.

### Gotcha!

As we're about to see, importing a program element from a different 
module is _always_ a two step process: 

1. _import the module_ containing the program element in the module 
   descriptor (`module.ceylon` file) of the module containing the 
   source file, and then
2. _import the program element_ in the source file.

One `import` statement is not enough!

In particular, this means that you _simply can't_ import a program 
element defined in a module when you're playing around with code 
occurring outside a well-defined module (code in the "default" module).

With that in mind, it's definitely time to learn how to define modules 
and dependencies between modules.


## Modularity

Modularity is of central importance to the Ceylon language. But what 
does this word even mean? Well, a program is modular if it's composed
of more than one module. Separate modules are:

- independently distributed,
- maintained by different teams, and
- released according to independent schedules.

Therefore, we can often identify the modules that comprise our program 
by looking at how the program is maintained, released, and distributed.

A module has:

- has a well-defined public API, and an inaccessible internal 
  implementation,
- a well-defined version, and
- well-defined dependencies upon versions of collaborating modules.


## The module system

There are several layers to the module system in Ceylon:

* Language-level support for a unit of visibility that is bigger than a 
  package, but smaller than "all packages".
* A module descriptor format that expresses dependencies between specific 
  versions of modules.
* A built-in module archive format and module repository layout that is 
  understood by all tools written for the language, from the compiler, 
  to the IDE, to the runtime.
* A runtime that features peer-to-peer classloading (one classloader per 
  module) and the ability to manage multiple versions of the same module.
* An ecosystem of remote module repositories where folks can share code 
  with others.

Ceylon's module system has two levels of granularity: packages and modules.
Each package within a module has its own namespace and well-defined API.
For many simple modules, this is overkill, and thus it's perfectly 
acceptable for a module to have just one package. But more complex
modules, with their own internal subsystems, often benefit from the 
additional level of granularity.


## Module-level visibility and package descriptors

A package in Ceylon may be shared or unshared. An unshared package 
(the default) is visible only to the module which contains the package. 
We can make the package shared by providing a _package descriptor_:

<!-- try: -->
<!-- check:none-->
    "The typesafe query API."
    shared package org.hibernate.query;

A `shared` package defines part of the "public" API of the module. Other 
modules can directly access shared declarations in a `shared` package.

A package descriptor must be defined in a source file named `package.ceylon`
placed in the same directory as the other source files for the package. In
this case, the package descriptor must occur in the file 
`source/org/hibernate/query/package.ceylon.`


## Dependencies and module descriptors

A module must explicitly specify the other modules on which it depends.
This is accomplished via a _module descriptor_:
 
<!-- try: -->
<!-- check:none-->
    "The best-ever ORM solution!"
    license "http://www.gnu.org/licenses/lgpl.html"
    module org.hibernate "3.0.0.beta" {
        import ceylon.collection "1.0.0";
        import java.base "7";
        shared import java.jdbc "7";
    }

A module `import` annotated `shared` is implicitly inherited by every
module which imports the module with the `shared` module `import`.

A module descriptor must be defined in a source file named `module.ceylon`
placed in the same directory as the other source files for the root package
of the module. In this case, the module descriptor must occur in the file 
`source/org/hibernate/module.ceylon.`


<!--
A module may be *runnable*. A runnable module must specify a `run()` method in 
the module descriptor:

--><!-- check:none:Quoted--><!--
    "The test suite for Hibernate"
    license "http://www.gnu.org/licenses/lgpl.html";
    module org.hibernate.test "3.0.0.beta" {
        import org.hibernate "3.0.0.beta";
        void run() {
            TestSuite().run();
        }
    }
-->

## Module archives and module repositories

A module archive packages together compiled `.class` files, package 
descriptors, and module descriptors into a Java-style `jar` archive with the 
extension `.car`. The Ceylon compiler doesn't usually produce individual 
`.class` files in a directory. Instead, it directly produces module archives.

Module archives live in *module repositories*. A module repository is a 
well-defined directory structure with a well-defined location for each module. 
A module repository may be either local (on the filesystem) or remote 
(on the Internet). Given a list of module repositories, the Ceylon compiler 
can automatically locate dependencies mentioned in the module descriptor of 
the module it is compiling. And when it finishes compiling the module, 
it puts the resulting module archive in the right place in a local module 
repository.

The architecture also includes support for source directories, source 
archives, and module documentation directories.

### Developing modules in Ceylon IDE

To get started with modules in Ceylon IDE, go to `Help > Cheat Sheets...`, 
open the `Ceylon` item, and run the `Introduction to Ceylon Modules` cheat sheet, 
which will guide you step-by-step through the process of creating a module,
defining its dependencies, and exporting it to a module repository.

The Ceylon Repository Explorer may be accessed via 
`Window > Show View > Ceylon Repository Explorer` when in the Ceylon
perspective.  

A wizard to create a new module, and add its dependencies can be found
at `File > New > Ceylon Module`.

To change the imports of an existing module, you can select the module 
in the Ceylon Explorer, got to `File > Properties`, and select the
`Ceylon Module` properties page.

Under `File > Export... > Ceylon`, you'll find two very useful wizards:

- a wizard to export a Ceylon module defined in a workspace project to
  a local module repository, and
- a wizard to add a Java `.jar` archive to a Ceylon module repository.

### Examples: Compiling against a local or remote repository

Let's suppose you are writing `net.example.foo`. Your project 
directory might be layed out like this:

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

Here, the source code is in a directory called `source` (which is the default and 
saves us having to pass a `--src` command line option to 
[`ceylon compile`](#{site.urls.ceylon_tool_current}/ceylon-compile.html)). 
From the project directory (the directory which contains the `source` directory) 
you can compile using the command
    
<!-- lang: bash -->
    ceylon compile net.example.foo
    
This command will compile the source code files (`Foo.ceylon` and `FooService.ceylon`)
into a module archive and publish it to the default output repository, `modules`.
(you'd use the `--out build` option to publish to `build` instead). Now your project 
directory looks something like this:

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

The `.src` is file is the source archive 
which can be used by tools such as the IDE, for source code browsing. The 
`.sha1` files each contains a checksum of the like-named `.car` file and can 
be used to detect corrupted archives.

You can generate API documentation using 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) 
like this:

<!-- lang: bash -->
    ceylon doc net.example.foo
    
This will create a

<!-- lang: bash -->
    modules/net/example/foo/1.0/module-doc/
    
directory containing the documentation.

Now, let's suppose your project gains a dependency on `com.example.bar` 
version 3.1.4. 
Having declared that module and version as a dependency in your `module.ceylon` 
[descriptor](#dependencies_and_module_descriptors) you'd need to tell 
`ceylon compile` which repositories to look in to find the dependencies. 

One possibility is that you already have a repository containing 
`com.example.bar/3.1.4` locally on your machine. If it's in your default 
repository (`~/.ceylon/repo`) then you don't need to do anything, the same 
commands will work:

<!-- lang: bash -->
    ceylon compile net.example.foo

Alternatively if you have some other local repository you can specify it 
using the `--rep` option.

The [Ceylon Herd](http://modules.ceylon-lang.org/) is an online 
module repository which contains open source Ceylon modules. As it happens, 
the Herd is one of the default repositories `ceylon compile` knows about. So if 
`com.example.bar/3.1.4` is in the Herd then the command to compile 
`net.example.foo` would remain pleasingly short

<!-- lang: bash -->
    ceylon compile net.example.foo

(that's right, it's the same as before). By the way, you can disable the default 
repositories with the `--no-default-repositories` option if you want to.

If `com.example.bar/3.1.4` were in *another* repository, say `http://repo.example.com`,
then the command would become

<!-- lang: bash -->
    ceylon compile
      --rep http://repo.example.com 
      net.example.foo

(we're breaking the command across multiple lines for clarity here, you would
need to write the command on a single line). You can specify multiple `--rep` 
options as necessary if you have dependencies coming from multiple repositories.

When you are ready, you can publish the module somewhere other people can use 
it. Let's say that you want to publish to `http://ceylon.example.net/repo`. 
You can just compile again, this time specifying an `--out` option

<!-- lang: bash -->
    ceylon compile
      --rep http://repo.example.com 
      --out http://ceylon.example.net/repo
      net.example.foo

It's worth noting that by taking advantage of the sensible defaults for 
things like source code directory and output repository, as we have here, 
you save yourself a lot of typing.

## Module runtime

Ceylon's module runtime is based on JBoss Modules, a technology that also 
exists at the very core of JBoss AS 7. Given a list of module repositories, 
the runtime automatically locates a module archive and its versioned 
dependencies in the repositories, even downloading module archives from 
remote repositories if necessary.

Normally, the Ceylon runtime is invoked by specifying the name of a runnable 
module at the command line.

### Examples: Running against a local or remote repository

Let's continue the example we had before where `net.example.foo` version 1.0
was published to http://ceylon.example.net/repo. Now suppose you want to run 
the module (possibly from another computer). 

If the dependencies (`com.example.bar/3.1.4` from before) can be 
found in the default repositories the 
[`ceylon run`](#{site.urls.ceylon_tool_current}/ceylon-run.html) command is:

<!-- lang: bash -->
    ceylon run
      --rep http://ceylon.example.net/repo
      net.example.foo/1.0
      
You can pass options too (which are available to the program via the 
top level `process` object):

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

The easiest case though, is where the module and its dependencies are all in one 
(or more) of the default repositories (such as the Herd or `~/.ceylon/repo`):

<!-- lang: bash -->
    ceylon run net.example.foo/1.0


## Module repository ecosystem

One of the nice advantages of this architecture is that it's possible to run a 
module "straight off the internet", just by typing, for example:

<!-- lang: bash -->
    ceylon run --rep http://jboss.org/ceylon/modules org.jboss.ceylon.demo/1.0

And all required dependencies get automatically downloaded as needed.

[Ceylon Herd](http://modules.ceylon-lang.org) is a central community module 
repository where anyone can contribute reusable modules. Of course, the module 
repository format is an open standard, so any organization can maintain its own 
public module repository. 

## There's more

Next we're going to look at Ceylon's support for [higher order functions](../functions).
