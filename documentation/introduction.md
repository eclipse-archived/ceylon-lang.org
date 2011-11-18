---
layout: documentation
title: Quick Introduction to Ceylon
tab: documentation
unique_id: docspage
author: Gavin King
---

# Quick introduction

It's impossible to get to the essence of a programming language by looking
at a list of its features. What really *makes* the language is how all the
little bits work together. And that's impossible to appreciate without 
actually writing code. In this section we're going to try to quickly show 
you enough of Ceylon to get you interested enough to actually try it out.
This is *not* a comprehensive feature list!

## A familiar, readable syntax

Ceylon's syntax is ultimately derived from C. So if you're a C, Java, or C#
programmer, you'll immediately feel right at home. Indeed, one of the goals
of the language is for most code to be immediately readable to people who
*aren't* Ceylon programmers, and who *haven't* studied the syntax of the
language.

Here's what a simple function looks like:

    function distance(Point from, Point to) {
        return ((from.x-to.x)**2 + (from.y-to.y)**2)**0.5;
    }

Here's a simple class:

    shared class Counter(Natural initialValue=0) {
        
        value count = initialValue;
        
        shared currentValue {
            return count;
        }
        
        shared void increment() {
            count++;
        }
        
    }

Here's how we create and iterate sequences:

    String[] names = { "Tom", "Dick", "Harry" };
    for (name in names) {
        print("Hello, " name "!");
    }

If these code examples look boring to you, well, that's kinda the idea -
they're boring because you understood them immediately!

## Declarative syntax for treelike structures

Hierarchical structures are so common in computing that we have dedicated
languages like XML for dealing with them. But when we want to have procedural
code that interacts with hierarchical structures, the "impedence mismatch"
between XML and our programming language causes all sorts of problems. So
Ceylon has a special built-in "declarative" syntax for defining hierarchical 
structures. This is especially useful for creating user interfaces:

    Table table {
        title="Squares";
        rows=5;
        Border border {
            padding=2;
            weight=1;
        }
        Column {
            heading="x";
            width=10;
            String content(Natural row) {
                return row.string;
            }
        },
        Column {
            heading="x**2";
            width=10;
            String content(Natural row) {
                return (row**2).string;
            }
        }
    }

Any framework that combines Java and XML requires special purpose-built 
tooling to achieve type-checking and authoring assistance. Ceylon frameworks
that make use of Ceylon's built-in support for expressing treelike structures
get this, and more, for free.

## Principal typing, union types, and intersection types

Ceylon's type system is based on analysis of "best" or *principal* types.
For every expression, a unique, most specific type may be determined, without 
the need to analyze the code around it. And all types used internally by the 
compiler are *denotable* - that is, they can be expressed within the language 
itself. What this means in practice is that the compiler always produces 
errors that humans can understand, even when working with complex generic 
types.

An integral part of this system of denotable principal types is first-class
support for union and intersection types. A *union type* is a type which
accepts instances of any one of a list of types:

    Person|Organization personOrOrganization = ... ;

An *intersection type* is a type which accepts instances of all of a list
of types:

    Printable&Sized&Persistent printableSizedPersistent = ... ;

Union and intersection types help make things that are complex and magical
in other languages (especially generic type argument inference) simple and
straightforward in Ceylon. But they're also occasionally useful as a 
convenience in ordinary code.

## Mixin inheritance

Like Java, Ceylon has classes and interfaces. A class may inherit a single
superclass, and an arbitrary number of interfaces. An interface may inherit
an arbitrary number of other interfaces, but may not extend a class other
than `Object`. Unlike Java, interfaces may define concrete members. Thus,
Ceylon supports a restricted kind of multiple inheritance, called *mixin
inheritance*. 

    interface Sized {
        
        shared formal Natural size;
    
        shared Boolean empty {
            return size==0;
        }
    
    }
    
    interface Printable {
    
        shared void printIt() {
            print(this);
        }
        
    }
    
    object empty satisfies Sized & Printable {
    
        shared actual Natural size {
            return 0;
        }
        
    }

What really distinguished interfaces from classes in Ceylon is that 
interfaces are *stateless*. That is, an interface may not directly hold
a reference to another object, it may not have initialization logic, and
it may not be directly instantiated. Ceylon neatly avoids the need to
perform any kind of "linearization" of supertypes.

## Polymorphic attributes

Ceylon doesn't have fields, at least not in the traditional sense.
Instead, *attributes* are polymorphic, and may be refined by a subclass, 
just like methods in other object-oriented languages. 

An attribute might be a simple value:

    String name = firstName + " " + lastName;

It might be a getter:

    String name {
        return firstName + " " + lastName;
    }

Or it might be a getter/setter pair:

    String name {
        return fullName;
    }
    
    assign name {
        fullName := name;
    }

In Ceylon, we don't need to write trivial getters or setters, since the
state of a class is always completely abstracted from clients of the 
class.

## Typesafe null

There's no `NullPointerException` in Ceylon, nor anything similar. Ceylon
requires us to be explicit when we declare a value that might be null, or
a method that might return null. For example, if `name` might be null, 
we must declare it like this:

    String? name = ...

Which is actually just an abbreviation for:

    String|Nothing name = ...

An attribute of type `String?` might refer to an actual instance of `String`, 
or it might refer to the value `null` (the only instance of the class `Nothing`). 
So Ceylon won't let us do anything useful with a value of type `String?` 
without first checking that it isn't null using the special `if (exists ...)` 
construct.

    void hello(String? name) {
        if (exists name) {
            print("Hello, " name "!");
        }
        else {
            print("Hello, world!");
        }
    }

## Enumerated subtypes

In object-oriented programming, it's usually considered bad practice to write 
long `switch` statements that handle all subtypes of a type. It makes the code 
non-extensible. Adding a new subtype to the system causes the `switch` 
statements to break. So in object-oriented code, we usually try to refactor 
constructs like this to use an abstract method of the supertype that is 
refined as appropriate by subtypes.

However, there is a class of problems where this kind of refactoring isn't 
appropriate. In most object-oriented languages, these problems are usually 
solved using the "visitor" pattern. Unfortunately, a visitor class actually 
winds up more verbose than a `switch`, and no more extensible. There is, on
the other hand, one major advantage of the visitor pattern: the compiler 
produces an error if we add a new subtype and forget to handle it in one
of our visitors.

Ceylon gives us the best of both worlds. We can specify an *enumerated list
of subtypes* when we define a supertype:

    abstract class Node() of Leaf | Branch {}

And we can write a `switch` statement that handles all the enumerated subtypes:

    Node node = ... ;
    switch (node)
    case (is Leaf) { ... }
    case (is Branch) { .... }

Now, if we add a new subtype of `Node`, we must add the new the subtype to the
`of` clause of the declaration of `Node`, and the compiler will produce an error
at every `switch` statement which doesn't handle the new subtype.

## Type aliases and type inference

Fully-explicit type declarations very often make difficult code much easier to
understand. But there are other occasions where the repetition of a verbose
generic type can detract from the readability of the code. We've observed that:

1. explicit type annotations are of much less value for local declarations, and
2. repetition of a parameterized type with the same type arguments is common
   and extremely noisy in Java.

Ceylon addresses the first problem by allowing type inference for local 
declarations. For example:

    value names = LinkedList { "Tom", "Dick", "Harry" };

    function sqrt(Float x) { return x**0.5; }

On the other hand, for declarations which are accessible outside the compilation 
unit in which they are defined, Ceylon requires an explicit type annotation. We 
think this makes the code more readable, not less, and it makes the compiler more 
efficient and less vulnerable to stack overflows.

Ceylon addresses the second problem via *type aliases*, which are very similar
to a `typedef` in C.

    interface Strings = List<String>;

We encourage the use of both these language features where - *and only where* -
they make the code more readable.

## Higher-order functions

TODO

## Simplified generics and fully-reified types

TODO

## Operator polymorphism

TODO

## Typesafe metaprogramming

TODO

## Modularity

TODO

## Take the Tour

We're done with the introduction. Take the [tour of Ceylon](/documentation/tour/basics) 
for a full in-depth tutorial.
