---
layout: tour
title: Tour of Ceylon&#58; Inheritance and Refinement (Overloading)
tab: documentation
author: Emmanuel Bernard
---

# #{page.title}

## Inheritance and refinement

In object-oriented programming, we often replace conditionals 
(`if`, and especially `switch`) with subtyping. Indeed, according to some 
folks, this is what makes a program object-oriented. Let's try refactoring the 
`Hello` class from Part 2 into two classes, with two different implementations 
of greeting:

<pre class="brush: ceylon">
    doc "A default greeting"
    class DefaultHello() {
     
        doc "The greeting"
        shared default String greeting = "Hello, World!";
         
        doc "Print the greeting"
        shared void say(OutputStream stream) {
            stream.writeLine(greeting);
        }
         
    }
</pre>

Notice that Ceylon forces us to declare attributes or methods that can be 
refined (overridden) by annotating them `default`.

Subclasses specify their superclass using the `extends` keyword, followed by 
the name of the superclass, followed by a list of arguments to be sent to 
the superclass initializer parameters. It looks just like an expression that 
instantiates the superclass:

<pre class="brush: ceylon">
    doc "A personalized greeting"
    class PersonalizedHello(String name)
            extends DefaultHello() {
         
        doc "The personalized greeting"
        shared actual String greeting {
            return "Hello, " name "!";
        }
     
    }
</pre>

Ceylon also forces us to declare that an attribute or method refines 
(overrides) an attribute or method of a superclass by annotating it `actual`. 
All this annotating stuff costs a few extra keystrokes, but it helps the 
compiler detect errors. We can't inadvertently refine a member or the 
superclass, or inadvertently fail to refine it.

Notice that Ceylon goes out of its way to repudiate the idea of "duck" typing 
or structural typing. If it `walks()` like a `Duck`, then it should be a 
subtype of `Duck` and must explicitly refine the definition of `walk()` 
in `Duck`. We don't believe that the name of a method or attribute alone is 
sufficient to identify its semantics.

## Abstract classes

There's one problem with what we've just seen. A personalized greeting is 
not really a kind of default greeting. This is a case for introducing an 
abstract superclass:

<pre class="brush: ceylon">
    doc "A greeting"
    abstract class Hello() {
         
        doc "The (abstract) greeting"
        shared formal String greeting;
         
        doc "Print the greeting"
        shared void say(OutputStream stream) {
            stream.writeLine(greeting);
        }
         
    }
</pre>

Ceylon requires us to annotate abstract classes `abstract`, just like Java. 
This annotation specifies that a class cannot be instantiated, and can define 
abstract members. Like Java, Ceylon also requires us to annotate "abstract" 
members that don't specify an implementation. However, in this case, the 
required annotation is `formal`. The reason for having two different 
annotations, as we'll see later, is that nested classes may be either 
`abstract` or `formal`, and `abstract` nested classes are slightly different 
to `formal` member classes — a `formal` member class may be instantiated; 
an abstract class may not be.

Note that an attribute that is never initialized is always a `formal` 
attribute — Ceylon doesn't initialize attributes to zero or `null` unless you 
explicitly tell it to!

One way to define an implementation for an inherited abstract attribute is to 
simply assign a value to it in the subclass.

<pre class="brush: ceylon">
    doc "A default greeting"
    class DefaultHello() extends Hello() {
        greeting = "Hello, World!";
    }
</pre>

Of course, we can also define an implementation for an inherited abstract 
attribute by refining it.

<pre class="brush: ceylon">
    doc "A personalized greeting"
    class PersonalizedHello(String name)
            extends Hello() {
         
        doc "The personalized greeting"
        shared actual String greeting {
            return "Hello, " name "!";
        }
         
    }
</pre>

Note that there's no way to prevent a other code from extending a class in 
Ceylon. Since only members explicitly declared as supporting refinement using 
either `formal` or `default` can be refined, a subtype can never break the
implementation of a supertype. Unless the supertype was explicitly designed 
to be extended, a subtype can add members, but never change the behavior of
inherited members.

## Interfaces and "mixin" inheritance

From time to time we come across a case where a class needs to inherit
functionality from more than one supertype. Java's inheritance model doesn't 
support this, since an interface can never define a member with a concrete 
implementation. Interfaces in Ceylon are a little more flexible:

* An interface may define concrete methods, attribute getters, and attribute setters.
* It may not define simple attributes or initialization logic.

Notice that prohibiting simple attributes and initialization logic makes 
interfaces completely stateless. An interface can't hold references to other 
objects.

Let's take advantage of mixin inheritance to define a reusable `Writer` 
interface for Ceylon.

<pre class="brush: ceylon">
    shared interface Writer {
     
        shared formal Formatter formatter;
         
        shared formal void write(String string);
         
        shared void writeLine(String string) {
            write(string);
            write(process.newLine);
        }
         
        shared void writeFormattedLine(String formatString, Object... args) {
            writeLine( formatter.format(formatString, args) );
        }
         
    }
</pre>

Note that we can't define a concrete value for the `formatter` attribute, 
since an interface may not define a simple attribute, and may not hold a 
reference to another object.

Note also that the call to `writeLine()` from `writeFormattedLine()` resolves 
to the instance method of `Writer`, which hides the toplevel method of the 
same name.

Now let's define a concrete implementation of this interface.

<pre class="brush: ceylon">
    shared class ConsoleWriter()
            satisfies Writer {
         
        formatter = StringFormatter();
         
        shared actual void write(String string) {
            writeLine(string);
        }
         
    }
</pre>

The `satisfies` keyword is used to specify that an interface extends 
another interface or that a class implements an interface. Unlike an `extends` 
declaration, a `satisfies` declaration does not specify arguments, since 
interfaces do not have parameters or initialization logic. Furthermore, the 
`satisfies` declaration can specify more than one interface.

Ceylon's approach to interfaces eliminates a common pattern in Java 
where a separate abstract class defines a default implementation of some 
of the members of an interface. In Ceylon, the default implementations can 
be specified by the interface itself. Even better, it's possible to add a 
new member to an interface without breaking existing implementations of the 
interface.


## Ambiguities in mixin inheritance

It's illegal for a type to inherit two members with the same name, unless the 
two members both (directly or indirectly) refine a common member of a common 
supertype, and the inheriting type itself also refines the member to eliminate 
any ambiguity. The following results in a compilation error:

<pre class="brush: ceylon">
    interface Party {
        shared formal String legalName;
        shared default String name {
            return legalName;
        }
    }
     
    interface User {
        shared formal String userId;
        shared default String name {
            return userId;
        }
    }
     
    class Customer(String name, String email)
            satisfies User & Party {
        legalName = name;
        userId = email;
        shared actual String name = name;    //error: refines two different members
    }
</pre>

To fix this code, we'll factor out a `formal` declaration of the attribute 
`name` to a common supertype. The following is legal:

<pre class="brush: ceylon">
    interface Named {
        shared formal String name;
    }
     
    interface Party satisfies Named {
        shared formal String legalName;
        shared actual default String name {
            return legalName;
        }
    }
     
    interface User satisfies Named {
        shared formal String userId;
        shared actual default String name {
            return userId;
        }
    }
     
    class Customer(String name, String email)
            satisfies User & Party {
        legalName = name;
        userId = email;
        shared actual String name = name;
    }
</pre>

Oh, of course, the following is illegal:

<pre class="brush: ceylon">
    interface Named {
        shared formal String name;
    }
     
    interface Party satisfies Named {
        shared formal String legalName;
        shared actual String name {
            return legalName;
        }
    }
     
    interface User satisfies Named {
        shared formal String userId;
        shared actual String name {
            return userId;
        }
    }
     
    class Customer(String name, String email)
            satisfies User & Party {    //error: inherits multiple definitions of name
        legalName = name;
        userId = email;
    }
</pre>

To fix this code, `name` must be declared `default` in both `User` and `Party` 
and explicitly refined in `Customer`.


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

<pre class="brush: ceylon">
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
</pre>

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

<pre class="brush: ceylon">
    import ceylon.collection { List, SequenceList }
     
    ...
     
    //define a Sequence
    Sequence<String> names = { "Gavin", "Emmanuel", "Andrew", "Ales" };
     
    //call an operation of List on Sequence
    List<String> sortedNames = names.sortedElements();
</pre>

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

<pre class="brush: ceylon">
    shared interface StringSequenceExtensions
            adapts Sequence<String> {
         
        shared String concatenated {
            variable String concat = "";
            for (String s in this) {
                concat+=s;
            }
            return concat;
        }
         
        shared String join(String separator=", ") {
            ...
        }
         
    }
</pre>

On the other hand, introductions are less powerful than implicit type 
conversions. This is by design! In this case, "less powerful" means 
"safer, more disciplined". The power of implicit type conversions comes partly 
from their ability to work around some of the designed-in limitations of the 
type system. But these limitations have a purpose! I'm especially thinking 
of the prohibitions against:

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

<pre class="brush: ceylon">
    interface People = Set<Person>;
</pre>

A class alias must declare its formal parameters:

<pre class="brush: ceylon">
    shared class People(Person... people) = ArrayList<Person>;
</pre>


## Member classes and member class refinement

You're probably used to the idea of an "inner" class in Java — a class 
declaration nested inside another class or method. Since Ceylon is a 
language with a recursive block structure, the idea of a nested class is 
more than natural. But in Ceylon, a non-abstract nested class is actually 
considered a member of the containing type. For example, `BufferedReader` 
defines the member class `Buffer`:

<pre class="brush: ceylon">
    class BufferedReader(Reader reader)
            satisfies Reader {
        shared default class Buffer()
                satisfies List<Character> { ... }
        ...
        
    }
</pre>

The member class `Buffer` is annotated shared, so we can instantiate it like 
this:

<pre class="brush: ceylon">
    BufferedReader br = BufferedReader(reader);
    BufferedReader.Buffer b = br.Buffer();
</pre>

Note that a nested type name must be qualified by the containing type name 
when used outside of the containing type.

The member class `Buffer` is also annotated `default`, so we can refine it 
in a subtype of `BufferedReader`:

<pre class="brush: ceylon">
    shared class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                extends super.Buffer() { ... }
                
    }
</pre>

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

<pre class="brush: ceylon">
    abstract class BufferedReader(Reader reader)
            satisfies Reader {
        shared formal class Buffer() {
            shared formal Byte read();
        }
        
        ...
        
    }
</pre>

In this case, a concrete subclass of the `abstract` class must refine the 
`formal` member class.

<pre class="brush: ceylon">
    shared class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                 extends super.Buffer() {
             shared actual Byte read() {
                 ...
             }
        }
    }
</pre>

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


## Anonymous classes

If a class has no parameters, it's often possible to use a shortcut 
declaration which defines a named instance of the class, without providing 
any actual name for the class itself. This is usually most useful when we're 
extending an `abstract` class or implementing an interface.

<pre class="brush: ceylon">
    doc "A default greeting"
    object defaultHello extends Hello() {
        greeting = "Hello, World!";
    }
    shared object consoleWriter satisfies Writer {
                 
        formatter = StringFormatter();
         
        shared actual void write(String string) {
            writeLine(string);
        }
         
    }
</pre>

The downside to an `object` declaration is that we can't write code that 
refers to the concrete type of `defaultHello` or `consoleWriter`, only to the 
named instances.

You might be tempted to think of object declarations as defining singletons, 
but that's not quite right:

* A toplevel object declaration does define a singleton.
* An object declaration nested inside a class defines an object per instance 
  of the containing class.
* An object declaration nested inside a method, getter, or setter results in 
  an new object each time the method, getter, or setter is executed.

Let's see how this can be useful:

<pre class="brush: ceylon">
    interface Subscription {
        shared formal void cancel();
    }
    shared Subscription register(Subscriber s) {
        subscribers.append(s);
        object subscription satisfies Subscription {
            shared actual void cancel() {
                subscribers.remove(s);
            }
        }
        return subscription;
    }
</pre>

Notice how this code example makes clever use of the fact that the nested 
`object` declaration receives a closure of the locals defined in the containing 
method declaration!

A different way to think about the difference between `object` and `class` is 
to think of a `class` as a parametrized `object`. (Of course, there's one 
big difference: a `class` declaration defines a named type that we can refer 
to in other parts of the program.) We'll see later that Ceylon also lets us 
think of a method as a parametrized attribute.

An `object` declaration can refine an attribute declared `formal` or `default`.

<pre class="brush: ceylon">
    shared abstract class App() {
        shared formal OutputStream stream;
        ...
    }
    class ConsoleApp() extends App() {
        shared actual object stream
                satisfies OutputStream { ... }
        ...
    }
</pre>

However, an `object` may not itself be declared `formal` or `default`.


## There's more...

Member classes and member class refinement allows Ceylon to support type families.

If you're interested, XXX some crazy ideas about how to generalize the 
notion of refinement to toplevel declarations.

Next, we're going to meet [sequences](../sequences), Ceylon's take on the 
"array" type.

 
