---
title: Language design Frequently Asked Questions 
layout: faq
toc: true
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# FAQ about language design

#{page.table_of_contents}

You probably want to take the [Tour](#{page.doc_root}/tour) before 
reading this, or the questions might not make sense.

Designing a language is about trade offs. Some features are 
sacrificed to make room for others and some syntax ideas are 
abandoned to better fit the language goals.

## Overview

### Goals

> What are the design goals of this language?

The goals behind the design of the language are multiple, here are 
some of the most important ones:

* To have a very regular syntax.
* To be easy to read and understand, even for beginners, even for
  non-Ceylon-programmers reading your Ceylon code on your blog or 
  on GitHub.
* To be extremely typesafe, completely avoiding the use of 
  exceptions to handle any kind of typing-related problem, 
  including things like null references and missing list 
  elements.
* That the reasoning of the compiler can always be reproduced by
  the programmer according to intuitive rules.
* To allow excellent tool support, including extremely helpful and 
  understandable error messages.
* To offer a typesafe hierarchical syntax for treelike structures,
  especially user interfaces, this completely eliminating XML
  from the picture.
* To provide excellent, completely integrated support for 
  modularity.
* To make it easier to write more generic code, amd provide support
  for disciplined metaprogramming.
* To reuse the good of Java, but to be open to good ideas from
  other language families.

At a slightly more abstract level, you can read about the five
important concerns that guide the design of the whole platform
[here](/blog/2012/01/10/goals/).

### Functional programming

> Is Ceylon a functional programming language?

Before I can answer, please first tell me what you mean by that.
What makes a _programming language_ "functional"?

I suppose I can try to take a bit of a guess at what you _might_ 
mean, but that leaves me even more confused:

* Does it mean that all functions are pure (without side effect)
  and there are no variables? Then Lisp and ML aren't functional?
  So the only well-known functional language is Haskell?
* Does it mean support for higher-order functions? Then Smalltalk,
  Python, Ruby, JavaScript, C#, Java 8, Ceylon, and arguably even 
  C are all functional programming languages?
* Does it mean no loops? What if a programming language defines
  `for` as a syntax sugar for a function call? Oh, so then
  "functional programming language" boils down to not having
  `break`, `continue` and `return`?
* Does it mean support for parametric polymorphism? Then C# and 
  Java 5 are functional?
* Does it mean an emphasis upon higher-level abstractions from
  category theory? Then Haskell is the only real functional 
  programming language?

Perhaps what you really want to ask is: 

> Does Ceylon encourage you to write code using immutability,
> parametric polymorphism, and higher order functions? 

Well then, that's easy: yes, it certainly does.

## Syntax

### String interpolation syntax

> Why not `"Hello $name"` or `"Hello ${name.uppercased}"`?

Primarily because it looks a bit cleaner for defining text in user
interfaces or other treelike structures.

<!-- try: -->
    Html hello {
        Head head { title="Greeting"; }
        Body body {
            P { "Hello ``name``. Welcome back!" }
        }
    }

We did originally investigate the `${...}` syntax, but it turns out 
that this requires a stateful lexer and is more fragile when editing
code in an IDE. Anyway, some of us just don't love seeing dollar
signs all over the place.

### Semicolons `;` at the end of line?

> Optional semicolons are in fashion! All the kids at school are
> doing it!

Which of the following do you prefer:

<!-- try: -->
    shared variable 
    oneToMany column("PID") 
    synchronized
    Person person = somePerson;

where `shared` and `variable` are just ordinary annotations,
or, alternatively:

<!-- try: -->
    shared variable 
    @oneToMany @column("PID") 
    @synchronized
    Person person = somePerson

where `shared` and `variable` are keywords?

It's a choice between semicolons or the ugly `@annotation` syntax. 
You need one or the other, or your language can't be parsed. Languages
which ditch the semicolon *have* to introduce a special punctuation 
for annotations, and that means that they also have to keywordize 
common modifiers like `public`, `virtual`, etc, since they just 
can't stomach the ugly syntax for their own annotations (they can't 
bring themselves to make you write `@public` or `@virtual`).

We chose what we think is the lesser of two evils.

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

<!-- try: -->
    shared Float e = ....
    shared Float log(Float b, Float x) { ... }

Is simply much easier to read than this:

<!-- try: -->
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

<!-- try: -->
    class Singleton<Element>(Element element)
            satisfies Iterable<Element>
            given Element satisfies Object { ... }

Other language usually have an ugly or irregular syntax for
the upper bound constraint `satisfies Object`. In Ceylon,
it's regular and elegant. But we thought that the word 
`implements` didn't work here, since the upper bound might
be a class or even another type parameter.

### Prefix form for `is Type`, `exists`, and `nonempty`

> Wouldn't it be much more natural to write `name exists`
> or `person is Employee` instead of `exists name` and
> `is Employee person`?

Yes, but it would not work in two situations:

First, when declaring a variable inline in a control structure
  condition, for example:
  
<!-- try: -->
      if (exists second = seq[1]) { ... }
      
The following doesn't work because `exists` has a higher
precedence than `=`:

<!-- try: -->
      if (second = seq[1] exists) { ... } //confusing unsupported syntax
      
Second, when combined with the `!` (not) operator:

<!-- try: -->
      if (!is Employee person) { ... }
      
The following reads ambiguously, because it's not entirely
clear that `!` has a lower precedence than `is`:

<!-- try: -->
      if (!person is Employee) { ... } //confusing unsupported syntax

## Declaration modifiers

### Verbosity of modifier annotations

> Why don't you have better defaults for `shared`, etc?

Of course, we could have chosen to make shared visibility the
default, providing a `private` annotation to restrict access.
But that would have been very harmful to modularity, a key
goal of the language.

The "best" default is the _most restrictive_ option. Otherwise,
the developer of a module might accidently make something
something shared that they don't intend to make shared, and
be forced to either continue to support the 
unintentionally-shared operation for the rest of the life of 
the module, or break clients. There would be nothing the 
compiler could do to warn you when you _accidently_ left off
a `private` annotation. On the other hand, if you accidentally 
leave off a `shared` annotation, the compiler will let you know 
about that.

By the same token, defaulting to shared visibility would mean
that clients can't trust the APIs they use. You would never 
be quite sure that the API you're using _really_ meant to 
publish some operation, or whether the developer just forgot 
to add a `private` annotation.

Precisely the same arguments apply to refinement and the
`default` annotation, and to mutability and the `variable` 
annotation. Following Java, we could have made 
`default` the default ;-) and we could have made `variable` 
the default, providing a Java-like `final` annotation to 
specify the more restrictive option. But then I'm never sure 
if you _really_ meant for some operation of your API to be 
refinable or settable by a client, and if you _really_ 
designed your class to tolerate that&mdash;or if you just 
forgot to add `final`.

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

## Language features

### Optional types

> How is Ceylon's `T?` type different to an `Option<T>` or `Maybe t`
> type? What's wrong with a Java-like null?

In languages which don't support first-class union types, `null` is
either:

* a primitive value, like in Java, C#, Smalltalk, Python, Ruby, 
  etc, or
* a case of an algebraic type, like in ML or Haskell. 

(Some languages, notably Scala, have *both* kinds of null, though 
this appears to be a design error.)

Primitive null values are usually defined to be assignable to the
language's bottom type if it has one, or, equivalently, to all 
types if it doesn't. We believe that this has been an enormous
mistake with many practical consequences. 

(Some newer languages attempt to remedy this by introducing a kind 
of primitive optional type with null as a primitive value of that. 
We eschew the use of primitive special types defined by fiat in the 
language spec, viewing such constructs as the root of much evil.)

On the other hand, using an algebraic type for optional values gives 
you typesafety, since `Option<T>` is not assignable to `T`, but is 
also quite inconvenient. Every time you assign a value of type T to 
`Option<T>`, you need to instantiate a `Some<T>` to wrap up your T. 
And if you have a collection which can contain null values, you'll 
get an instance of `Some` for every element of the collection, even 
if the collection contains very few null values. 

By using a union type, `Nothing|T`, Ceylon spares you the need to 
wrap your `T`. And there's zero overhead at runtime, because the 
compiler erases Ceylon's `null` object to a JVM primitive `null`.
To the best of our knowledge no other existing language uses this
simple, safe, and convenient model.

### Union and intersection types

> Why are union types so important in Ceylon?

First-class union types first made an appearance when we started
trying to figure out a sane approach to generic type argument
inference. One of the big problems in Java's generics system is 
that the compiler often infers types that are "non-denotable", 
i.e. not representable within the Java language. This results in 
*really* confusing error messages. That never happens in Ceylon, 
since union and intersection types are denotable and there are no 
wildcard types.

As soon as we embraced the need for union types, they became a
natural solution for the problem of how to represent optional
values (things which can be null) within the type system.

Once we started to explore some of the corner cases in our type
argument inference algorithm, we [discovered that we were also going 
to need first-class intersection types](http://in.relation.to/Bloggers/UnionTypesAndCovarianceOrWhyWeNeedIntersections).

Later, we realized that union and intersection types have lots of 
other advantages. For example, they help make overloading unnecessary. 
And they make it easy to reason about algebraic/enumerated types.
And intersections help us to narrow types. For example:

<!-- try: -->
    Foo foo = ... ;
    if (is Bar foo) {
        //foo has type Foo&Bar here!
    }

It turns out that support for first-class unions and intersections
is perhaps the very coolest feature of Ceylon.

### Structural typing

> Why doesn't Ceylon have structural typing?

Structural typing is a kind of "duck" typing. It's an interesting
path to get some of the flexibility of a dynamic language in a
language with static types. A structural type is a bit like an
interface in Java (not like an interface in Ceylon!). But in a
language with structural typing, a class does not have to 
explicitly declare that it is a subtype of the interface to be 
considered assignable to the interface type. Instead, the compiler 
just validates that the class provides operations that match the 
operations declared by the interface.

The problem with a structural type system is that, just like the 
dynamic type systems that inspire it, it doesn't work very well 
with tools. If I select a member of a class, and ask for all
references, or select a member of an interface, and ask for all 
implementations, I'll get an _approximate_ list of results. If 
I ask my IDE to rename a member of a class or interface, it might
do a smaller or bigger refactoring than you expect; it might even
break my code!

This isn't the right thing for a language intended for writing 
large programs.

### Overloading

> Why doesn't Ceylon have overloading?

Well, overloading interacts with a number of other language 
features though, in truth, the interactions could probably
be controlled by sufficiently restricting the signature of
overloaded declarations. And overloading also maps badly to
the JVM because generic types are erased from signatures.
But there are potential workarounds for this problem, too.

The are really two main reasons why overloading doesn't make
much sense in Ceylon:

1. support for union types, default arguments, and sequenced 
   parameters (varargs) make overloading unnecessary, and
2. method references to overloaded declarations are ambiguous.

Nevertheless, for interoperability, Ceylon, as of M2, _will_ 
let you call overloaded methods and constructors of classes 
defined in Java.

### Implicit type conversions

> Why doesn't Ceylon have any kind of implicit type conversions?

An implicit type conversion is a type conversion that is inserted
automatically by the compiler when a the type of an expression is 
not assignable to the thing is being assigned to. For example, the
Java compiler automatically inserts a call to `Long.toString()` in 
the following code:

<!-- lang: java -->
    System.out.println("The time is: " + System.currentTimeMillis());

Some languages go as far as to allow the user to define their own 
implicit type conversions.

Ceylon doesn't have any kind of implicit type conversion, 
user-defined or otherwise. Every expression in Ceylon has a unique
well-defined principal type.

The power of implicit type conversions comes partly from their 
ability to work around some of the designed-in limitations of the 
type system. But these limitations have a purpose! In particular, 
the prohibitions against:

* inheriting the same generic type twice, with different type 
  arguments (in most languages), 
* inheriting two different implementations of the same member
  (in many languages with mixin inheritance), and
* overloading (in Ceylon).

Implicit type conversions are an end-run around these restrictions, 
reintroducing the ambiguities that these restrictions exist to 
prevent. Any language with user-defined implicit type conversions 
is almost guaranteed to be riddled with unintuitive corner cases.

Furthermore, it's extremely difficult to imagine a language with 
implicit type conversions that preserves the following important 
properties of the type system:

* transitivity of the assignability relationship,
* distributivity of the assignability relationship over covariant
  container types,
* the semantics of the identity `===` operator, and
* the ability to infer generic type arguments of an invocation or 
  instantiation.

Implicit type conversion is designed to look a little bit like
subtyping to the user of an API, but it's _not_ subtyping, it 
doesn't obey the rules of subtyping, and it screws up the simple 
intuitive relationship between subtyping and assignability.

For example, an implicit conversion doesn't "distribute over" a 
container type. If `A` is assignable to `B`, then we expect a 
`List<A>` to be a `List<B>`. And we might expect the expression 
`List(b,a)` to be of inferred type `List<B>`. Neither of these 
expectations are well-founded in a type system with implicit 
conversions.

In Ceylon, you can trust your intuitions about subtyping and
assignability because "`A` is assignable to `B`" is equivalent to 
"`A` is a subtype of `B`", always, everywhere, and transitively!

It gets worse. User-defined implicit type conversions work by 
having the compiler introduce hidden invocations of arbitrary 
user-written procedural code, code that could potentially have 
side-effects or make use of temporal state. Thus, the observable 
behavior of the program can depend upon precisely where and how 
the compiler introduces these "magic" calls.

Finally, back to our first example, Java's special-case implict 
type conversion of `Object` to `String` actually breaks the 
associativity of the `+` operator! Quick, what does this do:

<!-- lang: java -->
    print("1 + 1 = " + 1 + 1);

All this additional complexity, just to avoid _one method call?_

### Extension methods

> Will Ceylon support extension methods?

Yes, probably.

An extension method or attribute is a method or attribute 
introduced to a type within a certain lexical scope. For example, 
we might want to introduce an `uppercaseString` attribute to 
`Object` by writing a method like this:

<!-- try: -->
    shared String uppercaseString(Object this) {
        return this.string.uppercased
    }

Or a `printMe()` method to `String` like this:

<!-- try: -->
    shared void printMe(String this)() {
        print(this);
    }

### Use site variance

> Will Ceylon ever support wildcard type arguments or any
> other kind of use site variance?

Ceylon embraces the concept of _declaration site variance_,
where the variance of a type parameter is specified where a
type is defined. For example:

<!-- try: -->
    interface Collection<out Element> { ... }

This spares us from having to write, as in Java, things like
`Collection<? extends String>` everywhere we use the type.
However, declaration site variance is strictly less powerful
than use site variance. We can't form a covariant type from 
an invariant type like in Java.

It would be possible to add support for use site variance to
Ceylon, probably using a syntax like this:

<!-- try: -->
    Array<Integer> ints = array(2, 4, 6);
    Array<out Object> = ints;

Since `Array` is invariant in its type parameter, `Array<Integer>`
isn't an `Array<Object>`. It can't be, because the signature 
of the `setItem()` method of `Array<Object>` is:

<!-- try: -->
    void setItem(Integer index, Object item)

So you can put things that aren't `Integer`s in an `Array<Object>`.

But `Array<Integer>` _would_ be an `Array<out Object>`, where 
the signature of the `setItem()` method would be:

<!-- try: -->
    void setItem(Integer index, Nothing item)

(i.e. contravariant occurrences of the type parameter would take 
the value `Nothing` in the covariant instantiation of the invariant
type.)

We're still trying really hard to _not_ need to add use site 
variance to Ceylon, I guess mainly because of all our traumatic 
experiences with this feature in Java. But, in fairness, the
feature would not be as awful in Ceylon because:

* `Nothing` is a denotable type,
* the syntax would not be awful, and
* we would have a simpler system without implicit bounds.

### Type classes 

> Will Ceylon have type classes?

Probably. From our point of view, a type class is a type 
satisfied by the metatype of a type. Indeed, we view type
classes as a kind of support for reified types. Since Ceylon 
will definitely support reified types with typesafe metatypes, 
it's not unreasonable to consider providing the ability to 
introduce an additional type to the metatype of a type. Then
we would support _metatype constraints_ of form `T is Metatype`, 
for example:

<!-- try: -->
    Num sum<Num>(Num* numbers)
            given Num is Number {
        variable Num total=Num.zero;
        for (num in numbers) {
            total=Num.sum(total,num);
        }
        return total;
    }

Here, `Number` is a _metatype_ (a type class) implemented by
the reified type of `Num`, not by `Num` itself.

You'll find some further discussion of this issue in 
[Chapter 3 of the language specification][metatypes].

[metatypes]:#{site.urls.spec_current}#metatypes

### Type constructor parameterization

> Will Ceylon have higher kinds?

Possibly, in some future version, though we prefer to avoid 
this terminology. You'll see us discuss this issue under the 
title _type constructor parameterization_ or even 
_parameterized type parameters_.

To understand what this is all about, we need to take a 
slightly different perspective on the notion of a generic 
type to the one that folks coming from C++ usually have. 
Instead of thinking about a parameterized type as a kind of
template, we'll think about it as a _type constructor_, 
meaning a function from types to types. Give it a list of
argument types, and the type constructor will give you back
a new type.

So, from this perspective, `Sequence` is a type constructor, 
`String` is an argument type, and `Sequence<String>` is the 
resulting type produced by the type constructor.

"Generics" (parametric polymorphism) is the ability to 
abstract the definition of a function or type over other
unknown types. Then type constructor parameterization is the 
ability to abstract the definition of a function or type not 
only over types but also over type constructors. 

Without type constructor parameterization, we can't form
certain higher-order abstractions, the most famous of which 
is `Functor`, which abstracts over "container types" that 
support the ability to `map()` a function to elements. 
(Another famous example is `Monad`.)

We have not yet decided if Ceylon needs this feature. It is
mentioned as a proposal in [Chapter 3 of the language 
specification][type constructor parameterization].

[type constructor parameterization]: #{site.urls.spec_current}#parameterizedtypeparameters

### Generalized algebraic types

> Will Ceylon support GADTs?

Probably, in some future version.

A GADT is a sophisticated kind of algebraic type where the 
cases of the type depend upon the value of one of its type
arguments. Consider:

<!-- try: -->
    abstract class Expression<T>()
            of Sum<T> | FloatLiteral | IntegerLiteral 
            given T of Float | Integer {}
    class FloatLiteral() extends Expression<Float>()  {}
    class IntegerLiteral() extends Expression<Integer>() {}

GADT support means that the compiler is able to reason that
when it has an expression of type `Expression<Float>` then it
can't possibly have an `IntegerLiteral`.

However, there are some decidability issues associated with
GADTs that we havn't begun to tackle yet.

You'll find some further discussion of this issue in 
[Chapter 3 of the language specification][gadts].

[gadts]:#{site.urls.spec_current}#d0e2399

### Type families

> Will Ceylon support type families?

Yes, probably. The Ceylon compiler already has support for 
this feature. However, we still need to investigate whether 
this feature is guaranteed to be decidable in all cases.

Self types and type families in Ceylon were previously 
[discussed here][type families]. In a nutshell:

> A self type is a type parameter of an abstract type (like 
> `Comparable`) which represents the type of a concrete 
> instantiation (like `String`) of the abstract type within 
> the definition of the abstract type itself. In a type family, 
> the self type of a type is declared not by the type itself, 
> but by a containing type which groups together a set of 
> related types. This allows the related types to refer to the
> unknown self type of the type.

[type families]: http://in.relation.to/Bloggers/SelfTypesAndTypeFamiliesInCeylon

<!--
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
-->
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

### Checked exceptions

> Why doesn't Ceylon have checked exceptions?

Most people agree that checked exceptions were a mistake in Java, 
and new frameworks and libraries almost never use them. We're in
agreement with the designers of other later languages such as C#,
which chose not to have checked exceptions.

And if you think about it carefully, the main reason for having 
exceptions in the first place is to work around the declared 
static types of our functions.

If we wanted to declare the exception as part of the signature 
of a function, we could just declare it in the return type like
this:

<!-- try: -->
    Integer|NegativeException fib(Integer n) { ... }

The reason for using an exception is that we _don't_ want to 
force the direct caller of `fib()` to account for the exceptional
case. Rather, the exception is a way to have the function not
fulfill its promise to return an `Integer`, without breaking the
soundess of the type system.

(OK, sure, Java doesn't have union types, so you can't write the
above in Java, which I suppose provides a partial motivation for
having checked exceptions in _Java_. But we're talking about 
Ceylon here.)
