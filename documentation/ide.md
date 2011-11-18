---
title: Ceylon IDE
layout: documentation
tab: Ceylon IDE
unique_id: docspage
author: Gavin King
---
# #{page.title}

The Ceylon IDE is a plugin for [Eclipse](http://eclipse.org). The IDE project 
was initiated by David Festal from [SERLI](http://www.serli.com/), a french software 
company contributing to the Ceylon project.

## Features

The plugin provides the following features, among others:

* Incremental compilation
* Run / Debug
* Syntax highlighting
* Outline view and popup outline
* Popup type hierarchy
* Error reporting in Problems view
  and error annotations in editor
* Reporting of //todo and //fix in Task view
  and task annotations in editor
* Intelligent proposals
* Documentation hover
* Hyperlink navigation to declarations
* Auto indentation and `Correct Indentation`
* New Ceylon unit wizard
* `Open Ceylon Declaration` dialog
* `Ceylon Search` dialog
* `Find References`, `Find Refinements`, and 
  `Find Subtypes`
* Configurable keyboard accelerators
* Basic refactoring: `Rename`, `Inline`,
  `Extract Value`, `Extract Function`,
  `Convert To Named Arguments`, and
   `Clean Imports`
* Basic Quick Fixes: rename reference,
  create member declaration, create local 
  declaration, add import, make shared, 
  make actual, make default, specify type
* Code folding
* Structured compare
* Mark occurrences


## Running the pre-release IDE

If you *really* want to try out Ceylon now, before we even release Milestone 1, 
you can get a special pre-release build of the Ceylon IDE (which includes the
compiler) from our Eclipse plugin update site.

Here's what you need to do:

1.  start with a clean install of [Eclipse 3.7/Indigo](http://www.eclipse.org/downloads/),
1.  go to `Help > Install New Software ...`,
1.  enter the URL `http://ceylon-lang.org/eclipse/updatesite/` to the "Work With" field and Hit Enter,
    ![eclipseupdatesite](/images/eclipseupdatesite.png "Update Site")
1.  click `Select All` and then `Finish`,
1.  Eclipse will install the Ceylon Eclipse plugins and it will ask you to restart. After the restart you will be ready to start using Ceylon.

1.  open `Eclipse > Preferences` and go to `Java > Compiler > Building > Output folder`. 
    Add the pattern `*.ceylon` to `Filtered resources`,
1.  in the `Java` perspective, Use `File > New > Java Project`, enter a 
    project name, and select `Finish` to create a new Java project in the 
    workspace,
1.  select the new project in the Java package explorer, and select 
   `Enable Ceylon Builder` from the context menu,
1.  Use `New > Ceylon Unit` to create a new file with the extension 
    `.ceylon` in the `src` directory of your project, and, finally,
1. have fun!

Please note that you *will* run into bugs running the pre-release build. Please
[report them in our issue tracker](https://github.com/ceylon/ceylon-ide-eclipse/issues).
