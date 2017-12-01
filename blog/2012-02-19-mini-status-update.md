---
title: Mini-status update
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

It's now been exactly two months since the M1 release of the
Ceylon command line distribution, and more than a month since 
the first release of Ceylon IDE. And we've just finished our
second face-to-face team meeting, in Barcelona. You might be 
wondering what's really been keeping us busy, so I figured 
it's time for a little status update.

## Ceylon for the JVM and Ceylon IDE

Of course, most of our effort has been focussed on the M2
release of the command line tools and IDE. The top-priority
issue for M2 was Java interop, but this turned out to be a 
somewhat more challenging task than we had anticipated, so
there has been some shuffling of the roadmap to accommodate
that. Therefore, M2 will feature five major new features:

* Java interoperability
* enumerated (algebraic) types
* enhancements to the language module
* optimization of numeric operations
* support for remote module reposities

The IDE gets:

* the ability to compile against binary archives, including 
  Java `.jar`s
* Create Subtype and Move to New Unit wizards
* several new quickfixes

Of course, there's many other minor bugfixes and enhancements
I'm glossing over here.

We're planning to release Ceylon M2 in March.

## Ceylon for JavaScript and the Ceylon Web Runner

Meanwhile, the [JavaScipt compiler for Ceylon][ceylon-js] has
taken off and is progressing much faster than anticipated. 
You can play with it online using the "teaser" pre-release 
of [Ceylon Web Runner][ceylon-web-ide] here:

<http://try-ceylon.rhcloud.com/>

(Note that the Web Runner isn't finished yet, this is just
what the guys whipped over the last two weeks in between
working on other stuff and eating paella.)

Since we've taken the decision to dedicate serious time and 
effort to this part of the project, I think we're going to 
need to stop calling Ceylon "a JVM-based programming language", 
and emphasize that it is a programming language suitable for 
many different virtual machines. Ceylon's minimal language 
module - which is being carefully designed to not be dependent 
on anything JVM-specific - makes the language especially 
adaptable to alternative platforms.

[ceylon-js]:http://github.com/ceylon/ceylon-js
[ceylon-web-ide]:http://github.com/ceylon/ceylon-web-ide-backend
