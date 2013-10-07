---
title: New Road Map
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [progress, roadmap]
---
With the release of [1.0 beta](/blog/2013/09/22/ceylon-1), we
reached the end of our previous [roadmap](/documentation/1.0/roadmap).
This doesn't mean we've run out of work to do, so of course we needed
a new one. Here's a sketch of our plan:

### Ceylon 1.0 final

The focus of development right now is of course bug fixes to the
compiler backends, language module, and IDE. The major new feature 
planned for 1.0 final is serialization, which, even though we 
think of it as a language feature, is really, strictly speaking, a 
feature of the language module.

In parallel, David Festal is working on some very-needed 
optimizations to build performance in Ceylon IDE, though that 
work won't be finished in 1.0 final. I found the time this weekend 
to squeeze a couple of cool new features into the IDE, but that's 
not supposed to be the priority for this release.

There's also some issues we need to work through with interop
between our module system and Maven. I'm not sure whether we'll be
able to get this all sorted out in 1.0, or whether this will slip
(again) to 1.1.

Finally, we hope to have a couple of new platform modules ready 
for the 1.0 final release, including `ceylon.transaction`.

### Ceylon 1.1

Ceylon 1.1 will be all about performance, including language 
performance, compiler performance, and David's ongoing work on IDE 
build performance. There are a whole bunch of really obvious 
optimizations we can make, that we simply havn't had time to work 
on yet.

A warning: we expect to break binary compatibility between 1.0 and
1.1. That's not something we do lightly, and it's not something we
plan to make a habit of. Changes affecting binary compatibility 
should occur in major releases, not minor releases. Please forgive
us if we break our own rule this one time.

At the same time, building out the Ceylon SDK will also be a top 
priority. This will probably be what I personally focus on for a 
while.

### Ceylon 1.2

Ceylon 1.2 will introduce a number of new language features. We're
not completely sure of precisely which new features will make the
cut, though we do have a shortlist of several which are almost certain
to make it in. I'm not talking about major new features of the type
system or anything here. We're really very happy with what's possible 
in the language as it exists today. The priority will be additional 
syntax for dealing with situations that are a little uncomfortable 
right now, and removal of a handful of limitations introduced 
temporarily for 1.0.

[list]:https://github.com/ceylon/ceylon-spec/issues?direction=desc&labels=high+priority&milestone=9&page=1&sort=updated&state=open

Here's a [list][] of some of the things under very serious consideration
for 1.2. Don't expect all of them to make the cut. We want to make the 
language easy to use. That means fixing things that suck without bloating 
out the language with too many overlapping features and minor syntax 
variations.
