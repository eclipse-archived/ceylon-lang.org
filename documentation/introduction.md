---
layout: documentation
title: Quick Introduction to Ceylon
tab: documentation
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
just like methods in other object-oriented languages. An attribute might 
be a simple value:

    String name = firstName + " " + lastName;

It might be a getter:

    String name {
        return firstName + " " + lastName;
    }

Or it might be a get/set pair:

    String name {
        return fullName;
    }
    
    assign name {
        fullName := name;
    }

## Typesafe null

There's no `NullPointerException` in Ceylon, nor anything similar. Ceylon
requires us to be explicit when we declare a value that might be null, or
a method that might return null. For example, if `name` might be null, 
we must declare it like this:

    String? name = ...

Which is actually just an abbreviation for:

    String|Nothing name = ...

An attribute of type `String` might refer to an actual instance of `String`, 
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

## Algebraic types

TODO

## Type aliases and type inference

TODO

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
