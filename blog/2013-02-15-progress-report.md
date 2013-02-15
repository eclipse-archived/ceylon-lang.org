---
title: Ceylon M5 progress report
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [progress]
---
Ceylon M4 was [released](/blog/2012/10/29/ceylon-m4-analytical-engine)
back at the end of October, more than three months ago, so you might be 
wondering what the hell have we been up to and where is in hell is that 
M5 release we promised! At the very least you deserve a progress report.

So what's going on is that M5 has gone quite a bit off the roadmap. This
was kind of my last chance to revisit some design choices I made a couple
of years ago before there was any kind of compiler for Ceylon or libraries
written in Ceylon. Inevitably, there were some things that seemed like a 
good idea at the time, but:

- I never really managed to sell to everyone else,
- we ended up falling out of love with, or
- just didn't quite work out in practice once we started writing real 
  code.

This was really our last opportunity to fix things like that, so we've 
lost some time there.

Additionally, there was one thing, namely _tuples_, that I didn't think 
we were going to need, that we did wind up needing, and accommodating 
it elegantly into the language was actually somewhat disruptive. This
also cost some time, and there is still some unfinished work there.

Finally, we decided to throw away almost all the human-compiled code 
in the language module and compile it with the Ceylon compiler instead. 
That was hard work, but it sure makes as feel a lot more secure and 
saves us a lot of pain when we add things to the language module.

So the bad news is that, given the above, some functionality is going 
to slip from M5, and therefore M5 will _not_ be a feature-complete 
implementation of the language. In particular, it wont have support 
for:

- annotations,
- serialization, or 
- the metamodel (reflection). 

It _will_ have the following new features:

- tuples
- direct interop with native JavaScript APIs via the new `dynamic` 
  block (more on this in a separate post)
- the `:` operator
- verbatim strings
- fat arrow `=>` abbreviation for defining single-expression functions
- the `late` annotation
- binary and hexadecimal numeric literals
- defaulted type parameters
- experimental support for reified generics
- _many_ miscellaneous minor improvements to the syntax and typing 
  rules of the language
- `ceylon.time` module
- `ceylon.net.httpd` package (a HTTP server)

(Please don't try to tell me that's not a pretty impressive list!)

I also finally found the time to give the language specification some 
love, after several months of neglect, so it's now up to date with all 
this new work. Ceylon is a better language now, I'm certain of it.

Well, I've a little more bad news: M5 is still not ready :-(

- Stef's currently putting the finishing touches on his initial 
  implementation of reified generics, 
- David's working on some performance issues with compilation inside 
  the IDE that we would prefer to see fixed in M5,
- Roland Tepp is finishing off work on the initial release of
  `ceylon.time`,
- Matej Lazar is doing some API improvements to `ceylon.net.httpd`,
  and
- there's still a bunch of backend bugs that need fixing.

Bear with us. It's frankly very painful for us to have not had a
release in almost four months, but in a funny way that's more of a
sign of how close we are now to delivering something you can 
really use to write real applications.
