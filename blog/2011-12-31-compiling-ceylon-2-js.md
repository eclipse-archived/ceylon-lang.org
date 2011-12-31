---
title: Compiling Ceylon to JavaScript
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [ceylon-js]
---

[ceylon-js]: https://github.com/ceylon/ceylon-js
[Common JS]: http://www.commonjs.org/
[node]: http://nodejs.org/
[REPL]: http://en.wikipedia.org/wiki/Read-eval-print_loop

We've always talked about Ceylon as a language for the JVM,
since that's the platform we use every day and the one we
think has the most to offer for server-side computing. But
it's not the only VM out there, and there is very little in
the definition of Ceylon that is JVM-specific. A couple of
days ago I finally found time to work on a little project
that's been nagging at me for a while: compiling Ceylon to
JavaScript.

Why would anyone want to do that? Well, here's a few ideas:

* to do client side development using a modern statically
  typed language,
* to reuse server-side code on the client,
* to run Ceylon code on [node][], or
* for easy experimentation in a [REPL][].

I had anticipated that the language translation part of this 
would be a pretty easy task, and it turns out to be even 
easier than I had imagined. JavaScript isn't a very big 
language, so it took me two or three hours to re-learn it 
(or, more accurately, learn it properly for the first time), 
and I was ready to start generating code!

Some things that made this job especially easy:

* Ceylon has well-defined semantics defined in a [written
  specification](/documentation/spec). This is absolutely
  key for any kind of multi-platform-oriented language.
* The Ceylon compiler has a [layered architecture](/code/architecture/) 
  with a well-defined API between the parser/typechecker and 
  the back end. Indeed, the two projects are developed by
  completely independent teams. Therefore, adding a new
  backend is an easy task.
* JavaScript lacks a native type system, and all objects are 
  essentially just associative arrays. This makes it an 
  *especially* easy target for language translation. I had
  not fully appreciated just how much difference this makes!
* Ceylon and JavaScript both view a "class" as just a 
  special kind of function. Un-`shared` Ceylon declarations 
  map naturally to JavaScript's lexical scope, and `shared`
  declarations map naturally to object members. JavaScript 
  and Ceylon have similar treatment of closure and of 
  first-class function references. 
* Neither Ceylon nor JavaScript has overloading. Indeed, the 
  way you do overloading in Ceylon, using 
  [union types](/documentation/introduction#principal_typing_union_types_and_intersection_types),
  is a totally natural match for how the problem is solved
  in dynamic languages! 

On the other hand, there is one area where JavaScript is
extremely, embarrassingly, inadequate: modularity. After
a bit of googling around, I decided we should map Ceylon
packages to [Common JS][] modules. CommonJS is more of a
server-side oriented solution, but apparently there are
tools to repackage CommonJS modules for the browser. (The 
structure I've gone for is one script per package, grouped 
together in directories by module and module version.) We'll
see how we go with this solution. It's certainly convenient
for running Ceylon modules on [node][]. 

From the JavaScript side, you can load a Ceylon package 
named `foo.bar.baz` from version `1.0` of a module named 
`foo.bar` like this:

<!-- lang: js -->
    var foobarbaz=require('foo/bar/1.0/foo.bar.baz');

Now it's easy to instantiate a class named `Counter` and 
call its methods and attributes:

<!-- lang: js -->
    var counter = foobarbaz.Counter();
    counter.inc();
    console.log(counter.getCount());

I've pushed what I have so far to the new [ceylon-js][] 
repository in GitHub. I've been focusing on the "hard bits"
like multiple inheritance, nested classes, modularity,
named argument invocations, encapsulation, etc., so what's
there today is missing some of the more basic stuff like 
operators and control structures. And we need to reimplement
the language module in JavaScript. Still, it's likely that
the JavaScript backend will soon overtake the JVM backend
in terms of feature completeness. Of course, I'm looking for
contributors!
