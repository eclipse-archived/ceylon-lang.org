---
layout: tour
title: Tour of Ceylon&#58; Modules
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the ninth part of the Tour of Ceylon. In the 
[previous part](../missing-pieces) we looked at attributes, variables, 
control structures and a few other missing pieces. Now we turn to *modules*.


## Modules in Ceylon

Built-in support for modularity is a major goal of the Ceylon project, but 
what does 'modularity' mean? There are several layers to this:

* Language-level support for a unit of visibility that is bigger than a package, 
  but smaller than "all packages".
* A module descriptor format that expresses dependencies between specific 
  versions of modules.
* A built-in module archive format and module repository layout that is 
  understood by all tools written for the language, from the compiler, to the 
  IDE, to the runtime.
* A runtime that features peer-to-peer classloading (one classloader 
  per module) and the ability to manage multiple versions of the same module.
* An ecosystem of remote module repositories where folks can share code 
  with others.


## Module-level visibility

A package in Ceylon may be shared or unshared. An unshared package 
(the default) is visible only to the module which contains the package. 
We can make the package shared by providing a package descriptor, which is just a 
top level 
[`Package`](#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Package.html) 
attribute called `package`:

<!-- check:none:Quoted-->
    Package package {
        name = 'org.hibernate.query';
        shared = true;
        doc = "The typesafe query API.";
    }

A `shared` package defines part of the "public" API of the module. Other modules 
can directly access shared declarations in a `shared` package.


## Module descriptors

A module must explicitly specify the other modules on which it depends.
This is accomplished via a module descriptor, which is a top level
[`Module`](#{site.urls.apidoc_current}/ceylon/language/descriptor/class_Module.html) 
attribute called `module`:
 
 <!-- check:none:Quoted-->
    Module module {
        name = 'org.hibernate';
        version = '3.0.0.beta';
        doc = "The best-ever ORM solution!";
        license = 'http://www.gnu.org/licenses/lgpl.html';
        Import {
            name = 'ceylon.language';
            version = '1.0.1';
            export = true;
        },
        Import {
            name = 'java.sql';
            version = '4.0';
        }
    }

A module may be *runnable*. A runnable module must specify a `run()` method in 
the module descriptor:

<!-- check:none:Quoted-->
    Module module {
        name = 'org.hibernate.test';
        version = '3.0.0.beta';
        doc = "The test suite for Hibernate";
        license = 'http://www.gnu.org/licenses/lgpl.html';
        void run() {
            TestSuite().run();
        }
        Import {
            name = 'org.hibernate'; version = '3.0.0.beta';
        }
    }


## Module archives and module repositories

A module archive packages together compiled `.class` files, package 
descriptors, and module descriptors into a Java-style `jar` archive with the 
extension `car`. The Ceylon compiler doesn't usually produce individual 
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


## Module runtime

Ceylon's module runtime is based on JBoss Modules, a technology that also 
exists at the very core of JBoss AS 7. Given a list of module repositories, 
the runtime automatically locates a module archive and its versioned 
dependencies in the repositories, even downloading module archives from 
remote repositories if necessary.

Normally, the Ceylon runtime is invoked by specifying the name of a runnable 
module at the command line.


## Module repository ecosystem

One of the nice advantages of this architecture is that it's possible to run a 
module "straight off the internet", just by typing, for example:

<!-- lang:none -->
    ceylon org.jboss.ceylon.demo -rep http://jboss.org/ceylon/modules

And all required dependencies get automatically downloaded as needed.

Red Hat will maintain a central public module repository where the 
community can contribute reusable modules. Of course, the module repository 
format will be an open standard, so any organization can maintain its own 
public module repository. 

## There's more

Next we're going to look at Ceylons support for 
[first class functions](../functions).
