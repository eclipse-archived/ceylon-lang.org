---
title: A paradox about typesafety and expressiveness
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [typesafety]
---

It's often argued that 
[dynamic typing is more expressive](http://c2.com/cgi/wiki?DavidThomasOnTheBenefitsOfDynamicTyping),
and I am, for the most part, willing to go along with that
characterization. By nature, a language with dynamic
typing places fewer constraints on me, the programmer, and 
lets me "express myself" more freely. I'm not going to,
right now, re-argue the case for static typing, which is
anyway quite clear to anyone who has ever written or 
maintained a decent-sized chunk of code using an IDE. 
However, I would like to point out a particular sense in 
which dynamic typing is much _less_  expressive than static 
typing, and the consequences of that.

(Now, please bear with me for a bit, because I'm going to 
take a rather scenic route to getting to my real point.)

In a nutshell, dynamic typing is less expressive than
static typing in that _it doesn't fully express types_.

Of course that's a rather silly tautology. But it matters
because types matter. Even in a dynamically-typed language 
like Python, Smalltalk, or Ruby, types still matter. To
understand and maintain the code, _I still need to know
the types of things_. Indeed, this is true even in 
weakly-typed JavaScript!

The consequence of this is that dynamically-typed code is
_far less self-documenting_ than statically typed code.
Quick, what can I pass to the following function? What
do I get back from it?

<!-- try: -->
    function split(string, separators)

Translated to Ceylon, this function signature is immediately 
far more understandable:

<!-- try: -->
    {String*} split(String string, {Character+} separators)

What this means, of course, is that dynamic typing places
a much higher burden on the programmer to _comment and 
document things_. And to maintain that documentation. 
On the other hand, static typing forces me to maintain the 
correct type annotations on the `split()` function, even 
when its implementation changes, and my IDE will even help 
me automatically refactor them. No IDE on earth offers the 
same kind of help maintaining comments!

Now consider what else this extra expressiveness buys me.
Suppose that `Foo` and `Bar` share no interesting common
supertype. In any dynamic language on earth, I could write 
the following code:

<!-- try: -->
    class Super {
        function fun() { return Foo(); }
    }
    
    class Sub extends Super {
        function fun() { return Bar(); }
    }

But if I _did_ write such a thing, my team-mates would
probably want to throttle me! There's simply too much 
potential here for a client calling `fun()` to only 
handle the case of `Foo`, and not realize that sometimes
it returns a `Bar` instead. Generally, most programmers 
will avoid code like the above, and make sure that `fun()` 
always returns types closely related by inheritance.

As a second example, consider a well-known hole in the
typesystem of Java: `null`. In Java, I could write:

<!-- try: -->
    class Super {
        public Foo fun() { return Foo(); }
    }
    
    class Sub extends Super {
        public Foo fun() { return null; }
    }

Again, this is something Java developers often avoid,
especially for public APIs. Since it's not part of the 
signature of `fun()` that it may return `null`, and so 
the caller might just obliviously not handle that case,
resulting in an NPE somewhere further down the track,
it's often a good practice to throw an exception instead
of returning null from a method belonging to a public API.

Now let's consider Ceylon.

<!-- try: -->
    class Super() {
        shared default Foo? fun() => Foo();
    }
    
    class Sub() extends Super() {
        shared actual Null fun() => null;
    }

Since the fact that `fun()` can return `null` is part of
its signature, and since any caller is _forced by the
typesystem_ to account for the possibility of a null 
return value, there's absolutely nothing wrong with this 
code. So in Ceylon it is often a better practice to define 
functions or methods to just return `null` instead of 
throwing a defensive exception. Thus, we arrive at an 
apparent paradox:

_By being more restrictive in how we handle null, we make
null much more useful._

Now, since a "nullable type" in Ceylon is just a special
case of a union type, we can generalize this observation 
to other union types. Consider:

<!-- try: -->
    class Super() {
        shared default Foo|Bar fun() => Foo();
    }
    
    class Sub() extends Super() {
        shared actual Bar fun() => Bar();
    }

Again, there's absolutely nothing wrong with this code.
Any client calling `Super.fun()` is forced to handle both
possible concrete return types.

What I'm saying is that we achieved a nett gain in 
expressiveness by adding static types. Things that would
have been dangerously error-prone without static typing 
have become totally safe and completely self-documenting.
