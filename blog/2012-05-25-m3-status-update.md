---
title: M3 status update
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

So it's now just over a year since my first presentation about 
Ceylon in Beijing. Since then, we've put together a great 
[team][], a [website][], the
[community module repository][Ceylon Herd], and a 
[full-featured IDE][Ceylon IDE]. And it looks like we've now 
implemented pretty much all the language features that I talked 
about in Beijing, and much more besides, for both the JVM-based 
backend and the JavaScript backend. Of course, while all this 
was happening, the language itself was evolving and the 
[specification][] maturing. Phew, that sounds like a lot in 
just a year!

I've spent the last three days with Stef and Emmanuel in Paris,
discussing a bunch of technical problems, and planning out the 
release of Ceylon M3. The major new features of this release 
are:

* integration of the JavaScript backend into the distribution,
* completion of support for higher-order functions including
  curried functions, anonymous functions, inline functions in 
  named argument lists, and indirect invocations,
* concrete interface members, and
* comprehensions.

The M3 release is now planned for the second week of June.

We're also now turning our thoughts to the Ceylon SDK. By the
time M3 is ready, or soon after, we'll have preview releases 
of several SDK modules availably in [Ceylon Herd][], including
`ceylon.math`, `ceylon.net`, and `ceylon.fs`. Of course, the
SDK will go through a lot of growth and evolution over the
coming year.

Meanwhile, we've started work on integrating Ceylon with
Red Hat's [open source cloud platform][OpenShift].

The bad news is we've decided to cancel the promised M2 release
of [Ceylon IDE][]. Sorry. The good news? We plan to release an
M3-compatible IDE in June. The focus of this release will be
Java interop and integration with Ceylon Herd, including:

* automatic fetching of modules from Ceylon Herd in order to
  satisfy dependencies declared in the module descriptor,
* the ability to call Java binaries from Ceylon, navigate to
  their attached source code, autocomplete their declarations,
  etc, and
* to inter-compile Ceylon with Java, even in the same Eclipse 
  project!

There's also some new quickfixes and autocompletions, a Create 
Subtype wizard, and my favorite trick, the Move to New Unit
refactoring.

It would be nice to have some support for compiling for and 
launching to node.js in the M3 release of the IDE, but I 
can't promise that one.

Now that we've got so much to demo and talk about, we're
trying to do more events. There's [several talks coming up in 
June](http://ceylon-lang.org/community/events/).

[Ceylon Herd]: http://modules.ceylon-lang.org/
[Ceylon IDE]: /documentation/1.0/ide/
[website]: http://ceylon-lang.org
[team]: /community/team
[specification]: /documentation/1.0/spec/
[OpenShift]: https://openshift.redhat.com/app/

