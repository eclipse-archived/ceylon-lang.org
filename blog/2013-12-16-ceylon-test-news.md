---
title: When ceylon.test met meta-model
author: Tom&#225;&#353; Hradec
layout: blog
unique_id: blogpage
tab: blog
tags: [test, tools, progress]
---

Ceylon has had support for unit testing since milestone four, 
but its functionality was pretty limited due lack of annotations and meta-model at that time.

Fortunately this is not true anymore! 
With version 1.0 of Ceylon we also released a completely rewritten `ceylon.test` module.
So let’s see what’s new and how we can use it now.


## Tests annotations

Tests are now declaratively marked with the `test` annotation 
and can be written as top-level functions or methods inside top-level class, 
in case you want to group multiple tests together.

Inside tests, assertions can be evaluated by using the language’s `assert` statement 
or with the various _assert..._ functions, for example `assertEquals`, `assertThatException` etc.

<!-- try: -->
    class YodaTest() {
     
        test
        void shouldBeJedi() {
            assert(yoda is Jedi, 
                   yoda.midichloriansCount > 1k);
        }
        
        ...
    }

Common initialization logic, which is shared by several tests, 
can be placed into functions or methods and marked with the `beforeTest` or `afterTest` annotations.
The test framework will invoke them automatically before or after each test in its scope.
So top-level initialization functions will be invoked for each test in the same package, 
while initialization methods will be invoked for each test in the same class.

<!-- try: -->
    class DeathStarTest() {
     
        beforeTest
        void init() => station.chargeLasers();
     
        afterTest
        void dispose() => station.shutdownSystems();
        
        ...
    }
     
Sometimes you want to temporarily disable a test or a group of tests. 
This can be done via the `ignore` annotation.
This way the test will not be executed, but will be covered in the summary tests result. 
Ignore annotation can be used on test functions/methods, or on classes which contains tests,
or even on packages or modules.

<!-- try: -->
    test
    ignore("still not implemented")
    void shouldBeFasterThanLight() {
    }


All these features are of course supported in our Ceylon IDE. 
Where you can create a _Ceylon Test Launch Configuration_ 
or easily select what you want to run in the _Ceylon Explorer_ and in context menu select _Run-As → Ceylon Test_.

![test-result-view](/images/screenshots/ceylon-test-plugin/test-result-view.png)

## Test command

Our command line toolset has been enhanced by the new `ceylon test` command, 
which allows you to easily execute tests in specific modules.

The following command will execute every test in the `com.acme.foo/1.0.0` module
and will print a report about them to console.

<!-- try: -->
<!-- lang:bash -->
    $ ceylon test com.acme.foo/1.0.0

You can execute specific tests with the `--test` option, 
which takes a list of full-qualified declarations literals as values. 
The following examples show how to execute only the tests in a specified package, class or function.

<!-- try: -->
<!-- lang:bash -->
    $ ceylon test --test='package com.acme.foo.bar' com.acme.foo/1.0.0
    $ ceylon test --test='class com.acme.foo.bar::Baz' com.acme.foo/1.0.0
    $ ceylon test --test='function com.acme.foo.bar::baz' com.acme.foo/1.0.0


More details about this command can be found
[here](/documentation/current/reference/tool/ceylon/subcommands/ceylon-test.html).


## Next version

In the next version, we will introduce other improvements.

There will be a test suite annotation, which allows you to combine several tests or test suites to run them together:

<!-- try: -->
    testSuite({`class YodaTest`,
               `class DarthVaderTest`,
               `function starOfDeathTestSuite`})
    shared void starwarsTestSuite() {}

    
You will be able to declare custom test listeners, which will be notified during test execution:    

<!-- try: -->
    testListeners({`class DependencyInjectionTestListener`,
                   `class TransactionalTestListener`})
    package com.acme;
    
    
And finally you will be able to specify custom implementation of the test executor, which is responsible for running tests:

<!-- try: -->
    testExecutor(`class ArquillianTestExecutor`)
    package com.acme;


_Please note, that these APIs are not final yet, and can change.
If you want to share your thoughts about it, don't hesitate and [contact us](/community)._
