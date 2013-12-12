---
title: On three-legged elephants
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [language design]
---

I've often argued that good design&mdash;of a language, library, or 
framework&mdash;isn't about packing in as many features as possible 
into your solution, rather it's about discovering a small set of
interlocking features that act to reinforce each other. That is to
say, we want to maximize the power/expressiveness of our solution,
while simultaneously minimizing the surface area. I am, furthermore,
quite often willing to sacrifice some _flexibility_ for _elegance_.
It's my view that elegant solutions are easier to learn, more 
enjoyable to use, and easier to abstract over.

With this in mind, I would like to consider a problem that language
designers have been working on for at least two decades: how to
combine _subtype polymorphism_ with _parametric polymorphism_ (generics).
This is a central problem faced by any object-oriented language with
static typing. Recent languages have come progressively closer to a
satisfying solution, but I would like to submit, if it doesn't sound
too self-serving, that Ceylon offers the most satisfying solution so 
far.

Our mascot is Trompon the elephant, because an elephant has four 
legs, and would fall over if one of his legs were missing. Ceylon's
type system is exactly like this! (Yes, this is a baxplanation.)

The four legs of the type system are:

- declaration site covariance
- ad hoc union and intersection types
- type inference based on principal typing
- covariant refinement and principal 
  instantiation inheritance

If we were to take away any one of those four characteristics, all
of a sudden stuff that Just Works would simply not work anymore, or,
even if we could make it work, it would turn out way more complex, 
and involve reasoning that is difficult for the programmer to 
reproduce.

Consider this really simple line of code:

    value animals = ArrayList { Cat(), Dog(), Person() };

The inferred type of `list` is `ArrayList<Cat|Dog|Person>`.

- If we were to take away declaration site covariance, then `animals` 
  would not be assignable to `List<Animal>`.
- If we were to take away union and intersection types, then the 
  process for inferring the type argument would be ambiguous and much 
  more complex. (Ceylon's type argument inference algorithm is defined 
  in two pages of pseudocode in the language specification, which sounds 
  like a lot, until you realize how problematic and underspecified this 
  algorithm is in other languages, and that the actual implementation 
  of the algorithm is not much more longer.)
- If we were to take away type inference, or principal typing, we would 
  need to explicitly write down some uninteresting types in this line 
  of code.

Minus any one of these characteristics, we're left with a [three-legged 
elephant](http://www.telegraph.co.uk/earth/wildlife/4966620/Mosha-the-elephant-gets-prosthetic-leg.html).
 
Principal instantiation inheritance is a kind-of hidden feature of 
Ceylon that we don't talk about much, even though we use it extensively
throughout the design of our container types. It lets us say, for example, 
that a `List<Element>` is a `Ranged<List<Element>>`, and that a 
`Sequence<Element>` is a  `List<Element>&Ranged<Sequence<Element>>`.
Principal instantiation inheritance meshes really nicely with 
declaration-site covariance, and with ad hoc union/intersection types.
Consider the following code:

    List<String>|Integer[] ranged = ... ;
    value span = ranged.span(0,max); 

Here, the inferred type of `span` is `List<String>|Integer[]`. Isn't 
that nice? The typechecker has reasoned that the _principal supertype 
instantiation_ of `Ranged` for `List<String>|Integer[]` is the type
`Ranged<List<String>|Integer[]>`, and thereby determined the perfect
return type for `span()`.

If we were to take away any one of declaration site covariance, 
principal instantiation inheritance, or union types, then this 
reasoning would no longer be sound. The elephant would fall on his
ass.
