---
title: How we test Ceylon
author: Stéphane Épardaud
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Writing a new language is a lot about the ideas that go into the language, and then a lot about implementation.

In the case of Ceylon, a lot of effort went into thinking, discussions, negotiations, explanations, and eventually
trying and documentation, in the form of a specification. Then there's work to be done on the AntLR grammar, the Abstract
Syntax Tree (AST) that the parser/lexer give us, and then the typechecking phase until finally we get to the backend
(backends, in our case: Java bytecode and JavaScript).

But we're not stopping at the language, we're also developing a whole SDK, with an API, tools (`ceylond`, `ceylonc`,
`ceylon`), a module system, and an IDE.

Naturally, while we're in the process of implementing all this stuff, we spend a fair amount of time discovering new
problems, new solutions, and refactoring a lot of code to make it fitter. The number of interdependent pieces in all
this — and the expectation of high-quality — is such that we have to have a proper test suite for these things and,
rest assured: we do. If you've ever wondered how new languages are tested, read on to see how we test the Ceylon
implementation.

## Type-checker and parser tests

The first tests in the tool chain concern the very early phase of compiling Ceylon: checking that good code compiles,
bad code does not compile, and that the type system reasons about types the way we expect it to. We currently have 
1251 such checks, quite smartly done using compiler annotations such as `@error` to mark an AST node where we expect
an error, and `@type["Foo"]` to make sure the AST node is of type `Foo`. 

Here is a brief example where we make sure we can't return a value from a `void` method:

    void cannotReturnValue() {
        if ("Hello"=="Goodbye") {
            @error return var;
        }
    }

And another example where we make sure that the type inference is correct:

    @type["Sequence<String>|Sequence<Integer>"] value ut = f({ "aaa" },{ 1 });

The tests will walk the AST and when they see one of these annotations, they check that an error is
reported on the node, or that the node type is as we expected.

## Java bytecode generation tests

In the Java bytecode compiler backend, we generate Java bytecode, but as [previously described](/blog/2011/12/08/let-it-work/)
we are plugged in the `javac` compiler, and we feed it (pseudo-) Java AST. This turns out to be again very useful since
it's much easier to compare Java source code than byte code (for humans). So we have tests that try to compile a small Ceylon
file, typically one per feature, and then we compare the Java code generated with the Java code we expect. For example, to make
sure we can create a class in Ceylon, we write this test:

    class Klass() {}

And we see if it generates the following Java code:

<!-- lang: java -->
    package com.redhat.ceylon.compiler.java.test.structure.klass;

    class Klass {
        Klass() {
        }
    }

We currently have around 250 tests like these. This might seem a small number, but it's the number of files we're comparing,
so for example when we test numeric operation optimisation, we have one test with 350 lines of Ceylon numeric operator tests
to be tested. We have 100% coverage of the each feature promised on the roadmap.

Of course, occasionally we have bugs for things that are corner cases, so for each bug reported we have one such test as well.

## Model loader tests

The compiler is not only generating bytecode, though. It's also loading bytecode. By the truck-load. Since it's an incremental
compiler, it needs to be able to load compiled Ceylon bytecode and map it into a model that the type-checker can work with. The
piece that loads bytecode (using three different reflection libaries: Javac, Java Reflection and Eclipse JDT) is called the
_model loader_.

Those get their own tests. We write two files. The first includes code we will compile:

    shared class Klass() {
    }

And the second will reference declarations from the first file:

    Klass klass = Klass();

But because we compile the second one on its own, it will load the model for the first file from the compiled bytecode
(incremental compilation). The test
will then compare the model representation for `Klass` that we got during the first compilation (when we were compiling `Klass`)
with the model representation we loaded for `Klass` during the second compilation. The first model will come directly from the
typechecker after parsing the AST, while the second will come from the model loader. By walking both recursively and checking
that they are completely equivalent, we ensure that we produce the right model when loading it from bytecode.

We have currently 11 such tests, but once again, do not be fooled by the low number of tests here, there's only a certain number of
things we can test here: class, interface, method, attribute declarations and their signatures. We're not testing things like 
statements or expressions, only signatures of declarations. And for each declaration we have recursive tests that check every
property of the model object (of which there are many).

Incidentally, we don't just load Ceylon bytecode, we also load Java bytecode, for interoperability with Java classes, and since
the `ceylon.language` module is currently hand-written in Java, none of the Ceylon code could be compiled if the model loader wasn't
able to load a model from its bytecode. So it gets a lot of testing everywhere.

## Interoperability tests

As I mentioned previously, Ceylon is fully interoperable with Java, so we have tests that make sure that we can import Java modules,
packages, types, call their methods, read their fields, implement Java interfaces, etc…

We currently have 10 tests for this, each including all the variations on a theme (static methods, fields, constructors…).

## Recovery tests

We have a few tests to make sure the compiler backend doesn't crash on unparseable input, or on Ceylon code that is improperly typed.

## Module system

We have 34 tests that make sure that the compiler produces `.car` files, source archives and MD5 checksums in the right place, that it
can save and find them back locally, or via HTTP, that we can load `.jar` modules, and that we they contain what is expected. We also
test that we can resolve dependency graphs, cache HTTP files and check the MD5 checksums.

## Runtime behaviour tests

> However beautiful the strategy, you should occasionally look at the results — Sir Winston Churchill

We have about tests that make sure that we can invoke the Ceylon compiler, on any number of files, including incrementally. We test
that we can run Ceylon programs. We also test that the runtime behaviour of statements is correct (it's not enough to check that the 
`for` loop is compiled to a certain Java bytecode, we want to make sure it runs as we think it should).

## Tool tests

We have a few tests that check that `ceylond` (our documentation generator) is able to produce documentation, and that it produces it
correctly, while using the model loader (using Java Reflection, unlike the compiler which uses Javac Reflection).

We have a few manual tests (we need to automate that) to check that our ant tasks run as expected.

## `ceylon.language` tests

Last but not least, we have 633 runtime tests written in Ceylon that check that the `ceylon.language` API behaves as expected, which
is the ultimate test, since it effectively requires all the pieces previously described to work in order to do anything.

We even have one test which attemps to compile the Ceylon reference implementation of `ceylon.language`, which the typechecker handles,
but the backend doesn't yet. Once that one passes, we'll be ready for Ceylon 1.0.

# About speed

I've recently had a discussion about the speed of test execution with the Ceylon team, and was shocked to discover that while I was
complaining that the Java backend compiler was taking 40 seconds to run, some of my colleagues had to wait more than 2 minutes for the
same tests!

We're now looking at running some of those tests in parallel to speed things up on multi-core systems, but unfortunately it doesn't
look like we'll be able to run them in parallel using Eclipse. We should be able to do it using Ant, though.

# On breaking tests

We break tests all the time. Most of the time when we fix a bug or add a feature we break a given number of tests. Sometimes we fix
a bigger bug and break most of the tests. This is great: we can find the cause of the breakage straight away thanks to all these
tests. Sometimes though, it takes a [little bit of work](https://plus.google.com/u/0/103036382695763273919/posts/J2pzscRCYxJ) 
to fix the tests we broke :)

# Conclusion

We've an awful lot of tests, and we test (almost) everything. Those that are missing will get automated as soon as possible so we can
forget about them, because that's what tests are for: when we fix a bug or add a feature, we know it works, and we know we didn't break
anything. This is both priceless and fundamental for a new language.
