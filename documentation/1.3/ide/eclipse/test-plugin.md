---
title: Ceylon Test Eclipse Plugin
layout: default
tab: documentation
unique_id: docspage
author: Tom&#225;&#353; Hradec
---

# #{page.title}

The Ceylon IDE for Eclipse allows you to run ceylon unit tests and easily monitor their execution and their output.

It offers similar comfort and integration with IDE as JUnit and even more. Finally, it is part of 
the Ceylon IDE for Eclipse, so no additional installation is needed.

## Getting started with your first ceylon unit test

The test framework is in the Ceylon SDK module `ceylon.test`, latest version and current documentation can be found [here](https://modules.ceylon-lang.org/modules/ceylon.test).

So let’s start by importing the `ceylon.test` module in our module descriptor and writing our first test.

<!-- try: -->
    module com.acme.foo "1.0.0" {
        import ceylon.test "1.0.0";
    }


<!-- try: -->
    import ceylon.test { ... }

    test
    void shouldAlwaysSuccess() {
        assert(1 == 1);
    }

    test
    void shouldAlwaysFail() {
        fail("crash !!!");
    }


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

You can try it right away by downloading our 
[Ceylon IDE for Eclipse](/documentation/1.0/ide/eclipse/install).
