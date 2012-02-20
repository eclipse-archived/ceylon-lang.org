---
title: Cross-platform reified types for Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

According to the Ceylon [language specification](/documentation/1.0/spec),
I'm allowed to write code like this on Ceylon:

    Object obj = HashSet<String&Number>();
    if (is Set<String|Integer> obj) {
        for (x in obj) {
            //x is a String|Integer here
            ...
        }
    }

(If you're wondering, yes, the `is` condition is always satisfied
in this code, because `HashSet` is a subtype of `Set`, which is
covariant in its type parameter, and `String&Number` is a subtype
of `String` which is a subtype of `String|Integer`.)

Now, this code doesn't currently pass the Ceylon typechecker, 
because neither of the existing backends (`ceylon-compiler` for
the JVM, and `ceylon-js` for JavaScript) support reification of
type arguments. Indeed, since JavaScript doesn't really have types
at all, even simpler things like `if (is String obj)` don't yet
work.

So, in order to support the functionality defined by the language
specification, two things are needed:

1. the compilers need to automatically create and pass a metamodel
   object that completely reifies the type of an object to each
   instantiation, and
2. the runtime needs to be able to reason about the assignability
   of generic and union/intersection types.

So we need some kind of runtime representation of the metamodel
and assignability algorithm that the typechecker uses at compile
time. Actually, this will eventually evolve into Ceylon's
typesafe metamodel API.

Unfortunately we can't easily just reuse the code we already
have in the typechecker, because:

* it's deeply interdependent with a lot of other typechecker
  functionality, and
* it's implemented in Java, and therefore can't run inside a
  JavaScript VM.

Obviously, we need to trim down this code, and rewrite it in
Ceylon, where it can be easily compiled to either Java classes
or JavaScript code, or to whatever other runtime Ceylon 
eventually supports.

I had originally imagined that this stuff would be part of
the language module. But now I've started seriously taking
into account the web browser as a platform for Ceylon, I 
realize that we need to keep the language module really tiny.
So this will be a separate module.

That sounds to me like a super-fun and interesting project for
someone to take on. Determining assignability in Ceylon is a
very interesting problem, with things like covariance, 
contravariance, intersections and unions to take into account. 
Indeed there some *very* interesting identities involving
variance, unions/intersections, and the single instantiation
inheritance property. I already have an existing algorithm in 
the typechecker, of course, which works mainly via 
canonicalization of principal types, but Ross has suggested 
that he has a better algorithm that avoids the need for 
canonicalization, which sounds like it might work better at 
runtime.

Any takers?
