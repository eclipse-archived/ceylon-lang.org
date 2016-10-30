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
location of the source file in which it is declared. For example, if `source` 
is a source directory, and if a class named `Hello` is defined in the file 
`source/org/jboss/hello/Hello.ceylon`, then `Hello` belongs to the package 
`org.jboss.hello`.

Note that the name of the source file itself is not significant, as long as
it has the extension `.ceylon`. It's only the directory in which the source 
file is located that matters to the compiler.

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

To resolve a name collision, we can rename an imported declaration:

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
        
        Map<String,String> map = HashMap<String,String>();
        ...
    }

However, we don't especially recommend this; we prefer to use
toplevel import aliases to resolve name collisions, since this
provides much less potential for confusion:

<!-- try: -->
    import ceylon.collection { HashMap }
    import java.util { JMap = Map, JHashMap = HashMap }
    
    void usesCeylonHashMap() {
        Map<String,String> map = HashMap<String,String>();
        ...
    }
    
    void usesJavaHashMap() {
        JMap<String,String> map = JHashMap<String,String>();
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

- a well-defined public API, and an inaccessible internal 
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
* A runtime that features module isolation and the ability to manage 
  multiple versions of the same module.
* An ecosystem of remote module repositories where folks can share code 
  with others.

Ceylon's module system has two levels of granularity: packages and modules.
Each package within a module has its own namespace and well-defined API.
For many simple modules, this is overkill, and thus it's perfectly 
acceptable for a module to have just one package. But more complex
modules, with their own internal subsystems, often benefit from the 
additional level of granularity.

### Module-level visibility and package descriptors

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

### Dependencies and module descriptors

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

### Gotcha!

Unlike some other module systems such as OSGi and Maven, Ceylon does not 
support version ranges in module dependencies, and the Ceylon module system
never attempts to resolve version conflicts in transitive dependencies
automatically. Instead Ceylon requires you to _explicitly_ override 
conflicting module versions of dependencies when assembling an application.

### Tip: overriding module imports

To resolve conflicting module versions in the transitive dependencies of
a module, we can specify _module overrides_ in an XML file, usually named
`overrides.xml`. The format of this file is described in the reference 
documentation for [module overrides][].

Note that `overrides.xml` is considered a temporary stopgap measure. In a
future version of Ceylon, it will be possible to specify module overrides
using a more comfortable syntax based on the format of the module descriptor.

[module overrides]: /documentation/reference/repository/overrides/

### Module repositories

Compiled modules live in *module repositories*. A module repository is a 
well-defined directory structure with a well-defined location for each 
module. A module repository may be either local (on the filesystem) or 
remote (on the Internet).

If you've installed ceylon and compiled a program, you might already have
some module repositories on your machine:

- `ceylon-1.3.x/repo` is a repository containing the Ceylon compiler and
  all its dependencies,
- `~/.ceylon/cache` is a repository containing locally cached versions of 
  other modules you've used in your programs, and
- the `modules` directory of any Ceylon project is, by default, a repository 
  containing the compiled project modules.

Given a list of module repositories, the Ceylon compiler can automatically 
locate dependencies mentioned in the module descriptor of the module it is 
compiling. And when it finishes compiling the module, it puts the resulting 
module archive in the right place in a local module repository (`./modules`,
by default).

Likewise, given a similar list of module repositories, the Ceylon module 
runtime can automatically locate dependencies of the compiled module it is
executing.

The repository architecture also includes well-defined locations for source 
archives produced by the Ceylon compiler, and for module API documentation 
produced by the [`ceylon doc`][] command.

The Ceylon module system even interoperates with
[Maven repositories](../interop/#depending_on_a_maven_module) and
[npm](../dynamic/#importing_npm_modules_containing_native_javascript_code).

### Module tools

Ceylon comes with a suite of command-line tools for managing modules and 
module repositories, including [`ceylon copy`][], [`ceylon info`][], 
[`ceylon import-jar`][], and [more][subcommands].

[`ceylon doc`]: #{site.urls.ceylon_tool_current}/ceylon-doc.html
[`ceylon copy`]: #{site.urls.ceylon_tool_current}/ceylon-copy.html
[`ceylon info`]: #{site.urls.ceylon_tool_current}/ceylon-info.html
[`ceylon import-jar`]: #{site.urls.ceylon_tool_current}/ceylon-import-jar.html
[subcommands]: /documentation/reference/tool/ceylon/subcommands/

[Certain module repositories][default repos] are searched by default by 
these tools, by the compiler, and by the module runtime. These are:

- `$CEYLON_HOME/repo`, the distribution repository
- `~/.ceylon/cache`, the local cache, 
- `~/.ceylon/repo`, the user repository,
- `https://herd.ceylon-lang.org/repo/1`, the community repository,
- `maven:`, which refers to the maven repositories specified in
  the Maven `~/.m2/settings.xml` file, and
- `npm:`, the npm registry.

We don't need to specify these repositories explicitly. Additional 
repositories may be [specified][specifying repos] using `--rep`.

[default repos]: /documentation/1.3/reference/repository/tools/#default_repository_lookup
[specifying repos]: /documentation/1.3/reference/repository/tools/#specifying_repositories

### Tip: using a config file

You can save yourself the trouble of explicitly specifying module repositories
with `--rep`, or of explicitly overriding other defaults such as the name of
the source directory, using a [config file][] to specify settings that are 
understood by both the command line toolset and by the Ceylon IDEs.

[config file]: /documentation/1.3/reference/tool/config/

### Module repository ecosystem

One nice feature of this architecture is that it's possible to run a module 
"straight off the internet", just by typing, for example:

<!-- lang: bash -->
    ceylon run --rep http://jboss.org/ceylon/modules org.jboss.ceylon.demo/1.0

It does not matter if the program is installed locally, as long as it's
available in some accessible repository. And all required dependencies get 
automatically downloaded as needed.

This feature makes it extremely easy to distribute libraries and assemble 
applications.

[Ceylon Herd][] is a central community module repository where anyone can 
contribute reusable modules. Of course, the module repository format is an 
open standard, so any organization can maintain its own public module 
repository. You can even [run your own][run Herd] internal instance of Herd!

[Ceylon Herd]: https://herd.ceylon-lang.org
[run Herd]: https://github.com/ceylon/ceylon-herd

### Tip: developing modules in Ceylon IDE for Eclipse

A wizard to create a new module, and add its dependencies can be found
at `File > New > Ceylon Module`.

To change the dependencies of an existing module, you can select the 
module in the Ceylon Explorer, go to `File > Properties`, and select 
the `Ceylon Module` properties page. (Or, of course, you can just edit 
the module descriptor directly.)

To view the full dependency graph for a project, select the project, 
and go to `Navigate > Show In > Ceylon Module Dependencies`.  

To view or change the module repositories configured for your project,
select the project, go to `Project > Properties`, and then navigate 
to `Ceylon Build > Module Repositories`.

The Ceylon Repository Explorer helps you find modules available in 
the configured module repositories. It may be accessed via 
`Window > Show View > Ceylon Repository Explorer` when in the Ceylon
perspective.  

Under `File > Export... > Ceylon`, you'll find two very useful wizards:

- a wizard to export a Ceylon module defined in a workspace project to
  a local module repository, and
- a wizard to add a Java `.jar` archive to a Ceylon module repository.

### Tip: developing modules in Ceylon IDE for IntelliJ

To create a new module, select the source directory, and go to 
`File > New > Ceylon Module`.

To change the dependencies of a module, edit the module descriptor
directly.

To view or change the module repositories configured for your project,
go to `File > Project Structure`, navigate to `Facets > Ceylon`, and
select the `Repositories` tab.

## Compiling modules

The output of the Ceylon compiler depends upon the virtual machine platform 
we're compiling for:

- [`ceylon compile`][] compiles module archives for execution on the JVM,
- [`ceylon compile-js`][] compiles module scripts and model descriptors for
  execution on JavaScript virtual machines, and
- [`ceylon compile-dart`][] produces artifacts that can be executed on the
  Dart VM.

Finally, [`ceylon doc`][] compiles HTML-format API documentation for a 
module.

[`ceylon compile`]: #{site.urls.ceylon_tool_current}/ceylon-compile.html
[`ceylon compile-js`]: #{site.urls.ceylon_tool_current}/ceylon-compile-js.html
[`ceylon compile-dart`]: https://github.com/jvasileff/ceylon-dart
[`ceylon doc`]: #{site.urls.ceylon_tool_current}/ceylon-doc.html 

### Module archives

When compiled for execution on the Java virtual machine, using the
command `ceylon compile`, a module compiles to a _module archive_. The 
module archive packages together: 

- compiled `.class` files, 
- package descriptors, and module descriptors, and
- resources (text files, properties files, images, etc)

into a Java-style `jar` archive with the extension `.car`. 

The Ceylon compiler never produces individual `.class` files in a directory. 

A `.car` module archive also includes OSGi and Maven metadata, and service
provider configuration files for interoperation with Java's 
[`ServiceLoader`][service loader architecture]. These artifacts are 
generated automatically by the compiler without any manual intervention.

### Module scripts and model descriptors

When compiled for execution on a JavaScript virtual machine, using the 
command `ceylon compile-js`, the module compiles to:

- a `.js` file, called a _module script_, containing the executable 
  JavaScript code,
- a `-model.js` file, called the _model file_, containing a description of 
  the program elements in the module in a JSON-like format, and
- a `module-resources` directory containing resources.

The module script follows a standard called Common JS Modules, which allows 
the script to be used in [node.js][], with [require.js][], or with some 
other JavaScript module loaders.

The model file is used: 

- when code that uses the Ceylon module is compiled to JavaScript without 
  access to the source code of the library, or
- when the [metamodel][] of the module is accessed at runtime.

All the artifacts produced by the compiler are grouped together in a 
directory of the output module repository. 

[metamodel]: ../annotations/#the_metamodel
[node.js]: https://nodejs.org/
[require.js]: http://requirejs.org/


## Running modules

When we actually run a Ceylon program, our program is usually executed by
some sort of module system.

- When executing on the JVM, using [`ceylon run`][], Ceylon's module runtime 
  is based on JBoss Modules, a technology that also exists at the very core 
  of the WildFly application server.
- When executing on a JavaScript virtual machine using [`ceylon run-js`][], 
  the module runtime is the module system of [node.js][]. 
- When executed in a web browser, the module system is typically [require.js][], 
  though other options exist.
- When executing on the Dart VM via [`ceylon run-dart`][], the module runtime 
  is provided by Dart itself.

[`ceylon run`]: #{site.urls.ceylon_tool_current}/ceylon-run.html
[`ceylon run-js`]: #{site.urls.ceylon_tool_current}/ceylon-run-js.html
[`ceylon run-dart`]: https://github.com/jvasileff/ceylon-dart

Naturally, the capabilities of the module runtime vary somewhat depending on 
the virtual machine platform. The JBoss Modules-based runtime for the JVM is 
the most powerful.

Usually, the Ceylon runtime is invoked by specifying the name of a runnable 
module at the command line. But of course that can't work in a web browser,
where it's necessary to write some boilerplate JavaScript code to bootstrap
`require.js` and invoke the Ceylon module. It's even possible to execute a
Ceylon module programmatically on the JVM, using the [`Main` API][].

### Resolving dependencies at runtime

When a Ceylon module is executed via `run`, `run-js`, or `run-dart`, and 
provided with a list of module repositories using `--rep`, the runtime 
automatically locates the module archive and its versioned dependencies in 
the repositories, even downloading modules from remote repositories if 
necessary.

When a Ceylon module runs in the browser, using `require.js`, module loading
is a bit less transparent. It's up to the developer to either:

- collect together all the module artifacts into a single repository 
  accessible to `require.js`, or
- set up a proxy repository server on the server side.

To collect artifacts for a module and its dependencies, you can use
[`ceylon copy --dependencies`][`ceylon copy`]. Typically, you would
locate the resulting repository somewhere under the document root of your 
web server.

Alternatively, to set up a server-side proxy repository, you could use the 
[`RepositoryEndpoint`][] provided for this purpose by the module 
[`ceylon.http.server`][]. This requires a process executing the Ceylon
HTTP server to exist on the server side.

Finally, not every Ceylon program executes on a modular runtime. As we'll 
see [below](#repackaging_tools), Ceylon provides tooling for assembling a
Ceylon program for execution in other environments which require that 
programs be packaged as a single monolithic artifact.

[`Main` API]: /documentation/reference/interoperability/ceylon-on-jvm/
[`RepositoryEndpoint`]: #{site.urls.apidoc_current_http_server}/endpoints/RepositoryEndpoint.type.html
[`ceylon.http.server`]: #{site.urls.apidoc_current_http_server}/index.html

## Resources

To include resources in a module archive, you must place them in a 
_resource directory_, named `resource` by default, in a subdirectory
corresponding to the module. For example, resources belonging to the module 
`net.example.foo` should be located in the subdirectory 
`resource/net/example/foo` of the project directory.

The compiler is responsible for packaging resources:
 
- [`ceylon compile`][] packages resources into the module archive for the 
  module, and 
- [`ceylon compile-js`][] packages them into a directory of the module 
  repository where they're accessible to the JavaScript runtime.

At runtime, the resource may be loaded by calling [`resourceByPath()`][] on 
the `Module` object representing the module to which the resource belongs:

<!-- try: -->
    assert (exists Resource resource 
            = `module net.example.foo`
                .resourceByPath("foo.properties"));
    String text = resource.textContent();

Alternatively, you may identify the resource by a fully qualified path beginning 
with `/`, for example:

<!-- try: -->
    assert (exists Resource resource 
            = `module net.example.foo`
                .resourceByPath("/net/example/foo/foo.properties");

The contents of a text resource may be obtained using [`Resource.textContent()`][].
The URI of a binary resource may be obtained using [`Resource.uri`][].

[`resourceByPath()`]: #{site.urls.apidoc_1_3}/meta/declaration/Module.type.html#resourceByPath
[`Resource.textContent()`]: #{site.urls.apidoc_1_3}/Resource.type.html#textContent
[`Resource.uri`]: #{site.urls.apidoc_1_3}/Resource.type.html#uri


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


## There's more...

Later in the tour, we'll learn how to interoperate with
[native Java archives](../interop/#depending_on_a_java_archive),
including Java modules imported from [Maven](https://maven.apache.org/), and 
[native JavaScript modules](../dynamic/#importing_npm_modules_containing_native_javascript_code) 
imported from [npm](https://www.npmjs.com/).

Next we're going to look at Ceylon's support for [higher order functions](../functions).
