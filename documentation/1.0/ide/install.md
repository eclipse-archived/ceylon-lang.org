---
title: Installing Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The 1.0.0 release of the Ceylon IDE is available from our Eclipse 
plugin update site. Note that the version of the Ceylon compiler embedded 
in this release is compatible with the Ceylon 1.0.0 command line tools.

## Eclipse platform

You'll need a clean installation of [Eclipse 4.3 (Kepler)][eclipse] or of 
Eclipse 4.2 (Juno).

## Java 7 requirement

The Eclipse platform must itself be executing on Java 7. Ceylon IDE is
not compatible with Java 6 or earlier.

- Mac OS users _must_ make Java 7 the default virtual machine using the 
  `Java Preferences` application located in `/Applications/Utilities`.
- Other OS users can select the Java 7 VM in [eclipse.ini][eclipseini]
  if necessary.
  
_It is not enough to just choose JDK 7 from Installed JREs in Eclipse 
Preferences!_

## Installing the Ceylon plugin from the update site

Here's what you need to do to install the IDE:

1. Start Eclipse.
2. Go to `Help > Install New Software...`.
3. Enter the URL <http://ceylon-lang.org/eclipse/updatesite/>
   in the `Work with` field and hit Enter.<br/>
   <img src="/images/eclipseupdatesite.png" alt="Update Site" width="80%" height="auto"/>
4. Click `Select All` and then `Finish`.
5. Wait while Eclipse installs the Ceylon plugin, and then restart 
   Eclipse when prompted.
6. Go to `Help > Welcome to Ceylon` to get started.

[eclipse]: http://www.eclipse.org/downloads/
[juno]: http://eclipse.org/juno
[issues]: https://github.com/eclipse/ceylon-ide-eclipse/issues
[eclipseini]: http://wiki.eclipse.org/Eclipse.ini

## Installing from the development (unstable) update site

If you want to try the latest build of the IDE before it is released, you
have to use the _development_ update site:

<http://ceylon-lang.org/eclipse/development/>

Beware that this is an unstable and unfinished version.

## Issues

Please [report any issue in our issue tracker][issues]. _Note that if
Ceylon IDE doesn't work at all, the problem is probably that Eclipse
is not executing on a Java 7 VM._

