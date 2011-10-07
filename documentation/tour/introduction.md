---
layout: tour
title: Tour of Ceylon&#58; Introduction and Member Classes
tab: documentation
author: Emmanuel Bernard
---

# #{page.title}

This is the fourth leg of the Tour of Ceylon. In the [previous leg](../inheritance)
you learned about inheritance and refinement. In this leg you're going to learn about 
*introduction* and *member classes*.

## Introduction

Sometimes, especially when we're working with code from modules we don't have 
control over, we would like to mix an interface into a type that has already 
been defined in another module. For example, we might like to introduce the 
Ceylon collections module type `List` into the language module type `Sequence`, 
so that all `Sequences` support all operations of `List`. But the language 
module shouldn't have a dependency to the collections module, so we can't 
specify that interface `Sequence` satisfies `List` in the declaration of 
`Sequence` in the language module.

Instead, we can introduce the type `Sequence` in the code which uses the 
collections and language modules. The collections module already defines an 
interface called `SequenceList` for this purpose. Well, it doesn't yet, since 
we have not yet either implemented introductions or written the collections 
module, but it will soon!

    doc "Decorator that introduces List to Sequence."
    see (List,Sequence)
    shared interface SequenceList<Element>
            adapts Sequence<Element>
            satisfies List<Element> {
         
        shared actual default List<Element> sortedElements() {
            //define the operation of List in
            //terms of operations on Sequence
            return asList(sortSequence(this));
        }
         
        ...
         
    }

The `adapts` clause makes `SequenceList` a special kind of interface called an 
*adapter* (in the terminology used by this book). According to the language 
spec:

> The interface may not:
>
> * declare or inherit a member that refines a member of any adapted type, or
> * declare or inherit a formal or non-default actual member unless the member 
>   is inherited from an adapted type.

The purpose of an adapter is to add a new supertype, called an 
*introduced type*, to an existing type, called the *adapted type*. The adapter 
doesn't change the original definition of the adapted type, and it doesn't 
affect the internal workings of an instance of the adapted type in any way. 
All it does is "fill in" the definitions of the missing operations. Here, the 
`SequenceList` interface provides concrete implementations of all methods of 
`List` that are not already implemented by `Sequence`.

Now, to introduce `List` to `Sequence` in a certain compilation unit, all we 
need to do is `import` the adapter:

    import ceylon.collection { List, SequenceList }
     
    ...
     
    //define a Sequence
    Sequence<String> names = { "Gavin", "Emmanuel", "Andrew", "Ales" };
     
    //call an operation of List on Sequence
    List<String> sortedNames = names.sortedElements();

Note that the introduction is not visible outside the lexical scope of the 
`import` statement (the compilation unit). But within the compilation unit 
containing the `import` statement, every instance of of the adapted type 
`Sequence` now has all the attributes and methods of the introduced type 
`List`, and is assignable to the introduced type.

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
            variable String concat = "";
            for (s in this) {
                concat+=s;
            }
            return concat;
        }
         
        shared String join(String separator=", ") {
            ...
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


## Type aliases

It's often useful to provide a shorter or more semantic name to an existing 
class or interface type, especially if the class or interface is a 
parameterized type. For this, we use a *type alias*, for example:

    interface People = Set<Person>;

A class alias must declare its formal parameters:

    shared class People(Person... people) = ArrayList<Person>;


## Member classes and member class refinement

You're probably used to the idea of an "inner" class in Java — a class 
declaration nested inside another class or method. Since Ceylon is a 
language with a recursive block structure, the idea of a nested class is 
more than natural. But in Ceylon, a non-abstract nested class is actually 
considered a member of the containing type. For example, `BufferedReader` 
defines the member class `Buffer`:

    class BufferedReader(Reader reader)
            satisfies Reader {
        shared default class Buffer()
                satisfies List<Character> { ... }
        ...
        
    }

The member class `Buffer` is annotated shared, so we can instantiate it like 
this:

    BufferedReader br = BufferedReader(reader);
    BufferedReader.Buffer b = br.Buffer();

Note that a nested type name must be qualified by the containing type name 
when used outside of the containing type.

The member class `Buffer` is also annotated `default`, so we can refine it 
in a subtype of `BufferedReader`:

    shared class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                extends super.Buffer() { ... }
                
    }

That's right: Ceylon lets us "override" a member class defined by a supertype!

Note that `BufferedFileReader.Buffer` is a subclass of `BufferedReader.Buffer`.

Now the instantiation `br.Buffer()` above is a polymorphic operation! It might 
return an instance of `BufferedFileReader.Buffer` or an instance of 
`BufferedReader.Buffer`, depending upon whether `br` refers to a plain 
`BufferedReader` or a `BufferedFileReader`. This is more than a cute trick. 
Polymorphic instantiation lets us eliminate the "factory method pattern" from 
our code.

It's even possible to define a `formal` member class of an `abstract` class. 
A `formal` member class can declare `formal` members.

    abstract class BufferedReader(Reader reader)
            satisfies Reader {
        shared formal class Buffer() {
            shared formal Byte read();
        }
        
        ...
        
    }

In this case, a concrete subclass of the `abstract` class must refine the 
`formal` member class.

    shared class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                 extends super.Buffer() {
             shared actual Byte read() {
                 ...
             }
        }
    }

Notice the difference between an `abstract` class and a `formal` member class. 
An `abstract` nested class *may not* be instantiated, and *need not* be refined 
by concrete subclasses of the containing class. A `formal` member class *may* 
be instantiated, and *must* be refined by every subclass of the containing 
class.

It's an interesting exercise to compare Ceylon's member class refinement 
with the functionality of Java dependency injection frameworks. Both 
mechanisms provide a means of abstracting the instantiation operation of a 
type. You can think of the subclass that refines a member type as filling 
the same role as a dependency configuration in a dependency injection 
framework.


## There's more...

Member classes and member class refinement allows Ceylon to support type families.

Next, we're going to meet [sequences](../sequences), Ceylon's take on the 
"array" type.

 
