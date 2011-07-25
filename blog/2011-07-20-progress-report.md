---
title: Ceylon progress report
author: Gavin King
layout: blog
tags: [progress]
---
Hrm, I notice it's been just over three months since I semi-accidentally announced 
the existence of the [Ceylon project=>Tutorials|Introduction to Ceylon], and I guess 
I feel like you folks deserve some kind of progress report! At the time, I very much 
regretted the fact that the project became public knowledge before I was really prepared 
to socialize it, but in retrospect it was the best thing ever for us. That's where we got 
Stef and Tako and Sergej and Ben from, along with the other folks who are signing up to get 
involved in development. Unfortunately, we're still working in a private github repo, which 
is certainly not ideal, but it's helping keep us focused on getting actual code written.

So here's what we have so far:

* a 125 page language specification (with some open issues and vague sections),
* a parser and typesafe syntax tree for the whole language,
* a compiler frontend (type checker/analyzer) for about 85% of the language,
* a compiler backend that integrates the frontend with |javac|'s bytecode generation 
  for perhaps 40% of the language, and
* the skeleton of a "model loader" that builds a metamodel of precompiled `.class` 
  files (essential for incremental compilation and interoperation with Java).

The frontend of the compiler (the bit that analyzes the semantics of the code, assigns types to 
things, and reports programming errors) is basically done already. Certainly all the "hard" bits 
are finished, including stuff like generics, covariance, subtyping, refinement, member types, union 
types, definite assignment and definite return checking, type argument inference, etc. The few missing features could be finished off pretty quickly if there were any real urgency, but we may as well 
wait for the backend to catch up.

Development of the backend and model loader is now completely in the hands of volunteers from 
the community, and, frankly, it's going really well so far. We'll do an initial "alpha"-quality 
release of the compiler when we're happy that the backend is in a usable form. 

I'm not going to promise any exact date for the first release, nor even the exact feature 
set - but I'm guessing it will happen within the next three months, and that it will include 
a really decent slab of the language defined by the specification. At that point, we'll 
hopefully be able to start putting some resources into the SDK and IDE.
