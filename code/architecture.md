---
title: Architecture of Ceylon
layout: code
tab: code
unique_id: codepage
author: Gavin King
---
# #{page.title}

The Ceylon project comprises the following major subsystems:

- typechecker,
- compiler,
- launcher and module runtime,
- documentation compiler,
- IDE, and
- language module.

This architecture makes it possible to support alternate runtime 
platforms, for example, a JavaScript-based runtime, or any other 
kind of virtual machine.

Contrary to common belief, compilers aren't magical, nor even as
difficult as you probably imagine. You don't need a PhD to 
understand the Ceylon compiler.

## Typechecker

What we call the *typechecker*, which is found in the `ceylon-spec` 
repository, is actually responsible for much more than just
typechecking. It includes:

* an ANTLR-based lexer/parser,
* a typesafe syntax tree for the Ceylon language,
* a model of the types encountered in the code, and
* a type analysis engine.

The *lexer and parser* are generated from the ANTLR grammar 
defined in the file `Ceylon.g`. The parser builds a syntax 
tree representing the input source code.

The *syntax tree* is currently generated from a specification 
defined in the file `Ceylon.nodes` (but this might change in 
future). The syntax tree has a Java class that represents each
syntactic construct in the language. An instance of the tree
represents the code in a certain compilation unit.

The *model* is an abstract representation of the types that
are available to the compiler, not just in the compilation 
unit being compiled. Indeed, the compiler is even able to 
build a model for classes it encounters in precompiled
module archives. However, note that the model contains much
less information than the tree. For example, it does not
contain any information about the procedural code contained
in a class, method, or attribute.

The *type analysis engine* consists of several visitor classes
that implement the rules defined in the language specification. 
They walk the syntax tree validating all the various rules that 
correct Ceylon code must satisfy, and attaching errors to tree
nodes that fail to satisfy the rules. In addition, the type
analysis visitors build up a model of the types they encounter
in the tree, and create links from the tree to associated model 
objects. Thus, typing information is available to the compiler 
when it comes to transform the syntax tree to Java.

The typechecker has no dependencies to anything JVM-specific,
so it can be reused with other backends.

### Type analysis

Type analysis takes place in three phases. The type system 
was designed to never require more than three passes over 
the syntax tree.

1. `DeclarationVisitor` creates model objects for each named
   declaration and keeping track of the scope in which it
   occurs.
2. `TypeVisitor` analyses `import` statements and explicit 
   type declarations, and assigns types to the model objects 
   for explicitly typed declarations.
3. `ExpressionVisitor` analyses the types of expressions,
   resolves member references, reports typing errors, and 
   infers types of declarations without explicit type 
   declarations.

## Compiler

Thus, the thing we call the *compiler*, which is found in the 
`ceylon-compiler` repository, is actually just half of the 
compiler. This "compiler" actually calls the typechecker when 
it needs the syntax tree for a compilation unit.

The compiler has two main responsibilities:

* to build a model from pre-compiled binary classes that are
  found in module archives, and
* transform the Ceylon syntax tree that is produced by the
  typechecker to a Java syntax tree that is understood by
  `javac`.

Finally, the compiler hands the Java syntax tree off to `javac` 
to produce bytecode. We're essentially using `javac` as the 
world's most sophisticated bytecode library.

Since `javac` already supports incremental compilation, so does 
the Ceylon compiler.

## Launcher and module runtime

The Ceylon module runtime is based on 
[JBoss Modules](http://relation.to/Bloggers/ModularizedJavaWithJBossModules). 
The Ceylon launcher simply starts `java` and invokes the module
runtime, which loads module archives as needed.

Launcher simply bootstraps JBoss Modules via (local) module repository.
For Ceylon Runtime this are the modules needed at "bootstrap":

* Ceylon Language
* Ceylon Module Resolver
* Ceylon Runtime
* JBoss Modules (as a module info, actual classes are part of system classpath)

This is the part that the user needs locally (unless you use remote bootstrap module loader).
To ease things, we created a zipped version of bootstrap repository,
and placed it under &lt;CEYLON_REPOSITORY&gt;/ceylon-runtime-bootstrap/ceylon-runtime-bootstrap.zip
In order to use this zipped module repository we need to use custom module loader - DistributionModuleLoader.
DistributionModuleLoader explodes (if not already present) this zipped repository at initialization,
and places the exploded repository under &lt;CEYLON_REPOSITORY&gt;/ceylon-runtime-bootstrap/ceylon-runtime-bootstrap-exploded directory.
You can force an update with -Dforce.bootstrap.update=true system property flag.

Afterwards Ceylon Runtime uses Ceylon Module Resolver (CMR) to get its modules.
By default we use &lt;CEYLON_REPOSITORY&gt; as local CMR repository, but different repositories can be mounted.
 
In order to run your Ceylon app / module, you need to first place it into &lt;CEYLON_REPOSITORY&gt;.
Then you can use ceylon.sh script to run the app / module.

ceylon.sh expects module name and version as its first parameter.
e.g. ./ceylon.sh hello/1.0.0 \[full module name\]/\[version\], where default version is 0.0.0 if left out

## Documentation compiler.

The documentation compiler takes as its input the model produced 
by the typechecker. It's job is to produce HTML documentation.
There is currently no support for alternate output formats.

## IDE

The Ceylon IDE is a plugin for eclipse, and may be found in the
`ceylon-ide-eclipse` repository. It is based on 
[IMP](http://eclipse.org/imp/), which provides us with a lot of 
the infrastructure that is common to programming language
editors on Eclipse.

The Eclipse plugin is also built on top of the typechecker. It 
works directly with the syntax tree and model, which means that 
anything the typechecker knows about the source code, the IDE 
also knows. This includes types, members of types, errors, etc. 
And, of course, the IDE does not need to contain its own parser.

The IDE maintains a central model which it updates as part of 
the incremental compilation process. It also has a "forked" 
version of this model for each open Ceylon source editor. Each 
time a change is made in a source editor, a new "fork" of the 
model is produced. When the editor is saved, the central model 
is updated. 

Searching for declarations is *extremely* fast in the Ceylon IDE 
since it works against the central model, not against the text 
of the source files.

The IDE does not directly use the compiler to perform its own
work, but it does invoke the compiler as the last step of
incremental compilation.

## Language module

The language module is found in the `ceylon.language` repository.
The language module is special, because it contains types that
are used by the compiler to compile other code. Therefore, the 
language module itself can't be compiled - there is a 
chicken/egg problem where you would need to compile the language
module first, before you could compile the language module.

Furthermore, in order to achieve acceptable performance, the
language module needs to take advantage of hand-written Java
code.

Therefore, there are two implementations of the language module:

* an incomplete implementation in Ceylon, and
* a complete implementation in Java. 

Keeping the two version in sync is a rather painful process!

The language module also contains several annotations which are
used by the Ceylon compiler at compile time to reverse engineer
the model from precompiled Ceylon code in a module archive.
