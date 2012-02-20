---
layout: tour
title: Tour of Ceylon&#58; Introduction
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# #{page.title}

This is the fourth leg of the Tour of Ceylon. In the [previous leg](../inheritance)
you learned about inheritance and refinement. In this leg you're going to learn 
about *introduction*.

## Introduction

Sometimes, especially when we're working with code from modules we don't have 
control over, we would like to mix an interface into a type that has already 
been defined in another module. For example, suppose we wanted to use a
`Polar` class, like the one we met in the [second leg](../classes), in some 
packaged module with some other packaged library that defines the following 
`Position` interface:

    shared interface Position {
        shared formal Float vertical;
        shared formal Float horizontal;
    }

To make this a little more concrete, suppose the library also defined the 
following useful toplevel method:

    shared void drawLine(Position from, Position to) { .... }

We would like to be able to pass `Polar` coordinates to `drawLine()`.
Since `Polar` is defined in a module that is out of our control, we can't 
simply write:

    class Polar(Float angle, Float radius) satisfies Position { ... }

Even if `Polar` _is_ our own class, there might be good reasons why we don't
want want to introduce a dependency to the library which defines `Position`
and `drawLine()` into our general-purpose coordinates module.

Instead, we can introduce the type `Position` in the code which uses the 
`Polar` coordinates as `Position`s.

    import com.redhat.polar.core { Polar }
    import com.somecompany.positions { Position }
    
    doc "Adapter that introduces Position to Polar."
    shared interface PolarPosition
            adapts Polar
            satisfies Position {
        
        shared actual default Float horizontal { 
            return radius * cos(angle);
        }         
        
        shared actual default Float vertical { 
            return radius * sin(angle);
        }
        
    }

Glossing over the `import` statements (they'll be covered [later](../missing-pieces#packages_and_imports)), what's important
is the `adapts` clause. This makes `PolarPosition` a special kind of interface called an 
*adapter*. There are a couple of restrictions applying to the members of an adapter. 
According to the language spec:

> An adapter may not:
>
> * declare or inherit a member that refines a member of any adapted type, or
> * declare or inherit a `formal` or non-`default` `actual` member unless the
>   member is inherited from an adapted type.

The purpose of an adapter is to add a new supertype, called an 
*introduced type*, to an existing type, called the *adapted type*. The adapter 
doesn't change the original definition of the adapted type, and it doesn't 
affect the internal workings of an instance of the adapted type in any way. 
All it does is "fill in" the definitions of the missing operations. Here, the 
`PolarPosition` interface provides concrete implementations of all members of 
`Position` that are not implemented by `Polar`.

Now, to introduce `Position` to `Polar` in a certain compilation unit, all we 
need to do is `import` the adapter:

    import com.redhat.polar.core { Polar, pi }
    import com.somecompany.positions { drawLine }
    import com.redhat.polar.adapters { PolarPosition }
    
    ...
    
    drawLine(Polar(0.0), Polar(pi/2, 1.0));

Note that the introduction is not visible outside the lexical scope of the 
`import` statement (the compilation unit). But within the compilation unit 
containing the `import` statement, every instance of the adapted type 
`Polar` now has all the attributes and methods of the introduced type 
`Position`, and is assignable to the introduced type.

Again, according to the spec:

> If, in a certain compilation unit, multiple introductions of a certain 
> adapted type declare or inherit a member that refines a common member of 
> a common supertype then either:
>
> * there must be a unique member from the set of members, called the most 
>   refined member, that refines all the other members, or
> * the adapted type must declare or inherit a member that refines all the 
>   members.
>
> At runtime, an operation (method invocation, member class instantiation, or 
> attribute evaluation) upon any type that is a subtype of all the adapted 
> types is dispatched according to the following rule:
>
> * If the runtime type of the instance of the adapted type declares or 
>   inherits a member defining the operation, the operation is dispatched to 
>   the runtime type of the instance.
> * Otherwise, the operation is dispatched to the introduction that has the 
>   most-refined member defining the operation.

Don't bust your brain thinking through this passage. What matters is that
the compiler will make sure that you don't ever use introductions in a way
that would result in ambiguities, arbitrary behavior, or loss of polymorphism.


## Introduction compared to extension methods and implicit type conversions

Introduction is Ceylon's way of extending a type after it's been defined. 
It's interesting to compare introduction to the following features of other 
languages:

* extension methods, and
* user-defined implicit type conversions.

Introduction is really just a much more powerful cousin of extension methods. 
From our point of view, an extension method introduces a member to a type, 
without actually introducing a new supertype. Indeed, a Ceylon adapter with 
no `satisfies` clause is actually a package of extension methods!

    shared interface StringSequenceExtensions
            adapts Sequence<String> {
        
        shared String concatenated {
            variable String concatenation := "";
            for (string in this) {
                concatenation += string;
            }
            return concatenation;
        }
        
        shared String join(String separator=", ") {
            variable String concatenation := this.first;
            for (string in this.rest) {
                concatenation += separator + string;
            }
            return concatenation;
        }
        
    }

On the other hand, introductions are less powerful than implicit type 
conversions. This is by design! In this case, "less powerful" means 
"safer, more disciplined". The power of implicit type conversions comes partly 
from their ability to work around some of the designed-in limitations of the 
type system. But these limitations have a purpose! In particular, the 
prohibitions against:

* inheriting the same generic type twice, with different type arguments (in most languages), and
* overloading (in Ceylon).

Implicit type conversions are an end-run around these restrictions, 
reintroducing the ambiguities that these restrictions exist to solve.

Furthermore, it's extremely difficult to imagine a language with implicit 
type conversions that preserve the following important properties of the 
type system:

* transitivity of the assignability relationship,
* covariance of generic types,
* the semantics of the identity `==` operator, and
* the ability to infer generic type arguments of an invocation or instantiation.

Finally, implicit type conversions work by having the compiler introduce 
hidden invocations of arbitrary user-written procedural code, code that could 
potentially have side-effects or make use of temporal state. Thus, the 
observable behavior of the program can depend upon precisely where and how 
the compiler introduces these "magic" calls.

Introductions are a kind of elegant compromise: more powerful than plain 
extension methods, safer than implicit type conversions. We think the beauty 
of this model is a major advantage of Ceylon over similar languages.


## There's more...

Next, we're going to meet [sequences](../sequences), Ceylon's take on the 
"array" type.

 
