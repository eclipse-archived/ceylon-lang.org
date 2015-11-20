---
title: Contributing to the compiler backend
layout: code
tab: code
author: Stephane Epardaud
---
# #{page.title}

## Getting the source

- Make sure you have the [Java 7 JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Ant 1.8+](http://ant.apache.org/) installed and that both are working correctly (if you installed Ant using your platform's package manager make sure it installed the `ant-junit.jar` as well, which can be found in a package named `ant-junit` or `ant-optional` depending on your distribution)
- Make sure you have [Git set up correctly](https://help.github.com/articles/set-up-git)
- Create a new directory for the Ceylon project
- Open a terminal and change to the newly created directory

And now you either set things up for HTTPS access (recommended for most people):

- Clone the `ceylon` repository:

<!-- lang: bash -->
    $ git clone https://github.com/ceylon/ceylon.git
	
(If you encounter an issue like "fatal: unable to access 'https://github.com/ceylon/ceylon.git/': 
Failed connect to github.com:443; No error", make sure you've set up your proxy as git config, ie: 
<!-- lang: bash -->
	$ git config --global http.proxy http://userName:password@proxyServer:port 

that should fix it.)
	
Or you set things up for SSH access (mainly contributors with push access):

- Make sure you have [GitHub SSH access set up correctly](https://help.github.com/articles/generating-ssh-keys)
- Clone the `ceylon` repository:

<!-- lang: bash -->
    $ git clone git@github.com:ceylon/ceylon.git

After performing one of the two above cloning operations continue with the following:

- Build the complete distribution by running

<!-- lang: bash -->
    $ cd ceylon
    $ ant clean dist

After this you'll have a newly built distribution in the `dist/dist` folder of your current directory.
You can run the `ceylon` command without any further setup or installation by simply running

<!-- lang: bash -->
    $ dist/dist/bin/ceylon

But it's advisable to add the `ceylon` command to your search path (either by adding the `bin` folder to your search path or by creating a symbolic link to it in an appropriate place like `~/bin/`).

If at any time you want to update the distribution to the latest code from GitHub just run

<!-- lang: bash -->
    $ ant update
    $ ant clean dist

NB: The `update` command assumes that your projects are "clean", that is you don't have uncommitted changes.
If that's not the case you'll have to manually update those projects or first stash your changes (using `git stash`).

## Setting up Eclipse

- Import all projects you find in the `ceylon` folder into Eclipse (see [README.eclipse](https://github.com/ceylon/ceylon-compiler/blob/master/README.eclipse) in ceylon-compiler)
- Configure Eclipse's code formatting for the project's minimal [coding style](#coding_style).
- Set your default `Text file encoding` to `UTF-8` and your default `New text file line delimiter` to `Unix` in your Eclipse preferences (`Window` -> `Preferences` -> `General` -> `Workspace`). Or at least set it in the properties for each of the imported projects (Right-click on the project, select `Properties` then `Resource`).
- In Eclipse, run the unit tests: `com.redhat.ceylon.compiler.test.ConcurrentTests`

## Setting up the SDK

If you want to work on any of the SDK modules you simply clone the SDK project and build it like this:

<!-- lang: bash -->
    $ git clone https://github.com/ceylon/ceylon-sdk.git
    $ cd ceylon-sdk
    $ ant clean publish

But perhaps an easier way is to do it from the root of the `ceylon` project like this:

<!-- lang: bash -->
    $ ant setup-sdk
    $ ant clean-sk sdk

This will clone the `ceylon-sdk` repository in the parent directory of the `ceylon` project.

## Forking a project

When you have decided on which project you are going to work you'll have to fork it in GitHub.
For this example we assume you'll be working on `ceylon`.

- Go to the [Ceylon project on GitHub](https://github.com/ceylon) and click on the repository you'll be working on
- Click the `Fork` button (in the top left of the page)
- Now on the main page of your forked repository copy the **SSH** url
- Go inside the local directory that corresponds with the repository (`ceylon`) and run

<!-- lang: bash -->
    $ git remote set-url origin THE_URL_YOU_JUST_COPIED

- Test if you did it right (the result should be "Current branch master is up to date")

<!-- lang: bash -->
    $ git pull --rebase

- Add an "upstream" alias for easy remote access:

<!-- lang: bash -->
    $ git remote add upstream git@github.com:ceylon/ceylon.git

## Typical workflow

1. Check out the [list of issues](https://github.com/ceylon/ceylon/issues) for things to do.
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
1. Go to https://github.com/YOUR_GITHUB_USERNAME/ceylon
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

- Runner commands (for now a few batch/shell scripts in ceylon/compiler-java/bin to start the compiler)
- Parser (part of the ceylon/typechecker component, translates ceylon source into a ceylon tree)
- Type checker (part of the ceylon/typechecker component, checks a ceylon tree and builds its model)
- Model (part of the ceylon/model component, represents meta information about ceylon declarations and types)
- Transformer (translates a ceylon tree and model into a java tree)
- Model loader (translates compiled java and ceylon class files into a ceylon model)
- Javac (does all the rest, including type checking java source, loading class files and turning java trees into bytecode)
- Runtime (copy of the ceylon/typechecker runtime but coded in Java so we can use it without requiring the compiler to support all the features of the runtime)

The ceylon compiler is an extension of the Javac compiler, which handles both .java and .ceylon files.

The process for the code is roughly the following:

1. You invoke `ceylon/dist/dist/bin/ceylon compile`
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

We have one top-level command, `ceylon` which takes a subcommand as it's
first argument. In particular

- `ceylon compile` invokes the compiler, taking similar arguments to `javac`
- `ceylon run` runs a ceylon toplevel method, takes similar arguments to `java`
- `ceylon doc` generates documentation for ceylon files, takes similar arguments to `javadoc`

### Parser and Typechecker

They are part of the ceylon/typechecker component. Best to ask Emmanuel or Gavin about that part, or by 
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

## Coding Style

We're not very hung up about coding styles. The main requirement is that it's 
easy to read. The best piece of advice is to try to mimic the style of 
existing sources.

There are two stylistic things which will probably result 
us asking a contributor to amend a pull request:

1. Indentation should be 4 spaces (and no tabs)
1. Use of braces should follow the One True Brace Style. In other words:
    * an opening brace is always on the same line as (the last bit of) the 
      statement or declaration it's delimiting the block of, 
    * a closing brace is on a line by itself, unless
    * it is a closing brace in a clause of some larger statement, for example 
      the closing brace before an `else` clause.
      
Here's an example:

<!-- lang:java -->
    void m(int num) {
        if (num < 0) {
            // ...
        } else if (num > 0) {
            // ...
        } else {
            // ...
        }
        
    }


