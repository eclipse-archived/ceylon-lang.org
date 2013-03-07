---
layout: tour
title: Tour of Ceylon&#58; Inheritance, Refinement, and Interfaces
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# #{page.title}

This is the fourth leg of the Tour of Ceylon. In the 
[previous part](../attributes-control-structures) we looked at attributes, 
variables, setters, and control structures. In this section we're going to 
learn about *inheritance* and *refinement* (known as "overriding" in many 
other languages).

Inheritance is one of two ways Ceylon lets us abstract over types. (The
other is [generics](../generics), which we'll get to later in this tour.)
Ceylon features a flavor of multiple inheritance called 
["mixin" inheritance](interfaces_and_mixin_inheritance). You might have
heard or experienced that multiple inheritance is scary and complicated
and, indeed, that's kinda true of multiple inheritance in C++. But mixin
inheritance in Ceylon comes with certain restrictions that strike a
good balance between power and harmlessness. 

## Inheritance and refinement

In object-oriented programming, we often replace conditionals (`if`, and 
especially `switch`) with subtyping. Indeed, according to some folks, this 
is what makes a program object-oriented. Let's try refactoring the `Polar` 
class [from the previous leg of the tour](../classes) into two classes, 
with two different implementations of `description`. Here's the superclass:

<!-- try-post:
    print(Polar(0.31, 13.0).description);
-->
<!-- id:polar -->
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

Notice that Ceylon forces us to declare attributes or methods that can 
be refined (overridden) by annotating them `default`.

Subclasses specify their superclass using the `extends` keyword
([here's why](#{page.doc_root}/faq/language-design/#colon_vs_extends_for_inheritance)), 
followed by the name of the superclass, followed by a list of arguments 
to be sent to the superclass initializer parameters. It looks just like 
an expression that instantiates the superclass:

<!-- try-pre:
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
<!-- try-post:
    print(LabeledPolar(0.31, 13.0, "point").description);
-->
<!-- cat-id:polar -->
    "A polar coordinate with a label"
    class LabeledPolar(Float angle, Float radius, String label)
            extends Polar(angle, radius) {
        
        "The labeled description"
        shared actual String description =>
                label + "-" + super.description;
        
    }

Ceylon also forces us to declare that an attribute or method refines 
(overrides) an attribute or method of a superclass by annotating it `actual`
([not "overrides" like Java](#{page.doc_root}/faq/language-design/#_overrides_vs_actual)). 
All this annotating stuff costs a few extra keystrokes, but it helps the 
compiler detect errors. We can't inadvertently refine a member or the 
superclass, or inadvertently fail to refine it.

Notice that Ceylon goes out of its way to repudiate the idea of "duck" 
typing or structural typing. If it `walks()` like a `Duck`, then it should 
be a subtype of `Duck` and must explicitly refine the definition of `walk()` 
in `Duck`. We don't believe that the name of a method or attribute alone is 
sufficient to identify its semantics. And, more importantly, [structural
typing doesn't work properly with tools](#{page.doc_root}/faq/language-design/#structural_typing).

## Shortcut syntax for refinement

There's a more compact way to refine a `default` member of a superclass: 
simply specify its refined implementation using `=>`, like this:

<!-- try-pre:
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
<!-- try-post:
    print(LabeledPolar(0.31, 13.0, "point").description);
-->
<!-- cat-id:polar -->
    "A polar coordinate with a label"
    class LabeledPolar(Float angle, Float radius, String label)
            extends Polar(angle, radius) {
        
        description => label + "-" + super.description;
        
    }

Or assign a value to it using `=`, like this:

<!-- try-pre:
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
<!-- try-post:
    print(LabeledPolar(0.31, 13.0, "point").description);
-->
<!-- cat-id:polar -->
    "A polar coordinate with a label"
    class LabeledPolar(Float angle, Float radius, String label)
            extends Polar(angle, radius) {
        
        description = label + "-" + super.description;
        
    }

You can refine any function or non-`variable` value using this streamlined
syntax.

## Refining a member of `Object`

Our `Polar` class is an implicit subtype of the class 
[`Object`](#{site.urls.apidoc_current}/ceylon/language/class_Object.html)
in the package `ceylon.language`. If you take a look at this class, you'll 
see that it has a `default` attribute named 
[`string`](#{site.urls.apidoc_current}/ceylon/language/class_Object.html#string). 
It's common to refine this attribute to provide a developer-friendly 
representation of the object.

`Polar` is also a subtype of the interface 
[`Identifiable`](#{site.urls.apidoc_current}/ceylon/language/interface_Identifiable.html) 
which defines `default` implementations of 
[`equals()`](#{site.urls.apidoc_current}/ceylon/language/interface_Identifiable.html#equals) 
and [`hash`](#{site.urls.apidoc_current}/ceylon/language/interface_Identifiable.html#hash).
We should _definitely_ refine those:

<!-- try-pre:
    Float pi = 3.1415926535;
-->
<!-- try-post:
    print(Polar(0.31, 13.0));
-->
<!-- cat: Float pi = 3.1415926535; -->
    "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        // ...

        shared default String description => 
                "(``radius``,``angle``)";
        
        value azimuth => pi*(angle/pi).fractionalPart;
        
        shared actual Boolean equals(Object that) {
            if (is Polar that) {
                return azimuth==that.azimuth && 
                       radius==that.radius; 
            }
            else {
                return false;
            }
        }
        
        shared actual Integer hash => radius.hash;
        
        shared actual String string => description;
        
    }

Don't worry if the syntax `if (is Polar that)` throws you. We'll come back 
to this construct this later in the tour.

Or, using the shortcut syntax for refinement that we just met, we could
write it like this:


<!-- try-pre:
    Float pi = 3.1415926535;
-->
<!-- try-post:
    print(Polar(0.31, 13.0));
-->
<!-- cat: Float pi = 3.1415926535; -->
    "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        // ...

        shared default String description => 
                "(``radius``,``angle``)";
        
        value azimuth => pi*(angle/pi).fractionalPart;
        
        shared actual Boolean equals(Object that) {
            if (is Polar that) {
                return azimuth==that.azimuth && 
                       radius==that.radius; 
            }
            else {
                return false;
            }
        }
        
        hash => radius.hash;
        
        string => description;
        
    }

(In this case, the shortcut syntax is perhaps _not_ an improvement.)

## Abstract classes

Now let's consider a much more interesting problem: abstracting over the 
polar and cartesian coordinate systems. Since a cartesian coordinate isn't 
just a special kind of polar coordinate, this is a case for introduction of 
an abstract superclass:

<!-- try: -->
<!-- cat-id:polar -->
<!-- cat: class Cartesian(Float x, Float y) {} -->
    "A coordinate-system free abstraction of a 
     geometric point"
    abstract class Point() {
         
         shared formal Polar polar;
         shared formal Cartesian cartesian;
         
         shared formal Point rotate(Float rotation);
         shared formal Point dilate(Float dilation);
         
    }

Ceylon requires us to annotate abstract classes `abstract`, just like Java. 
This annotation specifies that a class cannot be instantiated, and can define 
abstract members. Like Java, Ceylon also requires us to annotate "abstract" 
members that don't specify an implementation. However, in this case, the 
required annotation is `formal`. The reason for having two different 
annotations, as we'll see 
[later](../anonymous-member-classes#member_classes_and_member_class_refinement), 
is that nested classes may be either `abstract` or `formal`, and `abstract` 
nested classes are a bit different to `formal` member classes. A `formal` 
member class may be instantiated; an abstract class may not be.

Note that an attribute that is never initialized is always a `formal` 
attribute. Ceylon doesn't initialize attributes to zero or `null` unless 
you explicitly tell it to!

One way to define an implementation for an inherited abstract attribute is 
to use the shortcut refinement syntax we saw above.

<!-- try: -->
<!-- check:parse:Requires ceylon.math -->
    "A polar coordinate"
    class Polar(Float angle, Float radius) 
            extends Point() {
        
        polar => this;
        cartesian => Cartesian(radius*cos(angle), radius*sin(angle));
        
        rotate(Float rotation) => Polar(angle+rotation, radius);
        dilate(Float dilation) => Polar(angle, radius*dilation);
        
    }

Alternatively, we can write it all out the long way.

<!-- try: -->
<!-- check:parse:Requires ceylon.math -->
    import ceylon.math.float { sin, cos }
     
    "A polar coordinate"
    class Polar(Float angle, Float radius) 
            extends Point() {
        
        shared actual Polar polar => this;
        
        shared actual Cartesian cartesian =>
                Cartesian(radius*cos(angle), radius*sin(angle));
        
        shared actual Polar rotate(Float rotation) =>
                Polar(angle+rotation, radius);
        
        shared actual Polar dilate(Float dilation) =>
                Polar(angle, radius*dilation);
           
    }

Notice that Ceylon, like Java, allows _covariant refinement_ of member types.
We were able to refine the return type of `rotate()` and `dilate()`, narrowing 
to `Polar` from the more general type declared by `Point`. But Ceylon doesn't 
currently support _contravariant refinement_ of parameter types. You can't 
refine a method and widen a parameter type. (Someday we would love to fix this.)

Of course, you can't refine a member and _widen_ the return type, or change
to some arbitrary different type, since in that case the subclass would no
longer be a subtype of the supertype. If you're going to refine the return
type, you have to refine to a subtype.

`Cartesian` also covariantly refines `rotate()` and `dilate()`, but to a 
different return type:

<!-- try: -->
<!-- check:parse:Requires ceylon.math -->
    import ceylon.math.float { atan } 
    
    "A cartesian coordinate"
    class Cartesian(Float x, Float y) 
            extends Point() {
        
        shared actual Polar polar => 
                Polar( (x**2+y**2)**0.5, atan(y/x) ); 
        
        shared actual Cartesian cartesian => return this;
        
        shared actual Cartesian rotate(Float rotation) =>
                polar.rotate(rotation).cartesian;
        
        shared actual Cartesian dilate(Float dilation) =>
                Cartesian(x*dilation, y*dilation);
        
    }

There's no way to prevent other code from extending a class (there's 
no equivalent of a `final` class in Java). Since only members explicitly 
declared as supporting refinement using either `formal` or `default` can be 
refined, a subtype can never break the implementation of a supertype. Unless 
the supertype was explicitly designed to be extended, a subtype can add 
members, but never change the behavior of inherited members.

Abstract classes are useful. But since interfaces in Ceylon are more 
powerful than interfaces in Java, it often makes more sense to use an 
interface instead of an abstract class.


## Interfaces and "mixin" inheritance

From time to time we come across a case where a class needs to inherit
functionality from more than one supertype. Java's inheritance model doesn't 
support this, since an interface can never define a member with a concrete 
implementation. Interfaces in Ceylon are a little more flexible:

* An interface may define concrete methods, attribute getters, and attribute 
  setters, but
* it may not define simple attributes or initialization logic.

Notice that prohibiting simple attributes and initialization logic makes 
interfaces completely stateless. An interface can't hold references to other 
objects.

Let's take advantage of mixin inheritance to define a reusable `Writer` 
interface for Ceylon.

<!-- try-pre:
    interface Formatter { 
        shared formal String format(String format, Object... args);
    }
-->
<!-- check:none:concrete members of interfaces not yet supported -->
<!-- id:writer -->
<!-- cat: 
    interface Formatter { 
        shared formal String format(String format, Object* args);
    } -->
    interface Writer {
     
        shared formal Formatter formatter;
         
        shared formal void write(String string);
         
        shared void writeLine(String string) {
            write(string);
            write("\n");
        }
         
        shared void writeFormattedLine(String format, Object* args) {
            writeLine( formatter.format(format, args) );
        }
         
    }

Note that we can't define a concrete value for the `formatter` attribute, 
since an interface may not define a simple attribute, and may not hold a 
reference to another object.

Now let's define a concrete implementation of this interface.

<!-- try-pre:
    interface Formatter { 
        shared formal String format(String format, Object* args);
    }
    interface Writer {
        shared formal Formatter formatter;
        shared formal void write(String string);
        shared void writeLine(String string) {
            write(string);
            write("\n");
        }
        shared void writeFormattedLine(String format, Object* args) {
            writeLine( formatter.format(format, args) );
        }
    }
    class StringFormatter() satisfies Formatter {
        shared actual String format(String format, Object* args) {
            return format; // Fake implementation
        }
    }
-->
<!-- try-post:
    value w = ConsoleWriter();
    w.write("Hello, world!");
-->
<!-- check:none:depends on above:concrete members of interfaces not yet supported -->
<!-- cat-id: writer -->
    class ConsoleWriter() satisfies Writer {
        
        formatter = StringFormatter();
        
        write(String string) => print(string);
        
    }

The `satisfies` keyword 
([not `implements` like Java](#{page.doc_root}/faq/language-design/#_implements_vs_satisfies))
is used to specify that an interface extends 
another interface or that a class implements an interface. 
Unlike an `extends` declaration, a `satisfies` declaration does not specify 
arguments, since interfaces do not have parameters or initialization logic. 
Furthermore, the `satisfies` declaration can specify more than one interface.

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

<!-- check:none:demos error -->
    interface Party {
        shared formal String legalName;
        shared default String name => legalName;
    }
    
    interface User {
        shared formal String userId;
        shared default String name => userId;
    }
    
    class Customer(String customerName, String email)
            satisfies User & Party {
        shared actual String legalName = customerName;
        shared actual String userId = email;
        shared actual String name = customerName;    //error: refines two different members
    }

To fix this code, we'll factor out a `formal` declaration of the attribute 
`name` to a common supertype. The following is legal:

<!-- try-post:
    value c = Customer("Pietje Pluk", "piet.pluk@petteflet.example.org");
    print(c.name);
-->
<!-- check:none:concrete members of interfaces not yet supported -->
    interface Named {
        shared formal String name;
    }
    
    interface Party satisfies Named {
        shared formal String legalName;
        shared actual default String name => legalName;
    }
    
    interface User satisfies Named {
        shared formal String userId;
        shared actual default String name => userId;
    }
    
    class Customer(String customerName, String email)
            satisfies User & Party {
        shared actual String legalName = customerName;
        shared actual String userId = email;
        shared actual String name = customerName;
    }

Oh, of course, the following is illegal:

<!-- check:none:demos error -->
    interface Named {
        shared formal String name;
    }
    
    interface Party satisfies Named {
        shared formal String legalName;
        shared actual String name => legalName;
    }
    
    interface User satisfies Named {
        shared formal String userId;
        shared actual String name => userId;
    }
    
    class Customer(String customerName, String email)
            satisfies User & Party {    //error: inherits multiple definitions of name
        shared actual String legalName = customerName;
        shared actual String userId = email;
    }

To fix this code, `name` must be declared `default` in both `User` and `Party` 
and explicitly refined in `Customer`.


## There's more...

Next, to finish off our discussion of object oriented programming
in Ceylon, we're going to learn about 
[anonymous classes and member classes](../anonymous-member-classes).

 
