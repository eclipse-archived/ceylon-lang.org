---
title: Installing Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The 1.0 beta release of the Ceylon IDE is available from our Eclipse plugin 
update site. Note that the version of the Ceylon compiler embedded in 
this release is compatible with the Ceylon 1.0 beta command line tools.

Please [report any issue in our issue tracker][issues]. _Note that if
Ceylon IDE doesn't work at all, the problem is probably that Eclipse
is not executing on a Java 7 VM._ (see information about [eclipse.ini][eclipseini])

## Installing from the update site

Here's what you need to do to install the IDE:

1.  Start with a clean install of [Eclipse 4.3 Kepler][eclipse] or 
    of [Eclipse 4.2 Juno][juno] running on Java 7. Mac OS users 
    _must_ make Java 7 the default virtual machine using the 
    `Java Preferences` application located in `/Applications/Utilities`. 
    Other OSes can follow the information about selecting the JVM in 
    the [eclipse.ini][eclipseini] file if needed.
2.  Go to `Help > Install New Software ...`.
3.  Enter the URL <http://ceylon-lang.org/eclipse/updatesite/>
    in the `Work With` field and hit Enter.<br/>
    ![eclipseupdatesite](/images/eclipseupdatesite.png "Update Site")
4.  Click `Select All` and then `Finish`.
5.  Wait while Eclipse installs the Ceylon plugin, and then restart 
    Eclipse when prompted.
6.  Go to `Help > Welcome to Ceylon` to get started.<br/>
    ![welcomepage](/images/screenshots/intro.png "Welcome Page")

[eclipse]: http://www.eclipse.org/downloads/
[juno]: http://eclipse.org/juno
[issues]: https://github.com/ceylon/ceylon-ide-eclipse/issues
[eclipseini]: http://wiki.eclipse.org/Eclipse.ini

## Installing from the development (unstable) update site

If you want to try the latest build of the IDE before it is released, you
have to use the _development_ update site:

<http://ceylon-lang.org/eclipse/development/>

Beware that this is an unstable and unfinished version.
