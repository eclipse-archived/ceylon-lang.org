---
layout: tour13
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
location of the source file in which it is declared. For example, is `source` 
is a source directory, and if a class named `Hello` is defined in the file 
`source/org/jboss/hello/Hello.ceylon`, then `Hello` belongs to the package 
`org.jboss.hello`.

Note that the name of the source file itself is not significant. It's only
the directory in which the source file is located that matters to the 
compiler.

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
    import com.redhat.polar.core { PolarCoord = Polar }

We think renaming is a much cleaner solution than the use of qualified 
names. We can even rename members of type:

<!-- try: -->
<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar { r = radius, theta = angle } }

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

### Tip: local `import` statements

_Warning: this subsection describes new pre-release functionality that 
will be made available in Ceylon 1.3.1._

Unlike Java, Ceylon lets you write a local `import` statement at the 
start of the body of a class, interface, or function. Local imports
are only visible within the program element in which they occur, 
instead of being visible to the whole source file.

This, local imports can be used to resolve name collisions:

<!-- try: -->
    void usesCeylonHashMap() {
        import ceylon.collection { HashMap }
        
        Map<String,String> map = HashMap<String,String>();
        ...
    }
    
    void usesJavaHashMap() {
        import java.util { Map, HashMap }
        
        Map<String,String> map = HashMap<String,String();
        ...
    }

However, we don't especially recommend this; we prefer to use
toplevel import aliases to resolve name collisions, since this
provides much less potential for confusion:

<!-- try: -->
    import ceylon.collection { HashMap }
    import java.util { JMap=Map, JHashMap=HashMap }
    
    void usesCeylonHashMap() {
        Map<String,String> map = HashMap<String,String>();
        ...
    }
    
    void usesJavaHashMap() {
        JMap<String,String> map = JHashMap<String,String();
        ...
    }

On the other hand, local `import`s are very useful when writing
[`native` code in a cross-platform module](../dynamic/#tip_defining_an_operation_with_a_native_header).


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
    license ("http://www.gnu.org/licenses/lgpl.html")
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
    license ("http://www.gnu.org/licenses/lgpl.html")
    module org.hibernate.test "3.0.0.beta" {
        import org.hibernate "3.0.0.beta";
        void run() {
            TestSuite().run();
        }
    }
-->

## Module archives and module repositories

When compiled for execution on the Java virtual machine, a module compiles
to a _module archive_. The module archive packages together compiled `.class` 
files, package descriptors, and module descriptors into a Java-style `jar` 
archive with the extension `.car`. 

A `.car` module archive also includes OSGi and Maven metadata.

The Ceylon compiler never produces individual `.class` files in a directory. 

When compiled for execution on a JavaScript virtual machine, the module
compiles to a `.js` file, called a _module script_. This module script
follows a standard called Common JS Modules, which allows the script to
be used in [node.js](https://nodejs.org/) or with 
[require.js](http://requirejs.org/).

Module archives and module scripts live in *module repositories*. A module 
repository is a well-defined directory structure with a well-defined location 
for each module. A module repository may be either local (on the filesystem) 
or remote (on the Internet). Given a list of module repositories, the Ceylon 
compiler can automatically locate dependencies mentioned in the module 
descriptor of the module it is compiling. And when it finishes compiling the 
module, it puts the resulting module archive in the right place in a local 
module repository.

The Ceylon module system may even interoperate with
[Maven repositories](../interop/#depending_on_a_maven_module) and
[npm](../dynamic/#importing_npm_modules_containing_native_javascript_code).

The repository architecture also includes support for source archives and 
module documentation directories.

### Developing modules in Ceylon IDE for Eclipse

A wizard to create a new module, and add its dependencies can be found
at `File > New > Ceylon Module`.

The Ceylon Repository Explorer may be accessed via 
`Window > Show View > Ceylon Repository Explorer` when in the Ceylon
perspective.  

To change the imports of an existing module, you can select the module 
in the Ceylon Explorer, got to `File > Properties`, and select the
`Ceylon Module` properties page.

To view the full dependency graph for a project, select the project, 
and go to `Navigate > Show In > Ceylon Module Dependencies`.  

Under `File > Export... > Ceylon`, you'll find two very useful wizards:

- a wizard to export a Ceylon module defined in a workspace project to
  a local module repository, and
- a wizard to add a Java `.jar` archive to a Ceylon module repository.

Now let's learn a little bit about using the command line.

### Examples: compiling against a local or remote repository

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

The [Ceylon Herd](https://herd.ceylon-lang.org/) is an online 
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

Or, if your module is already compiled, you can publish it using `ceylon copy`
to replicate the existing artifacts to a the output repository. 

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

### Examples: running against a local or remote repository

Let's continue the example we had before where `net.example.foo` version 1.0
was published to `http://ceylon.example.net/repo`. Now suppose you want to run 
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

The easiest case, of course, is where the module and its dependencies are all 
in available in the default repositories (such as the Herd or `~/.ceylon/repo`):

<!-- lang: bash -->
    ceylon run net.example.foo/1.0

But when you really do need to override the defaults, there's a great way to
do it just once.

### Tip: using a config file

You can save yourself the trouble of explicitly specifying module repositories
with `--rep`, or of explicitly overriding other defaults such as the name of
the source directory using a [config file](/documentation/1.3/reference/tool/config/)
to specify settings that are understood by both the command line toolset and
by the Ceylon IDEs.


## Module repository ecosystem

One of the nice advantages of this architecture is that it's possible to run a 
module "straight off the internet", just by typing, for example:

<!-- lang: bash -->
    ceylon run --rep http://jboss.org/ceylon/modules org.jboss.ceylon.demo/1.0

And all required dependencies get automatically downloaded as needed.

[Ceylon Herd](https://herd.ceylon-lang.org) is a central community module 
repository where anyone can contribute reusable modules. Of course, the module 
repository format is an open standard, so any organization can maintain its own 
public module repository. You can even run your own internal instance of Herd!


## Resources

To include resources in a module archive, you must place them in a 
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

Resources in the subdirectory `resource/net/example/foo` are packaged into the 
module archive for the module `net.example.foo`, and into a directory of the 
module repository where they're accessible to the JavaScript runtime.

At runtime, the resource may be loaded by calling 
[`resourceByPath()`](#{site.urls.apidoc_1_3}/meta/declaration/Module.type.html#resourceByPath) 
on the `Module` object representing the module to which the resource belongs:

<!-- try: -->
    assert (exists Resource resource 
            = `module net.example.foo`.resourceByPath("foo.properties"));
    String text = resource.textContent();

Alternatively, you may identify the resource by a fully qualified path beginning 
with `/`, for example:

<!-- try: -->
    assert (exists Resource resource 
            = `module net.example.foo`.resourceByPath("/net/example/foo/foo.properties");

The contents of a text resource may be obtained using
[`Resource.textContent()`](#{site.urls.apidoc_1_3}/Resource.type.html#textContent).
The URI of a binary resource may be obtained using
[`Resource.uri`](#{site.urls.apidoc_1_3}/Resource.type.html#uri).


## Services and service providers

_Services_ provide a lightweight way to achieve loose 
coupling between the client and the implementation or
implementations of an API, allowing the provider of an API
to change. 

Annotating a Ceylon class with the `service` annotation 
defines a _service provider_ for a specified _service type_.
Here, `DefaultManager` is declared as a service provider for
the service type `Manager`: 

<!-- try: -->
     service (`Manager`)
     shared class DefaultManager() satisfies Manager {}
 
Typically, the service type, service provider, and the client
of the service are defined in three separate modules. But this
is not a requirement.

Clients of a given service type may obtain a service provider 
by calling [`Module.findServiceProviders()`][].

<!-- try: -->
     {Manager*} managers = `module`.findServiceProviders(`Manager`);
     assert (exists manager = managers.first);"

This code will find the first `service` which implements 
`Manager` and is defined in the dependencies of the module in 
which this code occurs. To search a different module and its 
dependencies, specify the module explicitly:

<!-- try: -->
     {Manager*} managers = `module com.acme.manager`.findServiceProviders(`Manager`);
     assert (exists manager = managers.first);"

On the JVM, Ceylon services and service providers interoperate 
with Java's [service loader architecture][], as we'll see 
[later in the tour](../interop/#interoperation_with_javas_serviceloader).

[`Module.findServiceProviders()`]: #{site.urls.apidoc_1_3}/meta/declaration/Module.type.html#findServiceProviders
[service loader architecture]: https://docs.oracle.com/javase/8/docs/api/java/util/ServiceLoader.html


## Repackaging tools

Certain environments, for example, Java EE, or [Wildfly Swarm][],
define their own packaging format, along with a bootstrap process
that isn't compatible with `ceylon run`. In such cases, it's most 
convenient to have a _repackaging tool_ that accepts a compiled 
Ceylon module archive and repackages it for execution in the 
target environment.

At present, there are four such tools, all implemented as
plugins for the `ceylon` command:

- [`ceylon fat-jar`][] repackages a module and its dependencies
  into a single archive, for execution via the `java` command.
- [`ceylon war`][] repackages a module and its dependencies as
  a Java EE `.war` archive, for execution in a Java servlet
  engine or Java EE application server.
- [`ceylon swarm`][] repackages a module and its dependencies,
  along with the WildFly Swarm environment, for execution via
  the `java` command.
- [`ceylon jigsaw`][] deploys a module and all its dependencies 
  to a [Jigsaw][]-style `mlib/` directory.

Note that when repackaged by one of these tools, the runtime
execution, classloading, and classloader isolation model is
that of the given platform, and may not fully respect the 
semantics of Ceylon's native module system. 

[`ceylon fat-jar`]: /documentation/current/reference/tool/ceylon/subcommands/ceylon-fat-jar.html
[`ceylon war`]: /documentation/1.3/reference/tool/ceylon/subcommands/ceylon-war.html
[`ceylon jigsaw`]: /documentation/current/reference/tool/ceylon/subcommands/ceylon-jigsaw.html
[`ceylon swarm`]: https://github.com/ceylon/ceylon.swarm
[Wildfly Swarm]: http://wildfly-swarm.io/
[Jigsaw]: http://openjdk.java.net/projects/jigsaw/


## There's more

Later in the tour, we'll learn how to interoperate with
[native Java archives](../interop/#depending_on_a_java_archive),
including Java modules imported from [Maven](https://maven.apache.org/), and 
[native JavaScript modules](../dynamic/#importing_npm_modules_containing_native_javascript_code) 
imported from [npm](https://www.npmjs.com/).

Next we're going to look at Ceylon's support for [higher order functions](../functions).
