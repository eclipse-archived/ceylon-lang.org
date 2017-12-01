---
title: A sort of manifesto
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [language design]
---

The latest generation of statically typed languages combine 
subtyping, type parameterization, and varying levels of support 
for type inference. But their type systems have - reflecting 
their development over time - grown so complex and riddled with 
corner cases and unintuitive behavior that few programmers are 
able to understand the reasoning of the compiler all the time. 
Error messages are confusing, referring to concepts that only 
language theorists care about, or to types which can't be written 
down in the language itself. The type systems are so complex that 
they even include corner cases which are mathematically 
undecidable, resulting in the possibility of compile-time stack 
overflows or non-termination.

For example, Java features sophisticated support for covariance 
and contravariance via wildcard type arguments. But most Java 
developers avoid making use of this extremely powerful feature 
of the type system, viewing it as a source of confusing error 
messages and syntactic ugliness.

Other languages introduce even further complexity to this mix, 
for example, implicit type conversions, which result in 
unintuitive behavior, especially when combined with generic 
types and covariance, or nonlocal type inference, which can 
result in frustratingly slow compilation times.

But the desire to combine the best of the ML family of languages 
with the best of the C family of languages is not, in itself, a 
misplaced goal. A type system featuring subtyping, type 
parameterization, simplified covariance and contravariance, 
limited type inference, and algebraic types could be a powerful 
tool in the hands of developers, if it:

* could be defined in terms that reflect how programmers 
  intuitively reason about types, 
* was packaged up in a syntax that is easy to read and understand, 
  and 
* constrained so as to eliminate performance problems, 
  undecidability, and confusing corner cases. 

A language like this would necessarily be simpler than some 
other recent statically typed languages, but ultimately more 
powerful, if its features were more accessible to developers.

Ceylon is a language with several goals, including readability, 
modularity, and excellent tool support. In terms of its type 
system, a core goal is to provide powerful mechanisms of 
abstraction without scaring away the people who will ultimately 
benefit from this power with confusing error messages and 
unintuitive collisions between intersecting language features. 

In pursuit of that goal, we've had to start by taking some 
things away. When you start using Ceylon, you'll find there are
some things you can do in Java that you can't do in Ceylon. Our 
hope is that, as you get further into the language, you'll find 
yourself naturally writing better code, making use of more 
general-purpose abstractions and stronger type safety, without 
even really needing to try. It will just feel like the most 
natural way to do it.

At least, that's the theory. ;-)
