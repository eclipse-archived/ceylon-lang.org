---
title: Ceylon after two weeks
author: Emmanuel Bernard
layout: blog
tab: blog
unique_id: blogpage
tags: [feedback, conference]
---

This has been almost two weeks since Stephane and I have done our presentation at
Devoxx and revealed the Ceylon community. Let me give you some feedback.

## IDE

Our [IDE sneak preview](/documentation/1.0/ide/?utm_source=blog&utm_medium=web&utm_content=idesneakpreview&utm_campaign=2weeksfeedback) 
has been very popular. Not surprising since it let's you play with Ceylon right from your comfy Eclipse seat in five minutes.

Many thanks to our early testers for finding a few bugs including the infamous 
[issue 107](https://github.com/ceylon/ceylon-ide-eclipse/issues/107) which basically was shutting down
Eclipse if the language module was not installed (yep the `System.exit(1)` was mine :) ).

All of this is now fixed and David has pushed a new IDE release with many improvements. 
Make sure to update the Eclipse plugin (`Help->Check for updates`).

## Community

We are very happy with how the community is shaping up. We had a few interesting and engaging discussions
as well as contributions. Just one example: [Visibility model](https://github.com/ceylon/ceylon-spec/issues/56) ; 
we have been discussing how to improveupon our visibility model (the `shared` keyword).

That's exactly how we wanted it to be, so keep coming :) If you are interested, Gavin marks discussions as 
[`request for feedback`](https://github.com/ceylon/ceylon-spec/issues?labels=request+for+feedback&sort=created&direction=desc&state=open&page=1)
in our issue tracker. 

Or simply join our [development mailing list](http://ceylon-lang.org/community/?utm_source=blog&utm_medium=web&utm_content=devmailinglist&utm_campaign=2weeksfeedback).
We have recently discussed Java interop, killer features that should or should not be added and more.

## Website

The website had a few glitches including an faulty atom feed. This is now fixed. We took the opportunity
to improve `ceylondoc` (the equivalent of `javadoc`). You can now search for a type, attribute, method name
etc [right from the page](#{site.urls.apidoc_current}/ceylon/language). Thanks Stef for the jQuery wizardry.

That's all forks, if you are interested, please join the fun and come contribute by 
[talking](http://ceylon-lang.org/community/?utm_source=blog&utm_medium=web&utm_content=community&utm_campaign=2weeksfeedback)
or by [coding](http://ceylon-lang.org/code/?utm_source=blog&utm_medium=web&utm_content=code&utm_campaign=2weeksfeedback).