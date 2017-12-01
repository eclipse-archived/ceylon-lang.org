---
title: ceylon.test new and noteworthy
author: Tom&#225;&#353; Hradec
layout: blog
unique_id: blogpage
tab: blog
tags: [test, tools, progress]
---

Module [ceylon.test](https://herd.ceylon-lang.org/modules/ceylon.test) 
(simple framework for writing repeatable tests) is an integral part of 
Ceylon SDK since its first version and in the latest release 1.2.1 
brings several handy new features, namely:

* [Parameterized tests](#parameterized_tests)
* [Conditional execution](#conditional_execution)
* [Grouped assertions](#grouped_assertions)
* [Tagging and filtering](#tagging_and_filtering)
* [Extension points](#extension_points)
* [Reporting](#reporting)

Let's look at them in more details.

<br>

## Parameterized tests

Parameterized tests allow developers to run the same test over and over 
again using different values, where each invocation of a test function is 
reported individually. A classical example for usage of parameterized tests 
is with a function computing Fibonacci numbers.

<!-- try: -->
    shared {[Integer, Integer]*} fibonnaciNumbers => 
        {[1, 1], [2, 1], [3, 2], [4, 3], [5, 5], [6, 8] ...};
 
    test
    parameters(`value fibonnaciNumbers`)
    shared void shouldCalculateFibonacciNumber(Integer input, Integer result) {
        assert(fibonacciNumber(input) == result);
    }

In this example, we use annotation [`parameters`][] to specify the source of argument 
values, which will be used during test execution. You can use any top level value 
or unary function with a compatible type as the source of argument values. The argument 
provider can be specified for the whole function, as in this example, or individually 
for each parameter, then the test framework will execute the test for each combination 
of provided values. For example, a function with one parameter whose argument provider 
yields two values and a second parameter whose argument provider yields three values, 
will be executed six times.

This functionality is based on a general mechanism, which can be easily extended, 
e.g. serving values from data file or randomized testing. For more information see 
documentation to [`ArgumentProvider`][] and [`ArgumentListProvider`][].

[`parameters`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#parameters
[`ArgumentProvider`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/ArgumentListProvider.type
[`ArgumentListProvider`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/ArgumentListProvider.type

<br>

## Conditional execution

In some scenarios, the condition if the test can be reliable executed is known only in 
runtime. For this purpose it is useful to be able explicitly declare those _assumption_, 
as for example in following test. When the assumption is not met, verified with 
[`assumeTrue()`][] function, then the test execution is interupted and the test is 
marked as _aborted_. 

<!-- try: -->
    test
    shared void shouldUseNetwork() {
        assumeTrue(isOnline);
        ...
    }

Alternatively, it is possible to specify test condition declaratively, via custom 
annotation which satisfy SPI interface [`TestCondition`][]. In fact the [`ignore`][] 
annotation is just simple implementation of this concept.

[`assumeTrue()`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#assumeTrue
[`TestCondition`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/TestCondition.type.html
[`ignore`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#ignore

<br>

## Grouped assertions

Sometimes you don't want to interrupt your test after first failed assertions, 
because you are interested to know all possible failures. In that case you can 
use [`assertAll()`][] function, which will verify all given assertions and any 
failures will report together.

<!-- try: -->
    assertAll([
        () => assertEquals(agent.id, "007"),
        () => assertEquals(agent.firstName, "James"),
        () => assertEquals(agent.lastName, "Bond")]);

[`assertAll()`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#assertAll

<br>

## Tagging and filtering

Test functions/methods and their containers (classes, packages) can be tagged, 
via annotation [`tag`][]. For example, a test which is failing randomly for 
unknown reasons can be marked as _unstable_.

<!-- try: -->
    test
    tag("unstable")
    shared void shouldSucceedWithLittleLuck() { ... }

Those tags can later be used for filtering tests. Either in inclusive style 
(only tests _with_ specified tag will be executed).

<!-- lang: bash -->
    $ceylon test --tag=unstable com.acme.mymodule

Or visa versa for exclusion (only tests _without_ specified tag will be executed).

<!-- lang: bash -->
    $ceylon test --tag=!unstable com.acme.mymodule

[`tag`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#tag

<br>

## Extension points

Extension points are general mechanisms which allow to extend or modify default 
framework behavior and better integration with 3rd party libraries (e.g. custom 
reporters, integration with DI frameworks). The easiest way to register extensions 
is with annotation [`testExtension`][], which can be placed on test itself, or on any 
of its container. Currently the following extension points are available, and new 
ones can be added if needed:

* listening events during test run 
  [TestListener](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/TestListener.type.html)
* creating test class instance 
  [TestInstanceProvider](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/TestInstanceProvider.type.html)
* post processing of test class instance 
  [TestInstancePostProcessor](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/TestInstancePostProcessor.type.html)
* describing parameterized test 
  [TestVariantProvider](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/TestVariantProvider.type.html)
* resolving all possible argument lists combination for parameterized test 
  [ArgumentListResolver](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/engine/spi/ArgumentListResolver.type.html)

[`testExtension`]: https://modules.ceylon-lang.org/repo/1/ceylon/test/1.2.1/module-doc/api/index.html#testExtension

<br>

## Reporting

These two last features have already been available for some time, but they could easily 
have slipped your attention. The first is nice html report with results of test execution, 
to enable it, run the test tool with `--report` option, it will be generated 
under `report/test(-js)` subdirectory.

<img src="/images/screenshots/ceylon-test-html-report.png" style="max-width:600px;"/>

The second is support for Test Anything Protocol ([TAP][]), which allow integration 
with CI servers. To enable run the test tool with `--tap` option.

[TAP]: https://en.wikipedia.org/wiki/Test_Anything_Protocol

<br>

_And if you don't have enough, just look on excellent library, built on top 
of `ceylon.test` which enables BDD style of test development and much more, 
called [specks](https://github.com/renatoathaydes/specks)._







