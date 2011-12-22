---
title: Installing the Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

A special pre-release build of the Ceylon IDE is avaiable from our Eclipse 
plugin update site. Note that the version of the Ceylon compiler embedded
in this pre-release build is *not* compatible with Ceylon M1.

A version of the IDE compatible with Ceylon M1 is coming very, very soon.

Please note that you *will* run into bugs running the pre-release build. Please
[report them in our issue tracker](https://github.com/ceylon/ceylon-ide-eclipse/issues).

## Installing from the update site

Here's what you need to do to install the IDE:

1.  start with a clean install of [Eclipse 3.7/Indigo](http://www.eclipse.org/downloads/),
1.  go to `Help > Install New Software ...`,
1.  enter the URL `http://ceylon-lang.org/eclipse/updatesite/` to the "Work With" 
    field and hit Enter,
    ![eclipseupdatesite](/images/eclipseupdatesite.png "Update Site")
1.  click `Select All` and then `Finish`,
1.  wait while Eclipse installs the Ceylon plugin, and then restart Eclipse 
    when prompted,
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
