---
layout: tour
title: Tour of Ceylon&#58; Anonymous and Member Classes
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# #{page.title}

This is the fourth leg of the Tour of Ceylon. In the [previous leg](../inheritance)
you learned about inheritance and refinement. In this leg you're going to learn 
about *anonymous classes* and *member classes*.

## Anonymous classes

If a class has no parameters, it's often possible to use a shortcut 
declaration which defines a named instance of the class, without providing 
any actual name for the class itself. This is usually most useful when we're 
extending an `abstract` class or implementing an interface.

<!-- implicit-id:polar: 
    doc "A polar coordinate"
    class Polar(Float angle, Float radius) {
 
        shared Polar rotate(Float rotation) {
            return Polar(angle+rotation, radius);
        }
     
        shared Polar dilate(Float dilation) {
            return Polar(angle, radius*dilation);
        }
        
        doc "The default description"
        shared default String description = "(" radius "," angle ")";
    
    }
-->

<!-- cat-id:polar -->
    doc "The origin"
    object origin extends Polar(0.0, 0.0) {
        shared actual String description = "origin";
    }

An anonymous class may extend an ordinary class and satisfy interfaces.

<!-- no-check -->
    shared object consoleWriter satisfies Writer {
                 
        formatter = StringFormatter();
         
        shared actual void write(String string) {
            process.write(string);
        }
         
    }

The downside to an `object` declaration is that we can't write code that 
refers to the concrete type of `defaultHello` or `consoleWriter`, only to the 
named instances.

You might be tempted to think of object declarations as defining singletons, 
but that's not quite right:

* A toplevel object declaration does indeed define a singleton.
* An object declaration nested inside a class defines an object per instance 
  of the containing class.
* An object declaration nested inside a method, getter, or setter results in 
  an new object each time the method, getter, or setter is executed.

Let's see how this can be useful:

<!-- no-check -->
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

Notice how this code example makes clever use of the fact that the nested 
`object` declaration receives a closure of the locals defined in the containing 
method declaration!

A different way to think about the difference between `object` and `class` is 
to think of a `class` as a parametrized `object`. (Of course, there's one 
big difference: a `class` declaration defines a named type that we can refer 
to in other parts of the program.) We'll see later that Ceylon also lets us 
think of a method as a parametrized attribute.

An `object` declaration can refine an attribute declared `formal` or `default`,
as long as it is a subtype of the declared type of the attribute.

<!-- no-check -->
    shared abstract class App() {
        shared formal OutputStream stream;
        ...
    }

    class ConsoleApp() extends App() {
        shared actual object stream
                satisfies OutputStream { ... }
        ...
    }

However, an `object` may not itself be declared `formal` or `default`.


## Member classes and member class refinement

You're probably used to the idea of an "inner" class in Java — a class 
declaration nested inside another class or method. Since Ceylon is a 
language with a recursive block structure, the idea of a nested class is 
more than natural. But in Ceylon, a non-abstract nested class is actually 
considered a member of the containing type. For example, `BufferedReader` 
defines the member class `Buffer`:

<!-- no-check -->
    class BufferedReader(Reader reader)
            satisfies Reader {
        shared default class Buffer()
                satisfies List<Character> { ... }
        ...
        
    }

The member class `Buffer` is annotated shared, so we can instantiate it like 
this:

<!-- no-check -->
    BufferedReader br = BufferedReader(reader);
    BufferedReader.Buffer b = br.Buffer();

Note that a nested type name must be qualified by the containing type name 
when used outside of the containing type.

The member class `Buffer` is also annotated `default`, so we can refine it 
in a subtype of `BufferedReader`:

<!-- no-check -->
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

<!-- no-check -->
    abstract class BufferedReader(Reader reader)
            satisfies Reader {
        shared formal class Buffer() {
            shared formal Byte read();
        }
        
        ...
        
    }

In this case, a concrete subclass of the `abstract` class must refine the 
`formal` member class.

<!-- no-check -->
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


