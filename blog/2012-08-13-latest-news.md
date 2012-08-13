---
title: Latest news 
author: Stéphane Épardaud
layout: blog
unique_id: blogpage
tab: blog
tags:
---

I figure it's summer, you might think we're all at the pool enjoying the sun,
but that's not quite how it is: we've been busy doing all sorts of things,
such as preparing a new Ceylon IDE version that has tons of fixes, new features,
improved performance that we will release shortly. We're also hard at work on
[the next milestone](/documentation/1.0/roadmap/#milestone_4) and the
[Ceylon SDK](https://github.com/ceylon/ceylon-sdk), but that's not why I'm writing
today.

## Website news

Did you know you could compile Ceylon to JavaScript? No? Well, you can, we're not
only available on the JVM platform. We have this 
[awesome JavaScript compiler](/documentation/1.0/reference/tool/ceylonc-js/)
that supports the same features as the JVM backend compiler. We even started shipping
the SDK modules for both JVM and JavaScript backends on [Herd](http://modules.ceylon-lang.org).

Now, you may be wondering why you should care about JavaScript, and here's why: you
can now try and run Ceylon code in your browser! We have an [online _IDE_](http://try.ceylon-lang.org)
that's pretty awesome for discovering the language. Now, IDE is stretching the term a bit, *but*:
it supports syntax colouring and auto-completion! Seriously: just try your hand at that Ctrl-Space
key combo and explore the Ceylon API as you learn. No strings attached. It's still a bit slow,
but our engineers are stilling hammering and soldering it as we speak, so expect it to
go a lot faster once it realises how deadly we can be to slow code.

And that's not all, see? We even went ahead and plugged in that IDE in our documentation.
Seriously! All the code examples in the [introduction](/documentation/1.0/introduction)
and [tour](/documentation/1.0/tour) have this neat and cute _Try_ button that begs to be
pressed on in order to show you that Ceylon is not just nice on paper: it's nice on your
server and on your browser. How cool is that?

<!-- cat: void m() { -->
    String[] names = { "Tom", "Dick", "Harry" };
    for (name in names) {
        print("Hello, " name "!");
    }
<!-- cat: } -->

## Ceylon needs you

The other thing I wanted to talk about is what you can do to help drive Ceylon forward. You already
know [Ceylon is open-source](/code/) and everything happens in the open. We have a wonderful
[community](/community/) working on the many parts that we call Ceylon as a whole.

Here are a few of the things I really love about the Ceylon community:

- It's **open**. Not just open-source, but really really open: the discussions happen on public mailing-lists,
  the issue trackers are public, and *everyone* can pitch in for ideas, discussions, constructive criticism,
  opinions and advice. Obviously the core committers have more weight in the matter if there is no clear
  consensus on discussions, but more often than not, even fly-by commenters can have a pretty big influence
  on the project if they provide good ideas or comments and are willing to convince us.
- It's a **hacker-fest**. Our unofficial manifesto is [programming motherfucker](http://programming-motherfucker.com).
  Obviously we love beautifuly designed things, but we hate over-engineered things and in general value more
  "getting things done" than "getting in the way". We could call it _pragmatic programming_: whatever needs to
  be done, we do. We have people that prefer Maven and others Ant, so some projects support both build systems.
  We use tools that allow everyone to work without fighting, such as git or github. As much as we can, we try to
  make contributions easy and agreeable — after all, if you're doing this in your free time, it should be fun!
- It's incredibly **diverse**. You like client GUI work?
  [Try the Ceylon IDE project](https://github.com/ceylon/ceylon-ide-eclipse). You like visitors, AntLR and
  type analysis? [Try the compiler frontend](https://github.com/ceylon/ceylon-spec) (aka ceylon-spec 
  aka _the typechecker_). You like generating Java AST or JavaScript? 
  [Try the compiler backends](https://github.com/ceylon/ceylon-compiler). If you're into Web things, perhaps
  ceylondoc (our API documentation
  generator), our [Web IDE](https://github.com/ceylon/ceylon-web-ide-backend) or even 
  [Herd](https://github.com/ceylon/ceylon-herd) (our module repository) would be your thing? Want to start a .NET backend?
  We can help you with that (someone already started). Want to see Ceylon run in another IDE? We will help you.
  Want to work on a kick-ass brand-new modern SDK? Well, [why don't you](https://github.com/ceylon/ceylon-sdk)?
  There's stuff to like for everyone's tastes.
- It's **fun**, it's **challenging**, and it's **changing the world**. What good is working on something if you're waking up 
  in the morning dreading the day ahead? We do interesting things. We do things that very few have done before.
  After all, not everyone writes new languages (even though it may appear to be the case), and not every new
  language has a scope as broad and ambitious as Ceylon. And we do it in a good spirit: it's important to have
  fun with your colleagues-in-open-source. And we learn a lot, we certainly do. Most of us had never done what
  we're working on before, so it's certainly an experience that makes you better. And best of all: we're changing
  the world. This is not some project that only a handful will use. Our goal is to make everyone use Ceylon, so
  whatever you put in there, whatever little or big thing you contribute, actually ends up being used by a lot of
  people. That's something to be proud of.

All of this to say: we have a great community and a great project, and we'd love to welcome **you** aboard! 
[Get in touch with us](http://groups.google.com/group/ceylon-dev)
and we'll help you find the project you will love, and get started with things to do: easy at first,
then more and more challenging as you become more expert in the project than we are.

Come and have fun with us changing the world!
