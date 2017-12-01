---
title: Object-oriented != imperative
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Dear FP community: one of the things I really like about you folks 
is the _rigor_ you've brought to the field of programming language 
design. Compared to the kind of magical and folklore-based thinking 
we've grown accustomed to in the field of computing, your approach 
to problems is a massive breath of fresh air. But there's one area 
where you guys seem to have fallen into some rather fuzzy and 
unfounded rhetoric. What I'm taking about is your continued 
conflation of _object orientation_ with _imperative programming_.

When we program with classes and objects, we have the choice between
expressing ourselves using:

- mutable objects, or
- immutable objects.

This is _no different_ to programming using functions, where we have
the choice between:

- impure functions, or
- pure functions.

The use of mutable objects and impure functions is called _imperative
programming_ and is the norm in business and scientific computing.
Another way to describe it is "programming with side-effects". Savvy
programmers from both the OO and FP traditions have long understood
that side-effects make it more difficult to reason about complex code,
and that a design based upon immutable objects and/or pure functions
is often superior.

Indeed, I've been hearing the advice to prefer immutable objects, and
avoid side-effects, for as long as I've been programming using 
object-oriented languages.

Oh, but wait, you might respond: isn't my point totally specious, when
so many of the objects that people actually write in practice are 
actually mutable? Well, no, I don't think so. The truth is, that almost 
as many of the _functions_ that people actually write in practice are 
impure. Programming with functions, and without objects, does not in 
itself innoculate us against side-effects. Indeed, the disciplined use
of immutability that we see in some parts of the FP community is simply 
not the norm in business or scientific computing, even in languages 
which don't support object orientation. Trust me, the old Fortran code
I used to mess about with when I was doing scientific computing work
back in university was certainly no more free of side-effects than
typical object-oriented code I've worked with since.

Perhaps a source of the confusion here is that we say that objects
"hold state and behavior". When some people who aren't so familiar with
OO read this, they imagine that by "state", we mean _mutable state_.
But that's not quite right. What this statement is saying is that an
object holds references to other objects, along with functions that
make use of those references. Thus, we can distinguish one instance
of a class from another instance, by the different references (state)
it holds. We don't mean, _necessarily_ that those references are 
_mutable_, and, indeed, they're very often immutable, especially in
well-designed code.

"So", replies my imaginary FP interlocutor, "how then would such an 
immutable object be any different to a closure?" Well, at some level 
_it's not any different_, and that's the point! There's nothing
_unfunctional_ about objects! You can think of a class as a function
that returns the closure of its own exported nested declarations.
(Indeed, this is precisely how we think of a class in Ceylon.)

Among the modern languages, what really distinguishes a language as
object-oriented is whether it supports _subtype polymorphism_ (or
_structural polymorphism_, which I consider just a special kind of
subtyping). Thus, some languages that people consider "functional" 
(ML, Haskell) aren't object-oriented. Others (OCaml, F#) are.

A request: FP folks, please, please improve your use of terminology, 
because I've seen your misuse of the term "object-oriented" creating 
a lot of confusion in discussions about programming languages.
