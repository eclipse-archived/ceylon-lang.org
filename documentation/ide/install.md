---
title: Installing the Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The M1 "Newton" release of the Ceylon IDE is available from our Eclipse 
plugin update site. Note that the version of the Ceylon compiler embedded
in this M1 release is compatible with the Ceylon M1 "Newton" command-line 
tools.

Please [report any issue in our issue tracker][issues].

## Installing from the update site

Here's what you need to do to install the IDE:

1.  Start with a clean install of [Eclipse 3.7 Indigo][eclipse].
2.  Go to `Help > Install New Software ...`.
3.  Enter the URL <http://ceylon-lang.org/eclipse/updatesite/>
    in the `Work With` field and hit Enter.
    ![eclipseupdatesite](/images/eclipseupdatesite.png "Update Site")
4.  Click `Select All` and then `Finish`.
5.  Wait while Eclipse installs the Ceylon plugin, and then restart Eclipse 
    when prompted.
6.  Go to `Help > Welcome to Ceylon` to get started. 
7.  Have fun!

[eclipse]: http://www.eclipse.org/downloads/
[issues]: https://github.com/ceylon/ceylon-ide-eclipse/issues