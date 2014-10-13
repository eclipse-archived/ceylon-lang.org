---
layout: tour11
title: Anonymous and member classes
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# #{page.title}

This is the fifth stop in our Tour of Ceylon. In the 
[previous leg](../inheritance) we learned about inheritance and refinement.
It's time to round out our introduction to object-oriented programming in 
Ceylon by learning about *anonymous classes* and *member classes*.

## Anonymous classes

If a class has no parameters, it's often possible to use a shortcut 
declaration which defines a named instance of the class, without providing 
any actual name for the class itself. This is usually most useful when we're 
extending an `abstract` class or implementing an interface.

<!-- implicit-id:polar: 
    "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        shared Polar rotate(Float rotation) =>
                Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) =>
                Polar(angle, radius*dilation);
        
        "The default description"
        shared default String description => 
                "(``radius``,``angle``)";
        
    }
-->

<!-- try-pre:
    "A polar coordinate"
    class Polar(Float angle, Float radius) {
        "The default description"
        shared default String description => "(``radius``,``angle``)";
        shared actual String string => description;
    }
-->
<!-- try-post:
    print(origin);
-->
<!-- cat-id:polar -->
    "The origin"
    object origin extends Polar(0.0, 0.0) {
        description => "origin";
    }

An anonymous class may extend an ordinary class and satisfy interfaces.

<!-- try: -->
<!-- check:none:Requires IO -->
    shared object consoleWriter satisfies Writer {
        formatter = StringFormatter();
        write(String string) => process.write(string);
    }

The downside to an `object` declaration is that we can't write code that 
refers to the concrete type of `origin` or `consoleWriter`, only to the 
named instances. Thus, you occasionally see the following pattern in
Ceylon:

    abstract class Unit() of unit {
        //operations
    }
    object unit extends Unit() {}

If `Unit` and `unit` are toplevel declarations, then `Unit` is called a 
_unit type_, since it has exactly one instance.

You might be tempted to think of object declarations as defining singletons, 
but that's not quite right:

* A _toplevel_ object declaration does indeed define a singleton.
* An object declaration nested inside a class defines an object per instance 
  of the containing class.
* An object declaration nested inside a method, getter, or setter results in 
  a new object each time the method, getter, or setter is executed.

Let's see how this can be useful:

<!-- try-pre:
    interface Subscriber {}
    object subscribers {
        shared void append(Subscriber s) {}
        shared void remove(Subscriber s) {}
    }

-->
<!-- check:none:Requires Mutable List -->
    interface Subscription {
        shared formal void cancel();
    }

    Subscription register(Subscriber s) {
        subscribers.append(s);
        object subscription satisfies Subscription {
            shared actual void cancel() =>
                subscribers.remove(s);
        }
        return subscription;
    }

Notice how this code example makes clever use of the fact that the nested 
`object` declaration receives a closure of the locals defined in the containing
method declaration!

A different way to think about the difference between `object` and `class` is 
to think of a `class` as a parameterized `object`. (Of course, there's one big 
difference: a `class` declaration defines a named type that we can refer to in 
other parts of the program.) We'll see later that, analogously, Ceylon lets us 
think of a method as a parameterized attribute.

An `object` declaration can refine an attribute declared `formal` or `default`,
as long as it is a subtype of the declared type of the attribute.

<!-- try: -->
    shared abstract class App() {
        shared formal OutputStream stream;  //formal attribute
        ...
    }

    class ConsoleApp() extends App() {
        shared actual object stream        //object refines the attribute
                satisfies OutputStream { ... }
        ...
    }

However, an `object` may not itself be declared `formal` or `default`.

## Member classes and member class refinement

You're probably used to the idea of an "inner" or _nested_ class in 
Java&mdash;a class declaration nested inside another class or method. Since 
Ceylon is a language with a recursive block structure, the idea of a nested 
class is more than natural. But in Ceylon, a non-`abstract` nested class is 
actually considered a polymorphic member of the containing type. 

Let's start with the following example: `BufferedReader` defines the member 
class `Buffer`.

<!-- try: -->
    class BufferedReader(Reader reader)
            satisfies Reader {
        shared default class Buffer()
                satisfies List<Character> { ... }
        ...
    }

The member class `Buffer` is annotated shared, so we can instantiate it like 
this:

<!-- try: -->
    BufferedReader br = BufferedReader(ExampleReader());
    BufferedReader.Buffer b = br.Buffer();

Note that a nested type name must be qualified by the containing type name 
when used outside of the containing type.

The member class `Buffer` is also annotated `default`, so we can refine it in 
a subtype of `BufferedReader`:

<!-- try: -->
    class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                extends super.Buffer() { ... }
        ...     
    }

That's right: Ceylon lets us "override" a member class defined by a supertype!

Note that `BufferedFileReader.Buffer` is a subclass of `BufferedReader.Buffer`.

Now the instantiation `br.Buffer()` above is a polymorphic operation! It might 
return an instance of `BufferedFileReader.Buffer` or an instance of 
`BufferedReader.Buffer`, depending upon whether `br` refers to a plain 
`BufferedReader` or to a `BufferedFileReader`. This is more than a cute trick. 
Polymorphic instantiation lets us eliminate the "factory method pattern" from 
our code.

Notice how, unlike in Java or C#, where polymorphism is only for _methods_, 
Ceylon features polymorphism for attributes, methods, and member classes.

## Formal member classes

It's even possible to define a `formal` member class of an `abstract` class. A 
`formal` member class can declare `formal` members.

<!-- try: -->
    abstract class BufferedReader(Reader reader)
            satisfies Reader {
        shared formal class Buffer() {
            shared formal Byte read();
        }
        ...
    }

In this case, a concrete subclass of the `abstract` class must refine the 
`formal` member class.

<!-- try: -->
    shared class BufferedFileReader(File file)
            extends BufferedReader(FileReader(file)) {
        shared actual class Buffer()
                 extends super.Buffer() {
             shared actual Byte read() {
                 ...
             }
        }
        ...
    }

Even though `abstract` classes and `formal` classes seem like quite similar 
concepts, there's a really big difference:

- An `abstract` nested class *may not* be instantiated, and *need not* be 
  refined by concrete subclasses of the containing class. 
- A `formal` member class *may* be instantiated, and *must* be refined by every 
  subclass of the containing class.

Note that this difference explains why Ceylon has a special-purpose annotation 
to distinguish a formal member. We can't use `abstract` to declare a formal
member, since that would be ambiguous in the case of a nested class. 

It's an interesting exercise to compare Ceylon's member class refinement with 
the functionality of Java dependency injection frameworks. Both mechanisms 
provide a means of abstracting the instantiation operation of a type. You can 
think of the subclass that refines a member type as filling the same role as a 
dependency configuration in a dependency injection framework.

## There's more...

Member classes and member class refinement allows Ceylon to support _type families_.
We're not going to discuss type families in this tour.

Next, we're going to meet [iterable objects](../sequences), along with sequences,
Ceylon's take on the "array" type, and tuples.


