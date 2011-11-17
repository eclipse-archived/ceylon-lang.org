---
title: Ceylon IDE
layout: default
tab: Ceylon IDE
author: Gavin King
---
# Ceylon IDE

The Ceylon IDE is a plugin for Eclipse, which supports the following features,
among others:



## Running the pre-release IDE

If you *really* want to try out Ceylon now, before we even release Milestone 1, 
you can get a special pre-release build of the Ceylon IDE (which includes the
compiler) from our Eclipse plugin update site.

Here's what you need to do:

1. starting with a clean install of [Eclipse Indigo](http://www.eclipse.org/downloads/),
2. launch Eclipse,
3. use `Help > Install New Software ...` to open the `Install` dialog,
4. enter the URL `http://ceylon-lang.org/eclipse/updatesite/`,
5. click `Select All` and then `Finish`,
6. open `Eclipse > Preferences` and go to `Java > Compiler > Building > Output folder`. 
   Add the pattern `*.ceylon` to `Filtered resources`,
7. in the `Java` perspective, Use `File > New > Java Project`, enter a 
   project name, and select `Finish` to create a new Java project in the 
   workspace,
8. select the new project in the Java package explorer, and select 
   `Enable Ceylon Builder` from the context menu,
9. Use `New > Ceylon Unit` to create a new file with the extension 
   `.ceylon` in the `src` directory of your project, and, finally
10. have fun!

Please note that you *will* run into bugs running the pre-release build. Please
report them in our issue tracker.