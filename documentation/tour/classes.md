---
layout: tour
title: Tour of Ceylon&#58; Classes, Interfaces and Objects
tab: documentation
author: Emmanuel Bernard
---

# #{page.title}

This is the second step in our tour of the Ceylon language.
In the [previous leg](../basics)
you learned some of the basics of Ceylon programming. In this leg we're 
going to look in more detail at classes.

## Creating your own classes

Type (interface, class, and type parameter) names are capitalized. 
Member (method and attribute) and local names are not. The Ceylon 
compiler is watching you. If you try to write `class hello` or 
`String Name`, you'll get a compilation error.

Our first class is going to represent points in a polar coordinate 
system. Our class has two parameters, two methods, and an attribute.

    doc "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        shared Polar rotate(Float rotation) {
            return Polar(angle+rotation, radius);
        }
        
        shared Polar dilate(Float dilation) {
            return Polar(angle, radius*dilation);
        }
        
        shared String description = "(" radius "," angle ")";
        
    }

There's two things in particular to notice here:

1. The parameters used to instantiate a class are specified as part of the 
   class declaration, right after the name of the class. There's no Java-style 
   constructors in Ceylon. This syntax is less verbose and more regular than 
   Java.
   
2. We make can use of the parameters of a class anywhere within the body of 
   the class. In Ceylon, we often don't need to define explicit members of the 
   class to hold the parameter values. Instead, we can access the parameters
   `angle` and `radius` directly from the `rotate()` and `dilate()` methods, 
   and from the expression which specifies the value of `description`.

Notice also that Ceylon doesn't have a `new` keyword to indicate instantiation.

The `shared` annotation determines the accessibility of the annotated type, 
attribute, or method. Before we go any further, let's see how we can hide the 
internal implementation of a class from other code.


## Hiding implementation details

Ceylon doesn't make a distinction between `public`, `protected` and "default" 
visibility like Java does; 
[here's why](/documentation/faq/language-design/#no_protected_keyword). Instead,
Ceylon distinguishes between: 

* program elements which are visible only inside the scope in which they are 
  defined, and 
* program elements which are visible wherever the thing they belong to (a type, 
  package, or module) is visible.

By default, members of a class are hidden from code outside the body of the 
class. By annotating a member with the `shared` annotation, we declare that 
the member is visible to any code to which the class itself is visible.

And, of course, a class itself may be hidden from other code. By default, 
a toplevel class is hidden from code outside the package in which the class is 
defined. Annotating a top level class with `shared` make it visible to any 
code to which the package containing the class is visible.

Finally, packages are hidden from code outside the module to which the 
package belongs by default. Only explicitly shared packages are visible to 
other modules.

Got the idea? We are playing russian dolls here.


## Exposing parameters as attributes

If we want to expose the `angle` and `radius` of our `Polar` coordinate to
other code, we need to define attributes of the class. It's very common to 
assign parameters of a class directly to a `shared` attribute of the class, 
so Ceylon lets us reuse the name of a parameter as the name of an attribute.

    doc "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        shared Float angle = angle;
        shared Float radius = radius;
        
        shared Polar rotate(Float rotation) {
            return Polar(angle+rotation, radius);
        }
        
        shared Polar dilate(Float dilation) {
            return Polar(angle, radius*dilation);
        }
        
        shared String description = "(" radius "," angle ")";
        
    }

Code that uses `Polar` can access the attributes of the class using a very
convenient syntax.

    shared Cartesian cartesian(Polar polar) {
        return Cartesian(polar.radius*polar.cos(angle), 
                         polar.radius*polar.sin(angle));
    }


## Initializing attributes

The attributes `angle` and `radius` are _simple attributes_, the closest thing 
Ceylon has to a Java field. Usually we specify the value of a simple attribute
as part of the declaration of the attribute.

    shared Float x = radius * sin(angle);
    shared String greeting = "Hello, " name "!";
    shared Natural months = years * 12;

On the other hand, it's sometimes useful to separate declaration from specification 
of a value.

    shared String description;
    if (exists label) {
        description = label;
    }
    else {
        description = "(" radius "," angle ")";
    }

But if there's no constructors in Ceylon, where precisely should we put this
code? We put it directly in the body of the class!

    doc "A polar coordinate with an optional label"
    class Polar(Float angle, Float radius, String? label) {
        
        shared Float angle = angle;
        shared Float radius = radius;
        
        shared String description;
        if (exists label) {
            description = label;
        }
        else {
            description = "(" radius "," angle ")";
        }
        
        ...
        
    }

The Ceylon compiler forces you to specify a value of any simple attribute or 
local before making use of the simple attribute or local in an expression.

    Natural count;
    shared void inc() {
        count++;   //compile error
    }


## Abstracting state using attributes

If you're used to writing JavaBeans, you can think of a simple attribute as a
combination of several things:

* a field,
* a getter, and, sometimes, 
* a setter. 

That's because not all attributes are simple value holders like the one we've 
just seen; others are more like a getter method, or, sometimes, like a getter 
and setter method pair.

We'll need to expose the equivalent cartesian coordinates of a `Polar`.
Since the cartesian coordinates can be computed from the polar coordinates,
we don't need to define state-holding simple attributes. Instead, we can
define the attributes as _getters_.

    doc "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        shared Float angle = angle;
        shared Float radius = radius;
        
        shared Float x { return radius * cos(angle); }
        shared Float y { return radius * sin(angle); }
        
        ...
        
    }

Notice that the syntax of a getter declaration looks a lot like a method 
declaration with no parameter list.

Code that uses `Polar` never needs to know if an attribute is a simple
attribute or a getter. Now that we know about getters, we could rewrite our 
`description` attribute as a getter, without affecting any code that uses it.

    shared String description {
        if (exists label) {
            return label;
        }
        else {
            return "(" radius "," angle ")";
        }
    }


## Living without overloading

It's time for some bad news: Ceylon doesn't support method or constructor 
overloading (the truth is that overloading is the source of various problems 
in Java, especially when generics come into play). However we can emulate most 
non-evil uses of constructor or method overloading using:

* defaulted parameters, 
* sequenced parameters, i.e. varargs, and
* union types or enumerated type constraints.

We're not going to get into all the details of these workarounds right now, 
but here's a quick example of each of the three techniques:

    //defaulted parameter
    void println(String line, String eol = "\n") {
        process.write(line + eol);
    }

    //sequenced parameter
    void printlns(String... lines) {
        for (string in strings) {
            println(string);
        }
    }

    //union type
    void printName(String|Named name) {
        switch (name)
        case (is String) {
            println(name);
        }
        case (is Named) {
            println(name.first + " " + name.last);
        }
    }

Don't worry if you don't completely understand the third example just yet. 

Let's make use of this idea to "overload" the "constructor" of `Polar`.

    doc "A polar coordinate with an optional label"
    class Polar(Float angle, Float radius, String? label=null) {
        
        shared Float angle=angle;
        shared Float radius=radius;
        
        shared String description {
            if (exists label) {
                description = label;
            }
            else {
                description = "(" radius "," angle ")";
            }
        }
        
        ...
        
    }

Now we can create `Polar` coordinates with or without labels:

    Polar origin = Polar(0, 0, "origin");
    Polar coord = Polar(r, theta);


## There's more...

We'll now explore [inheritance and refinement (overriding)](../inheritance).

