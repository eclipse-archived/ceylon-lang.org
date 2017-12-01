---
layout: tour
title: Classes
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# #{page.title}

This is the second step in our tour of the Ceylon language. In 
the [previous leg](../basics) you learned some of the basics of 
the syntax of Ceylon. In this leg we're going to learn how to
define classes with methods and attributes.

## Identifier naming

The case of the first character of an identifier is significant.
Type (interface, class, and type parameter) names must start 
with an initial capital letter. Function and value names start 
with an initial lowercase letter or underscore. The Ceylon 
compiler is very fussy about this. You'll get a compilation error 
if you write:

<!-- try:
    class hello() { } //compile error
-->
    class hello() { ... } //compile error

or:

<!-- try:
    String Name = "joe"; //compile error
-->
    String Name = .... //compile error

There is a way to work around this restriction, which is 
mainly useful when calling legacy Java code. You can "force"
the compiler to understand that an identifier is a type name
by prefixing it with `\I`, or that it is a function or value
name by prefixing it with `\i`. For example, `\iRED` is 
considered an initial lowercase identifier.

So the following declarations are acceptable, but definitely 
not recommended, except in the interop scenario: 

<!-- try:
    class \Ihello() { } //OK, but not recommended
-->
    class \Ihello() { ... } //OK, but not recommended

and:

<!-- try:
    String \iName = "joe"; //OK, but not recommended
-->
    String \iName = .... //OK, but not recommended

## Creating your own class

Our first class is going to represent points in a polar coordinate 
system. Our class has two parameters, two methods, and an attribute.

<!-- try-post:
    print(Polar(0.37, 10.0).description);
-->
    "A polar coordinate"
    class Polar(Float angle, Float radius) {
        
        shared Polar rotate(Float rotation) =>
                Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) =>
                Polar(angle, radius*dilation);
        
        shared String description = "(``radius``,``angle``)";
        
    }

There's two things in particular to notice here:

1. The parameters used to instantiate a class are specified as part of the 
   class declaration, right after the name of the class. There's no Java-style 
   constructors in Ceylon. This syntax is less verbose and more regular than 
   Java, C#, or C++.
   
2. We make use of the parameters of a class anywhere within the body of 
   the class. In Ceylon, we often don't need to define explicit members of the 
   class to hold the parameter values. Instead, we can access the parameters
   `angle` and `radius` directly from the `rotate()` and `dilate()` methods, 
   and from the expression which specifies the value of `description`.

Notice also that Ceylon doesn't have a `new` keyword to indicate instantiation,
we just "invoke the class", writing `Polar(angle, radius)`.

The `shared` annotation determines the accessibility of the annotated type, 
attribute, or method. Before we go any further, let's see how we can hide the 
internal implementation of a class from other code.


## Hiding implementation details

Ceylon doesn't make a distinction between `public`, `protected` and "default" 
visibility like Java does; 
[here's why](#{page.doc_root}/faq/language-design/#no_protected_modifier). 
Instead, the language distinguishes between: 

* program elements which are visible only inside the scope in which they are 
  defined, and
* program elements which are visible wherever the thing they belong to (a type, 
  package, or module) is visible.

By default, members of a class are hidden from code outside the body of the 
class. By annotating a member with the `shared` annotation, we declare that 
the member is visible to any code to which the class itself is visible.

And, of course, a class itself may be hidden from other code. By default, a 
toplevel class is hidden from code outside the package in which the class is 
defined. Annotating a top level class with `shared` makes it visible to any 
code to which the package containing the class is visible.

Finally, packages are hidden from code outside the module to which the 
package belongs by default. Only explicitly shared packages are visible to 
other modules.

Got the idea? We are playing Russian dolls here.


## Exposing parameters as attributes

If we want to expose the `angle` and `radius` of our `Polar` coordinate to
other code, we need to define attributes of the class. It's very common to 
assign parameters of a class directly to a `shared` attribute of the class, 
so Ceylon provides a streamlined syntax for this.

<!-- try-post:
    print(Polar(0.37, 10.0).description);
-->
<!-- id:polar -->
    "A polar coordinate"
    class Polar(angle, radius) {
        
        shared Float angle;
        shared Float radius;
        
        shared Polar rotate(Float rotation) =>
                Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) =>
                Polar(angle, radius*dilation);
        
        shared String description = "(``radius``,``angle``)";
        
    }

Code that uses `Polar` can access the attributes of the class using a very
convenient syntax.

<!-- try: -->
<!-- check:none:Requires Math -->
<!-- cat-id:polar -->
<!-- cat:
    shared class Cartesian(Float x, Float y) {} -->
    shared Cartesian cartesian(Polar polar) {
        return Cartesian(polar.radius*cos(polar.angle), 
                         polar.radius*sin(polar.angle));
    }

There's an even more compact way to write the code above, though it's often
less readable:

<!-- try-post:
    print(Polar(0.37, 10.0).description);
-->
<!-- id:polar -->
    "A polar coordinate"
    class Polar(shared Float angle, shared Float radius) {
        
        shared Polar rotate(Float rotation) =>
                Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) =>
                Polar(angle, radius*dilation);
        
        shared String description = "(``radius``,``angle``)";
        
    }

This illustrates an important feature of Ceylon: there is almost no 
essential difference, aside from syntax, between a parameter of a class,
and a value declared in the body of the class.

Instead of declaring the attributes in the body of the class, we simply
annotated the parameters `shared`. We encourage you to avoid this shortcut 
when you have more than one or two parameters.

## Initializing attributes

The attributes `angle` and `radius` are _references_, the closest thing 
Ceylon has to a Java field. Usually we specify the value of a reference
when we declare it.

<!-- try: -->
<!-- check:none:Requires Math -->
    shared Float x = radius * sin(angle);
    shared String greeting = "Hello, ``name``!";
    shared Integer months = years * 12;

On the other hand, it's sometimes useful to separate declaration from 
assignment.
<!-- try-pre:
    "A polar coordinate"
    class Polar(Float angle, Float radius, String? label) { 
-->
<!-- try-post:
    }
    print(Polar(0.37, 10.0, "point").description);
-->
<!-- cat:
    "A polar coordinate"
    class Polar(Float angle, Float radius, String? label) { 
        // ...
     -->
    shared String description;
    if (exists label) {
        description = label;
    }
    else {
        description = "(``radius``,``angle``)";
    }
<!-- cat: } -->

But if there's no constructors in Ceylon, where precisely should we put this
code? We put it directly in the body of the class!

<!-- try-post:
    print(Polar(0.37, 10.0, null).description);
    print(Polar(0.0, 0.0, "origin").description);
-->
    "A polar coordinate with an optional label"
    class Polar(angle, radius, String? label) {
        
        shared Float angle;
        shared Float radius;
        
        shared String description;
        if (exists label) {
            description = label;
        }
        else {
            description = "(``radius``,``angle``)";
        }
        
        // ...
        
    }

The Ceylon compiler forces you to specify a value of any reference before 
making use of the reference in an expression.

<!-- check:none:Demoing error -->
    Integer count;
    void inc() {
        count++;   //compile error
    }

We'll learn more about this [later in the tour](../initialization).

## Abstracting state using attributes

If you're used to writing JavaBeans, you can think of a reference as a
combination of several things:

* a field,
* a getter, and, sometimes, 
* a setter. 

That's because not all value are references like the one we've just seen; 
others are more like a getter method, or, sometimes, like a getter and 
setter method pair.

We'll need to expose the equivalent cartesian coordinates of a `Polar`.
Since the cartesian coordinates can be computed from the polar coordinates,
we don't need to define state-holding references. Instead, we can define 
the attributes as _getters_.

<!-- try: -->
<!-- check:none:Requires Math -->
    import ceylon.math.float { sin, cos }
    
    "A polar coordinate"
    class Polar(angle, radius) {
        
        shared Float angle;
        shared Float radius;
        
        shared Float x => radius * cos(angle);
        shared Float y => radius * sin(angle);
        
        // ...
        
    }

Notice that the syntax of a getter declaration looks a lot like a method 
declaration with no parameter list.

So in what way are attributes "abstracting state"? Well, code that uses 
`Polar` never needs to know if an attribute is a reference or a getter. 
Now that we know about getters, we could rewrite our `description` 
attribute as a getter, without affecting any code that uses it.

<!-- try-post:
    print(Polar(0.37, 10.0, null).description);
-->
    "A polar coordinate, with an optional label"
    class Polar(angle, radius, String? label) {
        
        shared Float angle;
        shared Float radius;
        
        shared String description {
            if (exists label) {
                return label;
            }
            else {
                return "(``radius``,``angle``)";
            }
        }
    }

## Living without static members

Right at the beginning of the tour, we mentioned that Ceylon doesn't have
`static` members like in Java, C#, or C++. Instead of a `static` member, 
we either:

- use a toplevel function or value declaration, or
- in the case where several "static" declarations need to share some private
  stuff, members of a singleton `object` declaration, which we'll meet right
  [at the start of the next chapter](../anonymous-member-classes/#anonymous_classes).

The lack of static members results in a minor gotcha for newcomers.

### Gotcha!

The syntax `Polar.radius` is legal in Ceylon, and we even call it a 
[static reference](../functions/#static_method_and_attribute_references), 
but it does not usually mean what you think it means!

Sure, if you're taking advantage of Ceylon's Java interop, you can call 
a static member of a Java class using this syntax, just like you can in
Java:

<!-- try: -->
    import java.lang { Runtime }
    
    Integer procs = Runtime.runtime.availableProcessors();

Or, alternatively, you could write the following:

<!-- try: -->
    import java.lang { Runtime { runtime } }
    
    Integer procs = runtime.availableProcessors(); 

But in regular Ceylon code, an expression like `Polar.radius` is _not_ a
reference to a static member of the class `Polar`. We'll come back to the 
question of what a "static reference" really is, when we discuss 
[higher-order functions](../functions).


## Living without overloading

It's time for some bad news: Ceylon doesn't have method or constructor 
overloading (the truth is that overloading is the source of various problems 
in Java, especially when generics come into play). However we can emulate 
most non-harmful uses of constructor or method overloading using:

* defaulted parameters, 
* variadic parameters (varargs), and
* union types or enumerated type constraints.

We're not going to get into all the details of these workarounds right now, 
but here's a quick example of each of the three techniques:

<!-- try: -->
    //defaulted parameter
    void println(String line, String eol = "\n") =>
            process.write(line + eol);

<br/>
<!-- try: -->
    //variadic parameter
    void printlns(String* lines) {
        for (line in lines) {
            println(line);
        }
    }

<br/>
<!-- try: -->
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

Don't worry if you don't completely understand the third example just yet, 
we'll come back to it [later in the tour](../types#union_types). 

Let's make use of this idea to "overload" the "constructor" of `Polar`.

<!-- try: -->
<!-- id: polar -->
    "A polar coordinate with an optional label"
    class Polar(angle, radius, String? label=null) {
        
        shared Float angle;
        shared Float radius;
        
        shared String description {
            if (exists label) {
                return label;
            }
            else {
                return "(``radius``,``angle``)";
            }
        }
        
        // ...
        
    }

Now we can create `Polar` coordinates with or without labels:

<!-- try-pre:
    "A polar coordinate with an optional label"
    class Polar(angle, radius, String? label=null) {
        
        shared Float angle;
        shared Float radius;
        
        shared String description {
            if (exists label) {
                return label;
            }
            else {
                return "(``radius``,``angle``)";
            }
        }
        
        // ...
        
    }

    Float r = 0.32;
    Float theta = 10.0;
-->
<!-- try-post:
    print(origin.description);
    print(coord.description);
-->
<!-- cat-id: polar -->
<!-- cat: void m(Float r, Float theta) { -->
    Polar origin = Polar(0.0, 0.0, "origin");
    Polar coord = Polar(r, theta);
<!-- cat: } -->

## There's more...

In the [next chapter](../attributes-control-structures), we'll continue our 
investigation of attributes, and especially _variable_ attributes. We'll also
meet Ceylon's [control structures](../attributes-control-structures/#control_structures).

(We'll wait until a later chapter to learn more about [methods](../functions).)
