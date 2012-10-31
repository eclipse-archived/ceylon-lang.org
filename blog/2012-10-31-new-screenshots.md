---
title: Some new screenshots
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

If you're interested, here's some screenshots of some of the newer stuff
in Ceylon IDE.

Here's what the brand new Repository Explorer view looks like:

![repo-explorer](/images/screenshots/m4/repo-explorer.png)

The repository explorer helps us find the module we're looking for, in 
the repositories configured for a project, all the way to Ceylon Herd.
But you don't even usually need to use the Repository Explorer, because
the IDE will propose module named and versions when editing the module
descriptor.

![module-completion](/images/screenshots/m4/module-completion.png)

The actual repositories available to you can be configured in the New 
Ceylon Project wizard, or in the project properties:

![module-repos](/images/screenshots/m4/module-repos.png)

From the project properties page, you can also enable compilation to
JavaScript:

![compiler-settings.png](/images/screenshots/m4/compiler-settings.png)

We've _finally_ resolved the performance issues we were having in the
IDE when writing code that depends upon the Java SDK. Of course, doc 
hover, autocompletion, and hyperlink navigation works even for
Java declarations:

![java-interop](/images/screenshots/m4/java-interop.png)
