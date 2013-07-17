---
title: Ceylon IDE performance improvements
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [ide, progress]
---

Ceylon already has a [very complete IDE](/documentation/1.0/ide), based on Eclipse, with many features, that we're very
happy with. And considering how young it is, it's quite amazing that it already has all these
features, but in the race to create the IDE and add all the features we needed to it, we have
always pushed back any work in making it work faster. As a result, we're now to the point where
the IDE is mostly complete in terms of features, but pretty slow for large projects.

Luckily, pushing back the work on performance doesn't mean we didn't have ideas for how to
improve it, and in fact we have a lot of ideas, and today I'm glad to announce that in collaboration
with [Serli](/community/companies/#serli) (one of the companies sponsoring Ceylon),
[David Festal](/blog/authors/david-festal/) is going to spend the next six months working on fixing all the speed
and memory issues we have with the Ceylon IDE. David is already behind a lot of work that went in
the Ceylon IDE and has experience with not just the Eclipse APIs and the Ceylon plugin, but also
all the Ceylon sub-systems that the IDE integrates, such as the type-checker, the backends and
the module system.

Here are the major points David will be working on for the IDE:

- Opening a Ceylon project should only generate Ceylon binaries if their source has changed.
- Load module dependencies using their binaries if it turns out to be faster than using their sources.
- Make the backend compiler use the already parsed and typechecked AST that is available in the IDE.
- Beef up the automated test suite.
- Share the loaded models for the Ceylon language module and the JDK modules across every project.
- Research performance bottlenecks in the typechecker and backend if required.
- Research and fix memory consumption on some architectures.
- Improve incremental build when editing module files.
- Add visual progress reporting of the module system.
- Improve build visual progress reporting.

We believe that with David's availability and experience, all of these issues will be obliterated
and we will have an incredibly fast Ceylon IDE even for large projects, at the latest for January
2013. The good news is that David will start this performance run as early as next week, and we
will release new versions of the Ceylon IDE as soon as each improvement is stable enough to ship,
so we can expect faster releases really soon.

Go David!