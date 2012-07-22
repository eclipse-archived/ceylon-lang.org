---
title: Installing Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The M3 release of the Ceylon IDE is available from our Eclipse plugin 
update site. Note that the version of the Ceylon compiler embedded in 
this release is compatible with the Ceylon M3 "V2000" command line 
tools.

Please [report any issue in our issue tracker][issues]. _Note that if
Ceylon IDE doesn't work at all, the problem is probably that Eclipse
is not executing on a Java 7 VM._

## Installing from the update site

Here's what you need to do to install the IDE:

1.  Start with a clean install of [Eclipse 3.7 Indigo][eclipse] or 
    of [Eclipse 4.2 Juno][juno] running on Java 7. Mac OS users 
    _must_ install Juno and make Java 7 the default virtual machine 
    using the `Java Preferences` application located in 
    `/Applications/Utilities`.
2.  Go to `Help > Install New Software ...`.
3.  Enter the URL <http://ceylon-lang.org/eclipse/updatesite/>
    in the `Work With` field and hit Enter.
    ![eclipseupdatesite](/images/eclipseupdatesite.png "Update Site")
4.  Click `Select All` and then `Finish`.
5.  Wait while Eclipse installs the Ceylon plugin, and then restart 
    Eclipse when prompted.
6.  Go to `Help > Welcome to Ceylon` to get started. 
    ![welcomepage](/images/screenshots/intro.png "Welcome Page")

[eclipse]: http://www.eclipse.org/downloads/
[juno]: http://eclipse.org/juno
[issues]: https://github.com/ceylon/ceylon-ide-eclipse/issues