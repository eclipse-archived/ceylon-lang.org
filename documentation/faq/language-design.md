---
title: Language design Frequently Asked Questions 
layout: faq
toc: true
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# FAQ about language design

#{page.table_of_contents}

You probably want to take the [Tour](/documentation/tour) before 
reading this, or the questions might not make sense.

Designing a language is about trade offs. Some features are 
sacrificed to make room for others and some syntax ideas are 
abandoned to better fit the language goals.

### Goals

The goals behind the design of Ceylon are multiple, here are some 
of the most important ones:

* To be easy to read and understand, even for beginners.
* To have a very regular syntax.
* To offer a typesafe hierarchical syntax for treelike structures,
  especially user interfaces.
* To be extremely typesafe, completely avoiding the use of 
  exceptions to handle any kind of typing-related problem.
* To allow excellent tool support, including extremely helpful and 
  understandable error messages.
* To provide excellent support for modularity.
* to reuse the good of Java.

## Syntax

### String interpolation syntax

> Why not `"Hello $name"` or `"Hello ${name.uppercased}"` instead 
> of `"Hello" name ""`?

Primarily because it looks a bit cleaner for defining text in user
interfaces or other treelike structures.

    Html hello {
        Head head { title="Greeting"; }
        Body body {
            P { "Hello" name ". Welcome back!" }
        }
    }

We originally looked into the `${...}` syntax, but it turns out that 
this can't be lexed using a regular expression. Groovy, for example, 
uses a complex hand-coded lexer to handle this stuff. From a pure
language-designer perspective, that's a real red flag. The syntax 
that we ended up settling on isn't as great for everyday procedural
code, but it *is* much nicer for defining UIs using the declarative
syntax (which are a primary goals for the language).

### Semicolons `;` at the end of line?

> Optional semicolons are in fashion! All the kids at school are
> doing it!

It's a choice between semicolons or the ugly `@annotation` syntax. 
You need one or the other, or your language can't be parsed. Languages
which ditch the semicolon *have* to introduce a special punctuation 
for annotations, and that means that they also have to keywordize 
common modifiers like `public`, `virtual`, etc, since they just 
can't stomach the ugly syntax for their own annotations (they can't 
bring themselves to make you write `@public` or `@virtual`).

We chose what with think is the lesser of two evils.

### Parentheses `()` in control structures

> Why do I need the parentheses in `if (something) { ... }`?

Because `something { ... }` is a legal expression in Ceylon
(a named argument method invocation), making `if something { ... }`
ambiguous.

### Prefix instead of postfix type annotations

> Why do you follow C and Java in putting type annotations
> first, instead of Pascal and ML in putting them after the
> declaration name?

Because we think this:

    shared Float e = ....
    shared Float log(Float b, Float x) { ... }

Is simply much easier to read than this:

    shared value e: Float = .... 
    shared function log(b: Float, x: Float): Float { ... }

And we simply don't understand how anyone could possibly 
think otherwise!

### Colon `:` vs. `extends` for inheritance

> Why `extends` instead of the much more compact `:`?

It's partially a matter of taste. But the real reason is that 
if you want to use `:` for `extends`, you then need to come up 
with punctuation that means `satisfies`, `abstracts`, `of`, 
`adapts`, etc, and you wind up in a rabbit hole of cryptic 
character combinations like `:>`, `<:`, `%>`, etc, etc.

In general, Ceylon favours being more explicit at the cost of 
being a little more verbose, so we prefer keywords and annotations 
to cryptic punctuation.

### `implements` vs. `satisfies`

> Did you really have to go and rename `implements`?!

We use `satisfies` so that type constraints have a syntax
that is regular with class and interface declarations. The
words `extends` and `implements` would simply not work for 
an upper bound type constraint. Consider:

    class Singleton<Element>(Element element)
            satisfies Iterable<Element> & Equality
            given Element satisfies Equality { ... }

Other language usually have an ugly or irregular syntax for
the upper bound constraint `satisfies Equality`. In Ceylon,
it's regular and elegant. But we thought that the word 
`implements` didn't work here, since the upper bound might
be a class or even another type parameter.

## Declaration modifiers

### No `protected` modifier?

> Why is there no `protected` visibility modifier in Ceylon?

In our view, there is zero software-engineering justification 
for `protected`. A dependency is a dependency. Whether it's 
coming from a subtype or not is completely irrelevant. What
_does_ matter is what package or module the dependency comes
from. 

Our visibility levels are designed to serve objective software 
engineering ends, not vague superstitions.

### No `final` modifier?

> Why is there no way to make a class `final`?

Since all members of a type are "final" by default, a subtype
can't break its supertypes by refining a member unless the
supertype _explicitly_ allows this by declaring the member
`default`. So a `final` modifier to prevent inheritance from
a class would serve no purpose.

### `overrides` vs. `actual`

> Why rename `overrides`?

The word "override" is a verb, and doesn't read well when 
combined with other annotations. Annotations read best together 
when they are all adjectives.

### `abstract` vs. `formal`

> Why do you use `formal` to define an abstract member?

Ceylon supports member classes and member class refinement.
An `abstract` nested class is a different thing to a `formal`
member class. A `formal` class can be instantiated. An 
`abstract` class cannot be.

Actually, if you think about it carefully, you'll notice that 
in Java `abstract` means something completely different for
classes to what it means for members. That works out OK in
Java because Java doesn't have member class refinement.

## Constructs

### Overloading

> Why doesn't Ceylon have overloading?

Well, overloading interacts with a number of other language 
features though, in truth, the interactions could probably
be controlled by sufficiently restricting the signature of
overloaded declarations. And overloading also maps bady to
the JVM because generic types are erased from signatures.
But again, there are potential workarounds for this problem.

The are really two main reasons why overloading doesn't make
much sense in Ceylon:

1. support for union types and sequenced parameters (varargs)
   make overloading unnecessary, and
2. method references to overloaded declarations are ambiguous.

Nevertheless, for interoperability, we _are_ going to need 
some way to call overloaded methods and constructors of 
classes defined in Java. We haven't totally decided what to
do here yet, but we will probably introduce an ugly syntax
for disambiguating overloaded declarations.  

### Tuples

> Will Ceylon support tuples?

Great question. We haven't decided yet. It's the #1 feature 
request from the community. 

### Variables

> The distinctions between immutable and mutable, the `variable` 
> annotation, and `=` and `:=` look like a lot of rules to 
> remember.

The rules are:

* If you want to be able to assign a value to something more 
  than once, you need to annotate it `variable`. It's the 
  precise opposite of Java where you need to annotate something 
  `final` if you don't want to be able to assign to it.
* To assign to a `variable`, you use `:=`. Otherwise, you use 
  `=`.

Like in ML, this is to warn you that the code is doing something 
side-effecty.

<!--

Introductions are a compromise between two features you'll find 
in other languages. Extension methods (best known from C#) and 
implicit type conversions (featured in several languages including 
C++ and Scala).

Extension methods are a safe, convenient feature that let you add 
new members to a pre-existing type. Unfortunately, they don't give 
you the ability to introduce a new supertype to the type.

Implicit type conversions are a dangerous feature that screw up 
several useful properties of the type system (including transitivity 
of assignability), introducing complexity into mechanisms like member 
resolution and type argument inference, and can easily be abused.

Introduction is a disciplined way to introduce a new supertype to an 
existing type, using a mechanism akin to extension methods, without 
the downsides of implicit type conversions.

-->

### Union types

TODO finish this!

The use of union types actually nicely resolves some of the problems 
with Haskell/ML/Scala `Option`/`Maybe` types. The union types are 
much more transparent, since you never need to instantiate an `Option`.

They also work nicely for type (arg) inference. One of the problems in 
Java generics is that the compiler often infers types that are 
"non-denotable", i.e. not representable within the Java language. This 
results in *really* confusing error messages. That never happens in 
Ceylon, since union and intersection types are denotable and there are
no wildcard types.

Union types also help make overloading unnecessary.
