---
title: Useless lying version ranges
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [modularity]
---

A frequent request from the Ceylon community is support for
version ranges in expressing module dependencies. There's no
doubt that our current module system is too inflexible in 
terms of dependency resolution in the face of version 
conflicts, and I have some reasonable ideas about how to 
address that problem without needing version ranges. But I
would like to document precisely why I think version ranges
are strictly-speaking useless at best, and harmful at worst.

First, a philosophical point: version ranges encourage module
authors to make untested or untestable claims about their
modules, such as:

> `my.module` is compatible with  `other.dependency` 
> version 2.x.

Yeah, right, 'cos you've _actually tested_ `my.module` with 
every single minor version and point release of 
`other.dependency`, including all the versions that have not 
even been released yet! Sorry, but I simply don't believe 
you and I have to assume you're lying to me. _Almost nobody_ 
tests their program or library with many different versions 
of its dependencies, and it's easy to see why they don't: as 
soon as we have a program with several dependencies, we face 
a factorial explosion of dependency version combinations.

OK, sure, you might argue, but version ranges are still
_better than nothing_. Alright, alright. I'm not the kind of
guy who much buys into the notion that something broken is 
better than nothing, but I realize I'm in the minority on 
that one, 'cos, y'know, _worse is better_, as the neckbeards 
keep telling me.

So let's see what we could do to make the most of version
ranges. Let's consider the problem first from the point of
view of two library authors assigning version ranges to their
modules, and then from the point of view of the program or
person assembling these modules.

Let's suppose my library `x.y` depends on `org.hibernate`. I 
tested and released `x.y` with the then-current version of
`org.hibernate`, which was `4.1.3`. What version range would
I have chosen when declaring this dependency?

- Well, for the lower bound I decided to lie and write 
  `4.1.0`. Typically, I hadn't actually _tested_ `x.y` with
  versions `4.1.0`, `4.1.1` and `4.1.2`, but I had been 
  using `4.1.2` in development at one stage and it seemed to 
  work, and I didn't see any particular reason it wouldn't 
  also work with `4.1.0` and `4.1.1`. On the other hand, 
  maybe I could have just picked `4.1.3`. (It's not going to 
  matter for the rest of this argument.)
- For the upper bound, I had no clue. How could I possibly
  have known at the time which future unreleased version of
  `org.hibernate` would break my library? Assigning the 
  upper bound of `4.1.3` would have seemed much too 
  restrictive, so what I did was assume that `org.hibernate` 
  is following the completely untestable 
  [semantic versioning](http://semver.org/) standard, and
  that future versions of Hibernate 4.x would not have any 
  bugs.

Thus, I arrived at the version range `4.[1.0-]` using some
imaginary syntax I just pulled out of my ahem, excuse me, 
invented for the sake of argument.

A critical thing to notice here is that, from the point of
view of the library authors, there is _no reasonable way to
determine an accurate upper bound to the version range_. 
This is utterly typical and normal and is the case for 
almost any library author!

Now, sometime later, you released your library `a.b`, which
also depends on `org.hibernate`. At this point, the current
release of `org.hibernate` was `4.2.0`. Quite atypically, 
you actually _do_ test your library with a previous version
of its dependency, and so you know that it is actually 
compatible with `4.1.5` (the latest release of `4.1.x`). 
Thus, you arrive at the version range `4.[1.5-]`.

Now suppose some poor soul wants to use both our libraries
together in their program, thus taking advantage of the bugs 
in both of them. So now, when assembling the program, what 
version of  `org.hibernate` should the module system choose. 
Let's consider the reasonable options:

- Pick the latest release that fits the version ranges, that
  is, the latest release of 4.x. This approach means that a
  new release of `org.hibernate` can break our application.
  We're picking a release which hasn't been tested with 
  either `x.y` or `a.b`. Not acceptable.
- Pick the earliest release that fits the version ranges, in
  this case `4.1.5`. This is better. At least there's a 
  chance that one of the libraries (in this case, `a.b`) has 
  actually been tested with this version. Still, according 
  to this strategy the system could in general pick a 
  dependency version that;s earlier than all the current 
  versions when the libraries were developed. That seems 
  quite suboptimal.
- Pick 4.2.0, since that was the current version of 
  `org.hibernate` when one of the libraries was developed, 
  so we _know for a fact_ that it works with at least one of
  the libraries, and it's newer that the version that the 
  other library was developed with. This seems to me like 
  it's by far the most robust and natural strategy.

There are some variations on this scenario, which raise 
other possible choices, and I'm going to let you experiment
with the variations yourself, and see how it affects the
conclusion. But as far as I can tell, there's essentially
no common scenario in which the third strategy isn't at 
least as good as any other possible strategy. 

And now note that this third strategy doesn't actually use 
version ranges at all! We can write down this strategy 
without reference to version ranges. It just says: pick the
latest version of the dependency among the versions with 
which the libraries were developed. Version ranges don't
really add any useful additional information to that, 
especially in light of the fact that upper bounds are 
essentially impossible to determine, and even lower bounds 
often lie. Why inject additional inaccurate information into
the mix when we already have an algorithm that produces a
result without depending on guesses and lies and 
unverifiable assumptions? (I apologize for going all logical 
positivist on your arse.)

What do you think? Am I wrong? Is there some reasonably 
common scenario where the module system can be expected to
produce a better outcome with the addition of version range
information? Is there a scenario in which upper bound 
information _doesn't_ lie? Is there a strategy involving
version ranges that is unambiguously better than my 
admittedly unsophisticated "pick the latest version" 
approach?

 