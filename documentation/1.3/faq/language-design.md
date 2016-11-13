---
title: Language design Frequently Asked Questions 
layout: faq13
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

Here's a list of some of the ideas motivating the design of
Ceylon. The language should:

* have a very regular syntax, and a uniform type system without 
  primitively-defined special cases,
* be easy to read and understand, even for beginners, even for
  non-Ceylon-programmers reading your Ceylon code on your blog 
  or on GitHub,
* be extremely typesafe, completely avoiding the use of 
  exceptions to handle any kind of typing-related problem, 
  including things like null references and missing list 
  elements,
* avoid introducing primitively-defined constructs in favor of 
  providing syntax sugar for common cases that would otherwise
  be unacceptably verbose,  
* have a static type checker that reasons about the code 
  according to intuitive rules that can always be reproduced 
  by the programmer, and using only denotable types that can 
  be written down in the language itself, 
* have excellent tool support, including extremely helpful 
  and understandable error messages, and powerful IDEs,
* offer a typesafe hierarchical syntax for treelike structures,
  especially user interfaces, this completely eliminating XML
  from the picture,
* provide excellent, completely integrated support for 
  modularity,
* make it easier to write more generic code, and provide 
  support for disciplined metaprogramming,
* reuse the good of Java, while remaining open to good ideas 
  from other language families,
* abstract away from differences between the target virtual
  machine platforms, and
* have a specification that defines with precision the 
  syntax, semantics, and type system, using fully-specified 
  terminology. 

At a slightly more abstract level, you can read about the five
important concerns that guide the design of the whole platform
[here](/blog/2012/01/10/goals/).

### Functional programming

> Is Ceylon a functional programming language?

Before I can answer, please first tell me what you mean by 
that. What makes a _programming language_ "functional"?

I suppose I can try to take a bit of a guess at what you 
_might_ mean, but that leaves me even more confused:

* Does it mean that all functions are pure (without side 
  effect) and there are no variables? Then Lisp and ML aren't 
  functional? So the only well-known functional language is 
  Haskell?
* Does it mean support for higher-order functions? Then 
  Smalltalk, Python, Ruby, JavaScript, C#, Java 8, Ceylon, 
  and arguably even C are all functional programming languages?
* Does it mean no loops? What if a programming language defines
  `for` as a syntax sugar for a function call? Oh, so then
  "functional programming language" boils down to not having
  `break`, `continue` and `return`?
* Does it mean support for parametric polymorphism? Then C# 
  and Java 5 are functional?
* Could it mean an emphasis upon higher-level abstractions 
  named after definitions in category theory? Then, again, 
  Scheme and ML are excluded?

Perhaps what you really want to ask is: 

> Does Ceylon encourage you to write code using immutability,
> parametric polymorphism, and higher order functions? 

Well then, that's easy: yes, it certainly does.

## Syntax

### String interpolation syntax

> Why not `"Hello $name"` or `"Hello ${name.uppercased}"`?

Primarily because it looks a bit cleaner for defining text 
in user interfaces or other treelike structures.

<!-- try: -->
    Html hello {
        Head head { title="Greeting"; }
        Body body {
            P { "Hello ``name``. Welcome back!" }
        }
    }

We did originally investigate the `${...}` syntax, but it 
turns out that syntax would require a stateful lexer and, 
since `}` is a legal token in the language, is more fragile 
when editing code in an IDE. Anyway, some of us just don't 
love seeing dollar signs all over the place. It reminds us 
of languages we don't like.

### Semicolons `;` at the end of line?

> Optional semicolons are in fashion! All the kids at school 
> are doing it!

Well, which of the following do you prefer to look at:

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

It's a choice between semicolons or the ugly `@annotation` 
syntax for user-defined annotations. You need one or the other, 
or your language can't be parsed. Languages which ditch the 
semicolon *have* to introduce a special punctuation for 
annotations, and that means that they also have to keywordize 
common modifiers like `public`, `virtual`, etc, since they 
just can't stomach this nasty syntax for their own annotations 
(they can't bring themselves to make you write `@public` or 
`@virtual`).

This problem becomes especially acute when the language 
designer realizes they want to introduce a _new_ modifier, 
like `override` or `tailrec`, and we end up with the 
loveliness of `@Override` or `@tailrec`. In Ceylon, since our 
modifiers aren't keywords, we can cleanly introduce new 
modifiers when needed, without breaking existing code. Indeed, 
we've already done it: in 1.1, we added `sealed`.

We chose what we think is the lesser of two evils.

Ceylon has so many other more powerful ways to reduce 
verbosity, that semicolons are simply small beer.

### Parentheses `()` in control structures

> Why do I need the parentheses in `if (something) { ... }`?

Because `something { ... }` is a legal expression in Ceylon
(a named argument function invocation), making `if something { ... }`
ambiguous.

### Required braces `{}` in control structures

> Why can't we make the braces optional for control structures
> with a single-statement bodies?

Same reason: `{}` is a legal expression in the language, so
`if (something) {` would be quite ambiguous.

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

### Pointy brackets `<` `>` for generics 

> Why does Ceylon use pointy brackets `<` `>` for generics 
> like Java and C# instead of square brackets `[` `]` like 
> Scala?

Ceylon retains the more traditional interpretation that 
square brackets enclose lists, in our case, immutable 
sequences or tuples. This means that Ceylon has a very 
regular syntax for tuples and sequences:

    [] unit = [];
    [Integer] singleton = [1];
    [Float,Float] pair = [1.0, 2.0];
    [Float,Float,String] triple = [0.0, 0.0, "origin"];
    [Integer*] cubes = [ for (x in 1..100) x^3 ];

In Scala, the equivalent code looks like this:

<!-- try: -->
    val unit: Unit = ()
    val singleton: Tuple1[Long] = new Tuple1(1)
    val pair: (Double,Double) = (1.0, 2.0)
    val triple: (Double,Double,String) = (0.0, 0.0, "origin")
    val cubes: List[Integer] = ... 

Ceylon is more regular here.

### Colon `:` vs. `extends` for inheritance

> Why `extends` instead of the much more compact `:`?

It's partially a matter of taste. But the real reason is that 
if you want to use `:` for `extends`, you then need to come 
up with punctuation that means `satisfies`, `abstracts`, `of`, 
etc, and you wind up in a rabbit hole of cryptic character 
combinations like `:>`, `<:`, `%>`, etc, etc.

In general, Ceylon favors being more explicit at the cost of 
being a little more verbose, so we prefer keywords and 
annotations to cryptic punctuation.

### `implements` vs. `satisfies`

> Did you really have to go and rename `implements`?!

Ceylon uses `satisfies` to specify a supertype in three
locations:

- a class may satisfy an interface,
- an interface may satisfy an interface, or
- a type parameter may satisfy any type.

Ceylon uses `extends` to specify a supertype in two 
situations:

- a class may extend a class,
- a constructor may delegate to another constructor.

Unlike in Java, the syntax of the `extends` clause is quite
different to the syntax of the `satisfies` clause: 

- The `extends` clause specifies a single class or class 
  constructor, _with arguments to instantiate the class_.
- The `satisfies` clause, on the other hand, always specifies 
  an intersection of types, and never has arguments.

Now, in principle we could have used the keyword `implements` 
instead of `satisfies`. But is it natural to say that a type 
parameter "implements" its upper bounds? Is it natural to say 
that one interface "implements" a second interface? We don't
think so.

The designers of Java didn't think so either, which is why in 
Java, irregularly, a class `implements` interfaces, but an 
interface `extends` interfaces, even though the syntax and 
semantics are otherwise identical!

What's nice here is that type constraints in Ceylon have a 
syntax that is regular with class and interface declarations. 
Consider:

<!-- try: -->
    class Singleton<Element>(Element element)
            satisfies Sequence<Element>
            given Element satisfies Object { ... }

Many other languages, including Java, have an ugly or 
irregular syntax for the upper bound type constraint 
`given Element satisfies Object`. In Ceylon, it's regular 
and it reads well. We don't think 
`given Element implements Object` would have been as elegant 
here. A type parameter doesn't "implement" anything. 

### Prefix form for `is Type`, `exists`, and `nonempty`

> Wouldn't it be much more natural to write `name exists`
> or `person is Employee` instead of `exists name` and
> `is Employee person`?

Yes, but it would not work well in two situations:

First, when declaring a variable inline in a control structure
condition, for example:
  
<!-- try: -->
      if (exists second = seq[1]) { ... }
      
The following doesn't work because `exists` has a higher
precedence than `=`:

<!-- try: -->
      if (second = seq[1] exists) { ... } //confusing unsupported syntax

And it looks even worse with destructuring:

<!-- try: -->
      if ([first, *rest] = process.arguments nonempty) { ... } //confusing unsupported syntax

Second, when combined with the `!` (not) operator:

<!-- try: -->
      if (!is Employee person) { ... }
      
The following reads ambiguously, because it's not immediately
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
leave off a `shared` annotation, the compiler will let you 
know about that.

By the same token, defaulting to shared visibility would mean
that clients can't trust the APIs they use. You would never 
be quite sure that the API you're using _really_ meant to 
publish some operation, or whether the developer just forgot 
to add a `private` annotation.

Precisely the same arguments apply to refinement and the
`default` annotation, and to mutability and the `variable` 
annotation. Following Java, we could have made `default` the 
default ;-) and, likewise, we could have made `variable` the 
default, providing a Java-like `final` annotation to specify 
the more restrictive option. But then I'm never sure if you 
_really_ meant for some operation of your API to be refinable 
or settable by a client, and if you _really_ designed your 
class to tolerate that&mdash;or if you just forgot to add 
`final`.

### `shared` vs. `public`

> Why on earth did you rename `public`?

Ceylon has a quite different model for specifying visibility,
with just one annotation instead of the three annotations we 
would have needed to handle our four visibility levels. We 
have:

- private, 
- package-private, 
- module-private, and 
- public.

So the `shared` annotation does indeed sometimes mean "public".
But on the other hand it sometimes means package-private or
module-private! A `shared` declaration is only public if every
containing declaration, along with the containing package, is
also `shared`. 

### No `protected` modifier?

> Why is there no `protected` visibility modifier in Ceylon?

In our view, there is zero software-engineering justification 
for `protected`. A dependency is a dependency. Whether it's 
coming from a subtype or not is completely irrelevant. What
_does_ matter is what package or module the dependency comes
from.

Our visibility levels are designed to serve objective software 
engineering ends, not vague superstitions.

### `overrides` vs. `actual`

> Why rename `overrides`?

The word "override" is a verb, and doesn't read well when 
combined with other annotations. Annotations read best 
together when they're all adjectives.

### `abstract` vs. `formal`

> Why do you use `formal` to define an abstract member?

Ceylon supports member classes and member class refinement. 
And so for nested classes, `abstract` and `formal` are both
meaningful modifiers with quite different semantics!

An `abstract` nested class is a different thing to a `formal`
member class. A `formal` class can be instantiated. An 
`abstract` class cannot be.

Actually, if you think about it carefully, you'll notice that 
in Java `abstract` means something completely different for
classes to what it means for members. That works out OK in 
Java because Java doesn't have member class refinement.

### The `variable` modifier

> Why isn't `variable` a keyword?

All declarations in Ceylon follow a regular grammar 
expressible in BNF:

<!-- lang: bnf -->
    Annotation*
    (keyword | Type) Name 
    TypeParameters? Parameters*
    ("of" CaseTypes)? 
    ("extends" ExtendedType)? 
    ("satisfies" SatisfiedTypes)?
    TypeConstraint*
    Definition

Now with this in mind, consider the syntax of a variable 
declaration with an explicit type. We write:

    variable Integer count = 0;

If `variable` were a keyword, this declaration would not
actually conform to the grammar above, since it would be of 
the form `keyword Type Name`. So, instead, by making it an 
annotation instead of a keyword, we preserve the regularity 
of the language, at the cost of making a variable declaration 
with inferred type _slightly_ more verbose than in some other 
languages:

    variable value count = 0;

We're perfectly comfortable with that tradeoff, since 
`variable` declarations are actually surprisingly uncommon
in Ceylon. We quite intentionally require a little ceremony 
here.

## Language features

### Optional types

> How is Ceylon's `T?` type different to an `Option<T>` or 
> `Maybe t` type? What's wrong with a Java-like null?

In languages which don't support first-class union types, 
`null` is either:

* a primitive value, like in Java, C#, Smalltalk, Python, 
  Ruby, etc, or
* a case of an algebraic type, like in ML or Haskell. 

(Some languages, notably Scala, and now also Java 8, have 
*both* kinds of null, but this only happens because the
language designers realized how harmful primitive `null` is 
too late in the evolution of the language.)

Primitive null values are usually defined to be assignable to 
the language's bottom type if it has one, or, equivalently, 
to all types if it doesn't. We believe that this has been an 
enormous mistake with many practical consequences. 

(Some newer languages attempt to remedy this by introducing 
a kind of primitive optional type with null as a primitive 
value of that. We eschew the use of primitive special types 
defined by fiat in the language spec, viewing such constructs 
as the root of much evil.)

On the other hand, using an algebraic type for optional values 
gives you typesafety, since `Option<T>` is not assignable to 
`T`, but is also quite inconvenient. Every time you assign a 
value of type T to `Option<T>`, you need to instantiate a 
`Some<T>` to wrap up your T. And if you have a collection 
which can contain null values, you'll get an instance of `Some` 
for every element of the collection, even if the collection 
contains very few null values. 

By using a union type, `Null|T`, Ceylon spares you the 
need to wrap your `T`. And there's zero overhead at runtime, 
because the compiler erases Ceylon's `null` object to a JVM 
primitive `null`. To the best of our knowledge no other 
existing language uses this simple, safe, and convenient 
model.

### Union and intersection types

> Why are union types so important in Ceylon?

First-class union types first made an appearance when we 
started trying to figure out a sane approach to generic type 
argument inference. One of the big problems in Java's generics 
system is that the compiler often infers types that are 
"non-denotable", i.e. not representable within the Java 
language. This results in *really* confusing error messages. 
That never happens in Ceylon, since union and intersection 
types are denotable.

As soon as we embraced the need for union types, they became 
a natural solution for the problem of how to represent optional
values (things which can be null) within the type system.

Once we started to explore some of the corner cases in our 
type argument inference algorithm, we [discovered that we were 
also going to need first-class intersection 
types](http://in.relation.to/Bloggers/UnionTypesAndCovarianceOrWhyWeNeedIntersections).

Later, we realized that union and intersection types have 
lots of other advantages. For example, they help make 
overloading unnecessary. And they make it easy to reason about 
algebraic/enumerated types. And intersections help us to 
narrow types. For example:

<!-- try: -->
    Foo foo = ... ;
    if (is Bar foo) {
        //foo has type Foo&Bar here!
    }

Eventually we realized all kinds of wonderful uses for unions 
and intersections and they're now the most distinctive and 
unique feature of the language. They're what makes Ceylon
ceylonic.

### Structural typing

> Wouldn't structural typing be nice?

Structural typing is a kind of static "duck" typing. It's an 
interesting path to get some of the flexibility of a dynamic 
language in a language with static types. A structural type 
is a bit like an interface in Java 7 (not like an interface 
in Ceylon!). But in a language with structural typing, a 
class does not have to _explicitly_ declare that it is a 
subtype of the structural type to be considered assignable 
to the structural type. Instead, the compiler just validates 
that the class provides operations that match the operations 
declared by the structural type wherever an instance of a
class is assigned to a structural type.

The problem with a structural type system is that, just like 
the dynamic type systems that inspire it, it doesn't work 
very well with tools. If I select a member of a class, and 
ask for all references, or select a member of an interface, 
and ask for all implementations, I'll get an _approximate_ 
list of results. If I ask my IDE to rename a member of a 
class or interface, it might do a smaller or bigger 
refactoring than I want; it might even break my code!

This isn't the right thing for a language intended for 
writing very large programs.

Furthermore, we're very skeptical of the claim that 
structural typing is really significantly more flexible than 
nominative typing, since so-called "structural" types are 
in fact only partially structural. All the operations of the 
structural type still have names! So you're never going to 
find a class that satisfies a structural type by fortunate 
serendipity. The chance of the names and signatures of 
several separate operations of the class _just happening_ to 
align with the names and signatures of the structural type 
is essentially zero except for in _extremely_ trivial cases.
In practice, the classes which satisfy a given structural 
type are going to need to be designed for that, with 
knowledge of the structural type, just like in a nominative
type system. Thus, it seems to us better to make that 
relationship explicit as it is in a nominative type system.

Indeed, some of the flexibility that is claimed to be an
advantage of structural typing is actually more likely to be
achievable in practice via the use of union and intersection
types.

There's one place, however, where structural types certainly
do work: _function types_. Thus, function types in Ceylon 
are indeed structural types, unlike in Java 8, where you 
have an explosion of single-method interfaces!

### Overloading

> Why doesn't Ceylon have overloading?

Well, overloading interacts with a number of other language 
features though, in truth, the interactions could probably
be controlled by sufficiently restricting the signature of
overloaded declarations. And overloading also maps badly to
both the JVM, where generic types are erased from signatures, 
and to JavaScript, where all typing information is 
completely erased from signatures. But there are potential 
workarounds for this problem, too.

The are really two main reasons why overloading doesn't make
much sense in Ceylon:

1. support for union types, default arguments, and variadic 
   parameters (varargs) make overloading unnecessary, and
2. function references to overloaded declarations are 
   ambiguous.

Nevertheless, for interoperability, Ceylon, _does_ let you 
call overloaded methods and constructors of classes defined 
in Java. Ceylon even lets you refine multiple overloaded 
versions of a method when extending a Java class or interface.

### Implicit type conversions

> Why doesn't Ceylon have any kind of implicit type 
> conversions?

An implicit type conversion is a type conversion that is 
inserted automatically by the compiler when a the type of an 
expression is not assignable to the thing is being assigned 
to. For example, the Java compiler automatically inserts a 
call to `Long.toString()` in the following code:

<!-- lang: java -->
    System.out.println("The time is: " + System.currentTimeMillis());

Some languages go as far as to allow the user to define their 
own implicit type conversions.

Ceylon doesn't have any kind of implicit type conversion, 
user-defined or otherwise. Every expression in Ceylon has a 
unique well-defined principal type.

The power of implicit type conversions comes partly from their 
ability to work around some of the designed-in limitations of 
the type system. But these limitations have a purpose! In 
particular, the prohibitions against:

* inheriting the same generic type twice, with different type 
  arguments (in most languages), 
* inheriting two different implementations of the same member
  (in many languages with mixin inheritance), and
* overloading (in Ceylon).

Implicit type conversions are an end-run around these 
restrictions, reintroducing the ambiguities that these 
restrictions exist to prevent. Any language with user-defined 
implicit type conversions is almost guaranteed to be riddled 
with unintuitive corner cases.

Furthermore, it's extremely difficult to imagine a language 
with implicit type conversions that preserves the following 
important properties of the type system:

* transitivity of the assignability relationship,
* distributivity of the assignability relationship over 
  covariant container types,
* the semantics of the identity `===` operator, and
* the ability to infer generic type arguments of an invocation 
  or instantiation.

Implicit type conversion is designed to look a little bit 
like subtyping to the user of an API, but it's _not_ subtyping, 
it doesn't obey the rules of subtyping, and it screws up the 
simple intuitive relationship between subtyping and 
assignability.

This problem is especially acute in a language with extensive
type inference.

For example, an implicit conversion doesn't "distribute over" a 
container type. If `A` is assignable to `B`, then we expect a 
`List<A>` to be a `List<B>`. And we might expect the expression 
`List(b,a)` to be of inferred type `List<B>`. Neither of these 
expectations are well-founded in a type system with implicit 
conversions.

In Ceylon, you can trust your intuitions about subtyping and
assignability because "`A` is assignable to `B`" is equivalent 
to "`A` is a subtype of `B`", always, everywhere, and 
transitively!

It gets worse. User-defined implicit type conversions work by 
having the compiler introduce hidden invocations of arbitrary 
user-written procedural code, code that could potentially have 
side-effects or make use of temporal state. Thus, the observable 
behavior of the program can depend upon precisely where and 
how the compiler introduces these "magic" calls.

Finally, back to our first example, Java's special-case implict 
type conversion of `Object` to `String` actually breaks the 
associativity of the `+` operator! Quick, what does this do:

<!-- lang: java -->
    print("1 + 1 = " + 1 + 1);

All this additional complexity, just to avoid _one method call?_

Thanks, but no thanks!

### Pattern matching

> Will Ceylon add pattern matching?

_Pattern matching_ means conditional statements which package
together branching and destructuring. A value is matched 
against a list of patterns and the branch associated with the
pattern is executed, with values automatically assigned to 
variables embedded in the pattern. For example:

<!-- try: -->
      switch (sequence)
      case ([]) { empty(); }
      case ([x]) { singleton(x); }
      case ([x,y]) { pair(x,y); }
      else {} 

We will probably, eventually, add pattern matching to Ceylon,
though we're not yet certain of exactly what form it will 
take. For now, we're leaving our options open so when can do 
this in the most elegant possible way when the time comes.

Note that there is little urgency for this feature, since 
Ceylon's flow-sensitive typing already quite comfortably 
solves some of the most common usecases for pattern matching.

Further note that Ceylon 1.2 introduces pattern-based 
destructuring for entries, sequences, and tuples in 
specification statements, `let` expressions, `for` loops and 
comprehensions, and in `exists` and `nonempty` conditions.

### Extension methods

> Will Ceylon support extension methods?

It's remotely possible, but we don't think we need them.

An extension method or attribute is a method or attribute 
introduced to a type within a certain lexical scope. For 
example, we might want to introduce an `uppercaseString` 
attribute to `Object` by writing an extension method like 
this:

<!-- try: -->
    shared String uppercaseString(Object this) {
        return this.string.uppercased
    }

Or a `printMe()` method to `String` like this:

<!-- try: -->
    shared void printMe(String this)() {
        print(this);
    }

The perceived need for extension methods arises in object
oriented languages where all functions are forced to belong
to a class, where `static` method invocations feel 
uncomfortable, and are not well-supported by tooling.

In Ceylon, toplevel functions are a totally natural and
comfortable part of the language, this discomfort simply
doesn't arise. Ceylon IDE for Eclipse can even suggest the 
toplevel functions applying to a type from the completion 
popup. 

### Variance

> Why does Ceylon support two systems of generic type 
> variance?

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

However, to support awesome interoperation with Java generics,
Ceylon also supports Java-style wildcards, using this syntax:

<!-- try: -->
    Array<Integer> ints = array(2, 4, 6);
    Array<out Object> objects = ints;

Since `Array` is invariant in its type parameter, `Array<Integer>`
isn't an `Array<Object>`. It can't be, because the signature 
of the `set()` method of `Array<Object>` is:

<!-- try: -->
    void set(Integer index, Object item)

So you can put things that aren't `Integer`s in an `Array<Object>`.

But `Array<Integer>` _is_ an `Array<out Object>`, where the 
signature of the `set()` method is:

<!-- try: -->
    void setItem(Integer index, Nothing item)

(i.e. contravariant occurrences of the type parameter would 
take the value `Nothing` in the covariant instantiation of 
the invariant type.)

We don't love use-site variance, but at least it's simpler
and cleaner in Ceylon than in Java.

### Type classes 

> Will Ceylon ever have type classes?

It's possible, likely even. From our point of view, a type 
class is a type satisfied by the metatype of a type. Indeed, 
we view a type class as a kind of reified type argument. 
Since Ceylon already supports reified types with typesafe 
metatypes, it's not unreasonable to consider providing the 
ability to introduce an additional type to the metatype of a 
type. Then we would support _metatype constraints_ of form 
`T is Metatype`, for example:

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


### Type constructor parameterization

> Will Ceylon have type constructor parameterization / 
> higher kinds?

Currently, support for higher-order and higher-rank generic
types is an [experimental feature of the 
language](/blog/2015/06/03/generic-function-refs/)
that is only available when compiling Ceylon for JavaScript
virtual machines.

The Ceylon typechecker itself has a rather [powerful and 
elegant implementation](/blog/2015/06/12/more-type-functions/) 
of type constructors and type constructor 
parameterization&mdash;the most elegant and powerful 
implementation in any object-oriented language, in our 
opinion. However, this is not yet an official part of the 
language, and is not defined by the language specification.

<!--
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
-->

Without type constructor parameterization, we can't form
certain higher-order abstractions, the most famous of which 
is `Functor`, which abstracts over "container types" that 
support the ability to `map()` a function to elements. 
(Another famous example is `Monad`.)

However, it's highly debatable whether Ceylon would actually
benefit from such abstractions.

### Generalized algebraic types

> Will Ceylon support GADTs?

Possibly, to some limited extent, in some future version.

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
when it has an expression of type `Expression<Float>` then 
it can't possibly be an `IntegerLiteral`.

However, there are some hairy decidability issues associated 
with GADTs that we havn't begun to tackle yet.


### Checked exceptions

> Why doesn't Ceylon have checked exceptions?

Most people agree that checked exceptions were a mistake in 
Java, and new frameworks and libraries almost never use them. 
We're in agreement with the designers of other later languages 
such as C#, which chose not to have checked exceptions.

And if you think about it carefully, the main reason for 
having exceptions in the first place is to work around the 
declared static types of our functions.

If we wanted to declare the exception as part of the signature 
of a function, we could just declare it in the return type 
like this:

<!-- try: -->
    Integer|NegativeException fib(Integer n) { ... }

The reason for using an exception is that we _don't_ want to 
force the direct caller of `fib()` to account for the 
exceptional case. Rather, the exception is a way to have the 
function not fulfill its promise to return an `Integer`, 
without breaking the soundess of the type system.

(OK, sure, Java doesn't have union types, so you can't write 
the above in Java, which I suppose provides a partial 
motivation for having checked exceptions in _Java_. But we're 
talking about Ceylon here.)

In Ceylon, [we distinguish "recoverable" failures from 
"unrecoverable" errors](/blog/2015/12/14/failure/), using
exceptions only for the second class of failure. 


### Constructors

> Does Ceylon really need constructors?

Originally we hoped to avoid adding a separate constructor
notion to the language. However, experience convinced us that
constructors are necessary, even though we only use them in
very rare cases. Constructors offer us three clear advantages:

- We can more cleanly separate the initialization logic of a
  class with more than one initialization path. Thus,
  constructors improved the APIs and internal implementations 
  of classes like `Array`, `ArrayList`, and `HashMap`.
- When a superclass has multiple initialization paths, a 
  subclass can inherit them using constructor delegation. This
  was simply not possible with any proposed workaround. Thus,
  constructors solved the difficult problem of implementing
  class hierarchies with `clone()` methods.
- Value constructors provide a firm foundational building 
  block for the notion of a "singleton" instance. Thus, we 
  were about to redefine the notion of an `object` anonymous
  class in a _much_ more satisfying way, in terms of value
  constructors.

Constructors in other languages have always left us with a bad 
taste in our mouths, so we spent a lot of design effort on 
making Ceylon's constructors regular and elegant, without
breaking any of the principles of block structure, visibility,
or definite initialization. 

Ultimately we're very happy with the result. 
