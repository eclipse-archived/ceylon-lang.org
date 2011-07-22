---
title: Language design Frequently Asked Questions 
layout: default
toc: true
tab: faq
author: Emmanuel Bernard
---

# FAQ on language design

#{page.table_of_contents}

Designing a language is about trade offs. Some features are sacrificed to make room for others. Some syntaxes approaches are abandoned to better fit the language goals.

### Goals

The goals behind the design of CEylon are multiple, here are the most important one:

* Offering a typesafe hierarchical syntax for structured data - especially UIs
* Reusing the good of Java
* being easy to read even for beginners

## Syntax

### String interpolation syntax

Why not `"Hello $name"` or `"Hello ${name.uppercase}" instead of "Hello" name ""`?

In a word because it works much better for designing UIs.

We originally looked into that, but it turns out that this can't
be lexed using a regular expression. Groovy, for example, uses a
complex hand-coded lexer to handle this stuff. From a pure
language-designer perspective, that's a real red flag. 
The syntax that we ended up settling on isn't as great for everyday procedural
code, but it is much nicer for defining UIs using the declarative
syntax that is one of the main reasons for Ceylon's existence.

### Semi-colons ';' at the end of line?

It's a choice between that or the ugly `@annotation` syntax. You
need one or the other, or your language can't be parsed. Languages
which ditch the semi *have* to introduce a special punctuation for
annotations, and that means that they also have to keywordize common
modifiers like `public`, `virtual`, etc, since they just can't
stomach the ugly syntax for their own annotations.

It's the lesser of two evils, really.

### Colon ':' vs extends in class definition

Matter of taste first.  
But the real reason for this
is that if you use `:` for `extends`, you then need to come up with
punctuation that means `satisfies`, `abstracts`, `of`, `adapts`, etc, and
you wind up in a rabbit hole of `:>`, `<:`, `%>`, etc, etc.

### implements vs satisfies

We use `satisfies` so that type constraints can use a syntax
that is regular with class and interface declarations. `extends`
or `implements` would simply not work for an upper bound type
constraint.

## Visibility model

### no protected keywords?

In our view, there is zero software-engineering justification for
`protected`. A dependency is a dependency. Whether its coming from
a subtype or not is irrelevant.

### override vs actual

`override` is a verb, and doesn't read well when combined with other
annotations. Annotations read best together when they are all
adjectives.

## Constructs

### Introductions

They are extension methods on steroids.

### union types

TODO complete this

The use of union types actually turns out to nicely resolve
some of the problems with a Haskell/ML/Scala `Option`/`Maybe` types.
The union types are much more transparent, since you never need
to instantiate an `Option`.

They also work nicely for type (arg) inference. 
One of the problems in Java generics is that the compiler often
infers types that are "non-denotable", i.e. not representable within
the Java language. This results in *really* confusing error messages.
That *never* happens in Ceylon, since union types are denotable and
the compiler never needs to infer any kind of existential type.