---
title: Ceylon Test Eclipse Plugin
layout: default
tab: documentation
unique_id: docspage
author: Tom&#225;&#353; Hradec
---

# #{page.title}

The Ceylon IDE allows you to run ceylon unit tests and easily monitor their execution and their output.

It offers similar comfort and integration with IDE as JUnit and even more. Finally, it is part of 
the Ceylon IDE, so no additional installation is needed.

## Getting started with your first ceylon unit test

The new test framework is in the Ceylon SDK module `ceylon.test`, though this is still an early version
and contains only basic functionality, because we need annotations and meta-model support to make it really
flamboyant.

So let’s start by importing the `ceylon.test` module in our module descriptor and writing our first test.

<!-- try: -->
    module com.acme.foo '1.0.0' {
        import ceylon.test '0.4';
    }


<!-- try: -->
    import ceylon.test { ... }

    void shouldAlwaysSuccess() {
        assertEquals(1, 1);
    }

    void shouldAlwaysFail() {
        fail("crash !!!");
    }


These tests can be run like any ordinary ceylon application with the following code:

<!-- try: -->
    void run() {
        TestRunner testRunner = TestRunner();
        testRunner.addTestListener(PrintingTestListener());
        testRunner.addTest("com.acme.foo::shouldAlwaysSuccess", shouldAlwaysSuccess);
        testRunner.addTest("com.acme.foo::shouldAlwaysFail", shouldAlwaysFail);
        testRunner.run();
    }

Which outputs:

<!-- lang: none -->
    ======================== TESTS STARTED =======================
    com.acme.foo::shouldAlwaysSuccess
    com.acme.foo::shouldAlwaysFail
    ======================== TESTS RESULT ========================
    run:     2
    success: 1
    failure: 1
    error:   0
    ======================== TESTS FAILED ========================


Now let’s see the IDE integrations!

## Launch configuration

Once you have created your tests, you can create a _Ceylon Test Launch Configuration_. 
In this dialog you can specify the tests to run, their arguments, run-time environment, etc…

![launch-config](/images/screenshots/ceylon-test-plugin/launch-config.png)

In the launch configuration you can directly add test methods or whole containers, like classes, packages, modules, or entire projects.

![select-test](/images/screenshots/ceylon-test-plugin/select-test.png)

As you would expect, a quick way to run ceylon tests is to right click in the _Ceylon Explorer_ or in open editor and select _Run-As → Ceylon Test_.


## Viewing test results

The _Ceylon Test View_ shows you the tests run progress and their status.
The toolbar has familiar functions: 

- show next/previous failure, 
- collapse/expand all nodes,
- filter to only show failing tests,
- scroll lock,
- buttons for relaunching or terminating,
- test runs history, and
- menu for view customisation (show elapsed time or show tests grouped by packages).

![test-result-view](/images/screenshots/ceylon-test-plugin/test-result-view.png)


## Comparing test results

In _Test Runs History_ you can review test runs history and switch between runs.
 
But the real killer feature here happens if you open _Compare Test Runs_ dialog,
where you can see which tests have regressed, which tests have been fixed and
which tests have been added or removed between two test runs, making it extra
easy to get an idea of what your recent work did to the test suite.

![test-runs-history](/images/screenshots/ceylon-test-plugin/test-runs-history.png)

![compare-test-runs](/images/screenshots/ceylon-test-plugin/compare-test-runs.png)

## Try it now

You can try it right away by downloading one of our 
[Ceylon IDE development build](/documentation/1.0/ide#installing_the_latest_development_unstable_ide).