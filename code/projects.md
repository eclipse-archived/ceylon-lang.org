---
title: Ceylonic projects
layout: code
unique_id: ceylonicprojectspage
tab: code
toc: true
author: Ivan Melnikov
---
# #{page.title}

Useful frameworks, libraries or modules written on Ceylon.


#{page.table_of_contents}


### Testing.

* [asyncTest](https://github.com/LisiLisenok/asyncTest)
  is an extension to SDK `ceylon.test` module which helps to perform testing of asynchronous multithread code
  with _Ceylon test tool_.  
  The module supports: concurrent or sequential test execution, parameterized testing,
  reporting several failures or successes for a one particular test function and other.  
  _Matchers_ approach can be utilized in order to organize complex test conditions
  into a one flexible expression with clear report. A number of build-in matchers are available to perform
  comparison, logical and stream matching operations.  
  Reporting test results using charts is another feature which is well suite for microbenchmark testing.  
  Ceylon module `herd.asynctest` is available on [Herd](https://herd.ceylon-lang.org/modules/herd.asynctest) 


-----------------------------------------------------

### How to list your project here.

1. Go to [Ceylon website git repository](https://github.com/ceylon/ceylon-lang.org).
2. Fork this.
3. Go to _ceylon-lang.org_ repository on your profile.
4. Find file _/code/projects.md_.
5. Edit it directly in the GitHub website.
6. Send pull request.
7. See your project listed on this page.


> If you prefer to test it before submitting follow [instructions](/code/website).


Project information requirements:

* Project has to be added under only a one category, if there is no appropriate category add new one.
  Use '\#\#\#' for category designation.
* Projects have to be listed in alphabetical order using Markdown list symbol '\*' before each project.
* Link to your project on [Ceylon Herd](https://herd.ceylon-lang.org)
  or another public resource like [GitHub](https://github.com/) has to be provided.
* Brief description of the project is mandatory.
