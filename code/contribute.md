---
title: Contributing to the compiler backend
layout: code
tab: code
author: Stephane Epardaud
---
# #{page.title}

## Getting the source

1. Fork https://github.com/ceylon/ceylon-compiler
1. Clone ceylon-spec on your machine
`$ git clone git@github.com:ceylon/ceylon-spec.git`
1. Install the typechecker
`$ cd ceylon-spec; ant publish`
1. Clone ceylon-compiler on your machine
`$ git clone git@github.com:YOUR_GITHUB_USERNAME/ceylon-compiler.git`
1. Add the upstream remote:
`$ cd ceylon-compiler; git remote add upstream git@github.com:ceylon/ceylon-compiler.git`
1. Run the tests to check that everything is working (a few tests may fail)
`ant test`
1. Import both projects into Eclipse (see README.Eclipse in ceylon-compiler)
1. In Eclipse, run the unit tests: `com.redhat.ceylon.compiler.test.AllTests`

## Typical workflow

1. Check out the [list of issues](https://github.com/ceylon/ceylon-compiler/issues) for things to do.
    1. Try your luck on issues tagged `beginner` or `ceylondoc`
    1. Don't take on issues tagged `inprogress`
1. Ask on our ceylon-dev mailing list for what to do.
1. Assign the issue to you and add the `inprogress` tag
1. Create a new branch for the new feature `$ git checkout -b my-next-feature-name`
1. Fix everything
1. Make small commits, one for each functionality (ex: added this function, added new feature, added tests for new feature): `$ git add …; git commit`
    1. Possibly if you need to, use `git add -p …` to commit only parts of a file.
    1. Don't forget to mention the issue number in the commit message so it's linked to the issue
1. Once you're done with your patches, go back to the master branch to update it with the latest upstream changes: `$ git checkout master; git pull upstream master`
1. Send your updated master branch to your github fork: `$ git push`
1. Rebase your work on the latest master: `$ git checkout my-next-feature-name; git rebase master`
1. Push your branch to github: `$ git push origin my-next-feature-name`
1. Make a pull request for your branch
1. Go to https://github.com/YOUR_GITHUB_USERNAME/ceylon-compiler
1. Select your `my-next-feature-name` branch
1. Click on `Pull request`
1. Describe your work and click on `Send pull request`
1. Now the compiler team will be notified and incorporate the patches in upstream.
1. Now you can go back to your master branch and ask for new things to do: `$ git checkout master`
1. Don't forget to keep your master branch up-to-date and push it to your fork: `$ git pull upstream master; git push`
1. WHEN your work has been accepted upstream (and not before) you can delete you feature branch (locally and remotely): `$ git branch -d next-feature-name,$ git push origin :next-feature-name` 
    1. Don't forget to close the issue and remove the `inprogress` tag 

## Ceylon compiler components

These are the various major parts of the Ceylon compiler.

- Runner commands (for now a few python scripts in ceylon-compiler/bin to start the compiler)
- Parser (part of the ceylon-spec project, translates ceylon source into a ceylon tree)
- Type checker (part of the ceylon-spec project, checks a ceylon tree and builds its model)
- Model (part of the ceylon-spec project, represents meta information about ceylon declarations and types)
- Transformer (translates a ceylon tree and model into a java tree)
- Model loader (translates compiled java and ceylon class files into a ceylon model)
- Javac (does all the rest, including type checking java source, loading class files and turning java trees into bytecode)
- Runtime (copy of the ceylon-spec runtime but coded in Java so we can use it without requiring the compiler to support all the features of the runtime)

The ceylon compiler is an extension of the Javac compiler, which handles both .java and .ceylon files.

The process for the code is roughly the following:

1. You invoke bin/ceylonc
1. It calls in com.redhat.ceylon.compiler.tools.LanguageCompiler
1. That parses every ceylon file into a ceylon tree
1. LanguageCompiler's superclass calls com.redhat.ceylon.compiler.codegen.CeylonEnter
1. CeylonEnter loads compiled java classes and starts building a model (java.lang.*, ceylon.language.*, com.redhat.ceylon.compiler.metadata.java.*)
1. CeylonEnter invokes the typechecker on the ceylon trees
1. The typechecker loads more compiled classes with the help of the model loader
1. We run the transformer com.redhat.ceylon.compiler.codegen.CeylonTransformer on the ceylon trees, to produce java trees
1. We hand over the java trees to javac, which compiles them into bytecode

Now let's see each relevant part in more details

### Runner commands

We have three:

- ceylonc: invokes the compiler, takes similar arguments to javac
- ceylon: runs a ceylon toplevel method, takes similar arguments to java
- ceylond: generates documentation for ceylon files, takes similar arguments to javadoc

### Parser, Typechecker and Model

They are part of the ceylon-spec project. Best to ask Emmanuel or Gavin about that part, or by 
[filing an issue](https://github.com/ceylon/ceylon-spec/issues).

### Generator

Those are the classes in com.redhat.ceylon.compiler.codegen.*Transformer*. CeylonTransformer is the root, it has the following interesting methods:

- makeJCCompilationUnitPlaceholder() which is invoked after parsing a ceylon tree to generate an empty java tree with a reference to the ceylon tree which we'll need later.
- convertAfterTypeChecking() which is invoked by CeylonEnter and fills a java tree from a type-checked ceylon tree with its model built
- various methods for use by deleguate generators

The code generation is split in ClassTransformer, ExpressionTransformer and StatementTransformer.

The general strategy is to walk a ceylon tree using a visitor which adds support for a specific ceylon tree node (see com.redhat.ceylon.compiler.typechecker.tree.Tree) and invokes the proper transformer(Tree.Something) method on the proper Gen part.

### Model Loader

Most of the stuff is in com.redhat.ceylon.compiler.codegen.CeylonModelLoader. The trick here is to load compiled java/ceylon classes and to convert them to ceylon Model classes (com.redhat.ceylon.compiler.typechecker.model.Declaration). 

Because classes contain references to other classes which may not have been translated yet, we do this process in two phases:

- Declaration convertToDeclaration(ClassSymbol): creates a mostly-empty lazy Declaration for a given compiled class (see LazyValue, LazyClass, LazyInterface) which will be auto-completed lazily on demand when the typechecker needs the info.
- complete() which completes the lazy Declarations by looking deep into the compiled classes to generate the complete Model (for instance looking at a class's methods, attributes, super type, interfaces…)

### Tests

We have the following types of tests:

- Transformer tests: we make a test ceylon file for a single compiler feature (for instance `foo()` to test a method call), which we compile and check that the java output matches the expected java code.
- Model loader tests: we make a test ceylon file with all variations of a feature (for instance all possible ways to declare a method, or an attribute), we compile it, then we compile another ceylon file which contains a reference to declarations from the first ceylon file, which are then loaded from the compiled class, via the model loader. We then compare the typechecker's model from the first compilation with the model loader's model from the second to see if everything matches.
- Runner tests: we compile a ceylon file and run it to see if it runs
- Unit tests: we test various methods of the compiler in a classic way
- Ceylon unit tests: we write the tests in ceylon and run them.

## Typical work in Transformer

1. Find a feature to add (or find a test to fix, then skip to #4)
1. Make sure no tests exist for it (or find a failing test for it)
1. Write a test for it (find a proper place)
1. Add the `.ceylon` file for the test
1. Add the JUnit `@Test` method to invoke the test
1. Run the test
1. Look at the output, you will see the ceylon tree and the java output (unless an exception is thrown)
1. If an exception is thrown, fix the exception, commit the fix and start over
1. If not, look at the java code
1. If the java code doesn't look correct, either correct it or ask on the mailing list how to correct it
1. Save the java code to the `.src` file
1. Run the test
1. If the test passes, commit and make pull request
1. If the java code doesn't match the expected java code, then go find where it fails in the Transformer
1. If there is already a visitor method for the tree node type that fails (see the tree dump), find its transform() method to fix it
1. If not, add a visitor method for the failing tree node and a transform() method for it
1. Run the test and repeat until fixed