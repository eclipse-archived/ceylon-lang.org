---
title: Ceylon Test Eclipse Plugin
author: Tomáš Hradec
layout: blog
unique_id: blogpage
tab: blog
tags: [ide, progress]
---

Today we would like to introduce you a new eclipse plugin that allows you to run ceylon unit tests,
and easily monitor their execution and their output.
It offers similar comfort and integration with IDE like programmers know from JUnit and little bit more.
It is part of Ceylon IDE, so no additional installation is needed.

## Getting started with first ceylon unit test

New test framework is in module `ceylon.test` and in this early version contains only basic functionality. 
It will be improved as soon as we will have annotations and meta-model support.
So let's start with adding import into module descriptor and writing first test.


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


These tests can be run like ordinary ceylon application with following code:

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


Now let´s see IDE integrations...


## Launch configuration

Once you have created tests, you can create a _Ceylon Test Launch Configuration_. 
In this dialog you can specify the tests to be run, its arguments, run-time environment etc.

![launch-config](/images/screenshots/ceylon-test-plugin/launch-config.png)

Into launch configuration you can add directly test methods or its containers, like class, packages, modules, or whole project.

![select-test](/images/screenshots/ceylon-test-plugin/select-test.png)

As you would expect, a quick way to run ceylon test is right click in _Ceylon Explorer_ or in open editor and select _Run-As → Ceylon Test_.


## Viewing test results

The _Ceylon Test View_ shows you the tests run progress and status.
There is toolbar with familiar functions: 

- show next/previous failure 
- collapse/expand all nodes 
- filter for showing only failed tests
- scroll lock
- buttons for relaunching or terminating
- test runs history
- menu for view customization (show elapsed time or show test grouped by packages)

![test-result-view](/images/screenshots/ceylon-test-plugin/test-result-view.png)


## Comparing test results

In _Test Runs History_ is possible review tests history and switch between runs. 
And especially open _Compare Test Runs_ dialog, where you can see which tests have regressed, which tests have been fixed and which tests have been added or removed between the two test runs.

![test-runs-history](/images/screenshots/ceylon-test-plugin/test-runs-history.png)

![compare-test-runs](/images/screenshots/ceylon-test-plugin/compare-test-runs.png)


# TODOs
- TODO where to download
- TODO which version of ceylon.test 0.4 or 0.5 (fix in code example)

