---
title: "Status Report: Ceylon TypeScript Loader GSoC project"
author: Lucas Werkmeister
layout: blog
unique_id: blogpage
tab: blog
tags: [gsoc, typescript]
---

TL;DR: coming along, won’t be done in time for official GSoC deadline, I’ll just keep working.

(Note: this is a GSoC status report.
The entire project is work in progress, and if you’re looking for a something finished, you’ll have to wait until the project is released, at which point there will be a proper announcement.)

For this year’s Google Summer of Code, I am working on adding TypeScript support to the Ceylon JavaScript backend.
The goal is to have a tool that, given a TypeScript module (one or more files), produces a Ceylon module for the JavaScript backend.
The JS code of that module will just be the TypeScript compiler’s output (plus possibly some metamodel stuff),
but the tool will also add model information that will allow you to use the TypeScript module from Ceylon like any other Ceylon module,
without needing to use `dynamic` blocks or having to declare your own dynamic interfaces.

I actually started work on this tool a few months before GSoC, in January this year.
I wrote the first iteration of the program in TypeScript in order to be able to interact with the TypeScript compiler
(which is also written in TypeScript).
The goal of that first iteration is just to be able to load the TypeScript compiler itself,
so that I can then use that module (`tsc`) from Ceylon
and write the second (and probably final) iteration of the program in Ceylon.

This first iteration of the program was mostly finished,
at least good enough that I could start writing the second iteration,
shortly after the GSoC work period officially started.
I had hoped to start with the second iteration exactly at the start of GSoC,
but while there had been good progress with my own simple test module,
`tsc` held a couple of nasty surprises that I hadn’t anticipated and that I had to work around.
It also turned out that I had made a couple of very bad decisions early on:

- I chose to operate on the parsed syntax tree instead of the typechecker model.
  How I ever expected this to work, I have no idea, but problems quickly became obvious:
  
  - When I see a type reference, like `Element`, I have to know if this refers to a type parameter,
    a type from the same module, or perhaps one from another module.
    The type I store in the model must be fully qualified.
  - To represent a type with type arguments, the JS model lists the type arguments along with their type parameter name.
    So to transform a type like `Array<string>`, I have to know that `Array`’s first type parameter is called `Element`.
  - TypeScript features type inference.
    Of course, I have to know the inferred type so that I can put it into the model.

- To get a first version out quickly, I just wrote directly to the `-model.js` file.
  The model is mostly JSON, so this meant some ugly manual comma management
  when it turned out there are some declarations where I don’t emit anything
  (such as index signatures).

There are some lovely commit messages in the [git log](https://github.com/lucaswerkmeister/ctsl/commits),
with phrases like “totally hacky”, “should be enough for now”,
“this is where it all falls apart”, “add fake support”, “horrible hack”, and
“How could I possibly ever think that it’s possible to write this loader without access to tsc’s model, purely based on the AST?”
I am very glad that I get to learn from these mistakes in the second iteration :)

Now, writing the second iteration also turned out to be trickier than I’d thought.
I had (still have) a Ceylon version of the TypeScript compiler, the `tsc` module,
but it’s difficult to work with from Ceylon.
Two problems mainly held me up:

1. TypeScript supports optional members: `{ name?: string }` is the type of a value that might have a member `name` (containing a `string`),
   but might also have no such member (`undefined`).
   The Ceylon runtime doesn’t like this at all and breaks in many different and difficult-to-debug ways;
   the only solution I found was to not emit such members at all.
   To access them without “attribute does not exist” typechecker errors,
   I use `eval` inside `dynamic` blocks, which leads us to the second problem.
2. Whenever a dynamic value (such as the return value of an `eval` call) is assigned to a Ceylon type,
   the runtime “dresses” the value with the type that it’s being assigned to (adds RTTI).
   If this is not the most precise type of the value
   (say, you dressed the value with `Node` and later want to use it as a `VariableDeclaration`),
   you have to jump through some hoops to fix this – a simple `assert (is VariableDeclaration node)` won’t work,
   since Ceylon doesn’t like to narrow these dressed types.

I now have workarounds for both problems, but they took a while to find,
and of course I shouldn’t have to work around them in the first place,
so I’ll have to teach the Ceylon JS backend to “do the right thing” eventually.
(I also have to do that in many other cases, since the Ceylon JS “ABI” differs significantly from plain JS –
Ceylon classes aren’t instantiated with `new`, toplevel values compile to functions, arrays aren’t arrays, etc. etc.)

Right now, the second iteration supports:

- toplevel values,
- toplevel functions (no parameters), and
- the `string` type.

That’s it. *But*, unlike the first iteration, it supports this without needing to add any JS code
(I’ve already taught the compiler to access the toplevel values as values and not functions).
Currently, some JS code is added (metamodel stuff), but I’m not sure if I’ll actually keep that.
We could say that what, are you crazy, why would TypeScript modules support the metamodel?,
and then the JS file would just be the unaltered `tsc` output, and the tool would only add the `-model.js` file.
This would probably make working with declaration files easier
(where the JS isn’t generated by `tsc` – one of many problems I haven’t even begun to think about yet).

I’m fairly confident that I’ll be able to add support for most “basic” features –
type references and other primitive types, type parameters and arguments, parameters,
classes, interfaces, methods, attributes – without too much trouble.
After that, all bets are off.
TypeScript supports some crazy features, like string types (`"foo" | "bar" | "baz"` is a valid type)
and type guards (`pet is Fish` is a valid return type, a weird inversion of Ceylon’s `is Fish pet` conditions),
and I have no idea how well we can support them.
I will also need to make more changes to the JS backend and runtime,
and I don’t know how difficult those will be.

There are about four weeks left before the official GSoC deadline, and I’ll be on vacation for one of them.
I hope that the “basic” support will be done until then, but there’s zero chance that the project will be in shippable state.
I’m not too worried about that – I’ve worked on the project before GSoC started, I’ll continue to work on it after GSoC ends,
just like I did with `ceylon.ast` two years ago.
And, just like two years ago, I should have more time after GSoC ends,
because GSoC is actually scheduled pretty weirdly for me,
where I still have lectures for most of it and it barely overlaps with my semester break.
I should be free to work on this project for most of August, September, and the first half of October,
and hope to arrive at something that can actually be released somewhere before the end of that period.
