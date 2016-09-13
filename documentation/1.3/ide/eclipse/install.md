---
title: Installing Ceylon IDE for Eclipse
layout: eclipse13
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The 1.3.0 release of the Ceylon IDE for Eclipse is available from our Eclipse 
plugin update site. Note that the version of the Ceylon compiler embedded 
in this release is compatible with the Ceylon 1.3.0 command line tools.

## Eclipse platform

You'll need a clean installation of [Eclipse 4.6 Neon][eclipse], 
[Eclipse 4.5 Mars][eclipse] or of [Eclipse 4.4 Luna][eclipse].

## Java 7+ requirement

The Eclipse platform must itself be executing on Java 7 or 8. Ceylon IDE for Eclipse 
is not compatible with Java 6 or earlier.

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
[issues]: https://github.com/ceylon/ceylon-ide-eclipse/issues

## Installing from the development (unstable) update site

If you want to try the latest build of the IDE before it is released, you
have to use the _development_ update site:

<http://ceylon-lang.org/eclipse/development/>

Beware that this is an unstable and unfinished version.

## Issues

Please [report any issue in our issue tracker][issues]. _Note that if
Ceylon IDE for Eclipse doesn't work at all, the problem is probably that Eclipse
is not executing on a Java 7 or 8 VM._

