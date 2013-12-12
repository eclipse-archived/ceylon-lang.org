---
title: Things static type systems shouldn't have
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [language design]
---

If you've worked with any programming language, you have gripes about 
it. All design involves compromises, and all languages have warts. More
interesting are the warts that are shared by many languages. Here's a
short list of things that are extremely common in static type systems, 
that I think are almost always mistakes. 

A populated bottom type
-----------------------
By definition, the bottom type is a type with no values. If `null` is
an instance of the bottom type, that's a hole in the type system. Yes, 
yes, it's done for convenience. But if we were to go round adding holes
into our type system every time we run into something slightly 
inconvenient, we may as well just give up and go use a dynamic language.

Non-denoteable types
--------------------
A non-denoteable type is a type which can't be written down in the 
programming language itself. Many languages with sophisticated static
type systems require the use of non-denoteable types to typecheck the
code. This almost guarantees that the programmer can't always reproduce 
the compiler's reasoning, or understand the resulting error messages.

Aggressively replacing unions with intersections
------------------------------------------------
For some reason, there's some kind of prejudice against union types.
Your typical compiler, upon encountering something internally that is 
naturally a union type, immediately attempts to replace it with the 
intersection of its supertypes. This doesn't make a whole lot of sense 
to me, since in these languages both unions and intersections are 
usually equally non-denoteable, and this operation involves throwing 
away a whole lot of useful information about the type.

Assigning references a single immutable type
--------------------------------------------
A value has an immutable type. A reference to a value doesn't need to. 
Indeed, what the compiler knows (or rather _could know_) about the type 
of a reference changes depending upon precisely where we are in the code.
But there's a strong tradition that each named reference has a single
declared or inferred type everywhere it is used. This tradition even
infects Ceylon to some extent (though this will change in future versions).  

Primitive types or primitively-defined compound types
-----------------------------------------------------
I hesitated to put this one on the list. There _is_ an approach to building
a static type system where we start with certain primitive values, layer 
tuple support over those types, layer records over tuples, and eventually
arrive at generic abstract data types. I'm _not_ talking about that kind of
type system. What I'm talking about is where we start with a totally general
way of defining abstract data types, and then stick some extra primitive
types into the system because we find our supposedly totally general thing
to be inadequate.

Overloading and implicit type conversions
-----------------------------------------
Yes, yes, I know they seem convenient. But in fact the benefits provided by
overloading or implicit type conversions are almost entirely trivial. They
just don't increase the _expressiveness_ of your type system. And they
really screw up type inference, which is why you don't see these things in
academic or research languages. Dynamic languages don't have anything like
overloading or implicit type conversions, and nobody misses them. Because
you don't need 'em. They're an abuse of the static type information.

