---
title: Expressiveness
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---
I just noticed a tweet by Paul Snively that I thought was interesting.
I don't make it my practice to respond to tweets, simply because >99.9%
of them are just idiotic. But I'll make an exception here, because I
respect Paul, because he frames an interesting issue in a way I agree
with, and because his tweet, which I ultimately disagree with, as I'll
explain, is certainly has at least partly true, at least from a certain
perspective. Paul wrote:

> One reason I prefer #scala to #kotlin or #ceylon is it adheres to the 
> #lisp #smalltalk dictum of not confining expressive power to itself.

So, let's start by seeing what's right about this. Where in the language
definition does Ceylon "reserve expressive power to itself"?

Well, the things that stand out to me are:

- control structures,
- operators, 
- type name abbreviations.

We "reserve expressive power" here, in the sense that we don't let you
write your own `MyTuple` class, and then instantiate it using this 
syntax:

    [String,String] myTuple = ["hello","world"];

If you want to use the brackets, you're stuck with our `Tuple` class, and
if it doesn't suit your needs just right, you're going to have to write:

    MyTuple<String,MyTuple<String>> myTuple = MyTuple("hello",MyTuple("world"));

Or whatever. Likewise, while you can certainly use the `+` operator with
your own `Complex` class, if you want to use it to add a `Period` to a
`Datetime`, you're out of luck. The `Summable<Other>` interface expresses 
that `+` must be a symmetric operation via the self-type constraint on
`Other`. You're going to have to write:

    value date = delay after now;

Or whatever.

Now, I could write a long post defending this choice, but here I'll 
simply note that:

- Scala doesn't let you define type abbreviations or control structures 
  either, but
- it _does_ let you define your own operators.

That is, Scala, like plenty of other languages, lets you take any 
arbitrary string of unicode characters and turn it into an operator.

And just look at what a mess that turned out to be. Sure, there are some
nice uses of operator overloading in the Scala world (parser combinators), 
along with some abominations (SBT). On balance, I, and _many_ others, 
believe that untrammeled operator overloading has been a net negative in
Scala and C++ and other languages that have tried it. So Ceylon takes a
middle road: operator polymorphism.

This means that _you're stuck with the operators we think are important._
But at least everyone in the Ceylon community is stuck with the same 
ones! Which makes Ceylon code much more immediately understandable to 
someone who knows the syntax of Ceylon, because the things which aren't
predefined symbolic operators have meaningful names. So if by 
"expressive power", you take into account the ability to be _understood
by others_, I think of this as a feature.

Fine, anyway, we can agree to disagree on this one, it's not the main
point I want to make. 

The real point I want to make is that I measure "expressive power" of a 
language, not mainly by what superficial syntax it supports (though 
syntax is certainly not unimportant), but rather by what can be expressed 
within the type system. And here's where it has been a _central animating 
design principle_ that we weren't going to build in special little escape 
hatches or ad hoc features for things _we_ think are important. That's 
why, for example, `null` is an instance of the ordinary class `Null` in 
Ceylon, unlike in Java or Scala where it's a primitively defined value of 
the bottom type. That's why `Tuple` is just an ordinary class, and 
`Callable` is just an ordinary interface, unlike in many languages where 
tuple types and function types are defined primitively. That's why the
operators we _do_ have are mostly defined to operate against generic 
interfaces instead of against an enumerated list of language module 
types.

Now, sure, _of course_ Ceylon could never be compared to Lisp, or even to
Smalltalk in this respect. But that's simply an unfair comparison. _Of 
course_ a dynamically typed language is more expressive than a language 
with static typing. Duh. You can't reasonably compare the expressiveness 
of ML or Haskell to Lisp either. But statically typed languages have their
own advantages, and that's why static typing is where the real action is 
right now.

So I think it's a misunderstanding of Ceylon to imagine that we're 
reserving much expressive power to oursevles. No, we don't let you define
your own pope operator `(-:|-+>`, and I guess some people will find that
limits their self-expression. But I believe Ceylon will foster other
productive avenues for them to express their creativity.
