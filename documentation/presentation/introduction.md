---
layout: documentation
title: Introduction to Ceylon
tab: documentation
author: Stéphane Épardaud, Emmanuel Bernard
---

# Introduction to Ceylon

## Actions

- convert to Devoxx template
- decide whether to use Mac for both pres and demo or stay agnostic
- add hierarchical structure examples
- currently at 44 slides, 4-5 less and we should be good assuming a quick demo

## Presentation

### An introduction to Ceylon: say more, more clearly

Stéphane Épardaud, Emmanuel Bernard

### Executive summary

- What is Ceylon
- Why Ceylon
- Features and feel
- The community
- Status

### About Stéphane Épardaud

- Riviera JUG team
- Open-Source projects
  - RESTEasy, Ceylon
  - jax-doclets, Play! modules, Stamps.js
- Ceylon contributor since…
  - 13 May 2011 (one month after Ceylon hit SlashDot)
  - Compiler, ceylondoc

### About Emmanuel Bernard

- Hibernate
- JCP
- Podcasts
  - [JBoss Community Asylum](http://asylum.jboss.org)
  - [Les Cast Codeurs](http://lescastcodeurs.com)
- The rest is at <http://emmanuelbernard.com>

- [@emmanuelbernard](htp://twitter.com/emmanuelbernard)

### Origins of Ceylon

- Idea from Gavin King
- Improve upon frustrations of Java
- Help by others at JBoss (Max, Emmanuel, Pete etc)
- Goals
  - on the JVM
  - in the spirit of Java
  - practical
 - Slashdotted ( wo a web site :) )

### Goals

- Easy to learn
- Less verbose but as readable
- Better type safety
- Native representation for hierarchical data (XML, UI, etc)
- Promote a more functional style
- Support meta-programming
- Modular

### Introduction to Ceylon

### A boring class: looks familiar?

- Looks familar, right?

<!-- lang:ceylon -->
    class Rectangle() {
        Integer width = +0;
        Integer height = +0;
        
        Integer area(){
            return width * height;
        }
    }

### A Real Ceylon class

- No surprise

<!-- lang:ceylon -->
    shared class Rectangle(Natural width, 
                           Natural height) {

        shared Natural width = width;
        shared Natural height = height;
        
        shared Natural area(){
            return width * height;
        }
    }

### Where is my constructor?

- In the class body

<!-- lang:ceylon -->
    shared class Rectangle(Natural width, 
                           Natural height){
        // it is here!
        if(width == 0 || height == 0){
            throw;
        }
        shared Natural width = width;
        shared Natural height = height;

        shared Natural area(){
            return width * height;
        }
    }

### First differences

- Simpler access rules
  - No `protected`, `package`, `private`
  - `shared` = public, otherwise scope-private
- Constructor is the class body
- Natural type for positive whole numbers

### Attributes

<!-- lang:ceylon -->
    class Attributes() {
        Natural n = 1;
        variable Natural i := 2;
        i++;
        Natural doubleI {
            return i * 2;
        }
        assign doubleI {
            i := doubleI / 2; 
        }
    }

- __add the following as arrows on the code?__
    - Immutable by default
    - unless `variable` asigned with `:=` are used

### Attributes (more)
- Overridable
- Can be abstract
- like JavaBeans without the carpal tunnel syndrom

### Inheritance

<!-- lang:ceylon -->
    shared class Point(Integer x, Integer y) {
        shared Integer x = x;
        shared Integer y = y;
    }

    shared class Point3D(Integer x, Integer y, 
                         Integer z)
        extends Point(x, y) {

        shared Integer z = z;
    }

### Abstractions

- Method, attributes and classes are overridable
- Can't override by default
  - `default`: overridable, with a default impl
  - `formal`: overridable, with no default impl
- `@Override` in Java => `actual`
  - non optional

### Abstractions (example)

    abstract class Shape() {
        shared formal Natural area();
        // magic: this is toString()
        shared actual default String string {
            return "Abstract area: " area.string " m^2";
        }
    }

    class Square(Natural width) extends Shape() {
        shared actual Natural area() { 
            return width * width;
        }
        shared actual String string = 
            "Square area: " area.string " m^2";
    }

### Overloading

- No Overloading
  - WTF!?
- Overloading is evil
  - make other features much more difficult
  - less is more

### Why do you need overloading in Java?

- To support optional parameters
  - Ceylon has them
  - even named-parameters
- To work on different types of parameters
  - not safe if a new type is introduced
  - Ceylon has union types and type cases

### Optional and named parameters

    class Rectangle(Natural width = 2,
                    Natural height = 3) {
        shared Natural area(){
            return width * height;
        }
    }

    void method(){
        Rectangle rectangle = Rectangle();
        Rectangle rectangle2 = Rectangle {
            width = 3;
            height = 4;
        };
    }

### type based switch case

    void workWithRectangle(Rectangle rect){}
    void workWithCircle(Circle circle){}
    void workWithFigure2D(Figure2D fig){}

    void supportsSubTyping(Figure2D fig){
        switch(fig)
        case(is Rectangle){
            workWithRectangle(fig);
        }
        case(is Circle){
            workWithCircle(fig);
        }
        else{
            workWithFigure2D(fig);
        }
    }

### Interfaces

    interface Figure3D {
        shared formal Float area;
        shared formal Float depth;
        shared formal Float volume;
    }

    class Cube(Float width) satisfies Figure3D {
        shared actual Float area = width * width;
        shared actual Float depth = width;
        shared actual Float volume = area * depth;
    }

    class Cylinder(Natural radius, Float depth) 
            satisfies Figure3D {
        shared actual Float area = 3.14 * radius ** 2;
        shared actual Float depth = depth;
        shared actual Float volume = area * depth;
    }

### Interfaces with default impls

    interface Figure3D {
        shared formal Float area;
        shared formal Float depth;
        shared Float volume {
            return depth * area;
        }
    }

    class Cube(Float width) satisfies Figure3D {
        shared actual Float area = width * width;
        shared actual Float depth = width;
    }

    class Cylinder(Natural radius, Float depth)
            satisfies Figure3D {
        shared actual Float area = 3.14 * radius ** 2;
        shared actual Float depth = depth;
    }

### OMG multiple inheritance mess?

- No state (initialisation)
  - Ordering issues
  - A single superclass
- Must redefine a method `C.a()`
  - if defined in super-interfaces `I1.a()` et `I2.a()`
  - resolution would otherwise be ambiguous

### Ceylon is extremely regular

    Natural attribute = 1;
    Natural attribute2 { return 2; }
    void method(){}
    interface Interface{}

    class Class(Natural x){
        Natural attribute = x;
        Natural attribute2 { return x; }
        class InnerClass(){}
        interface InnerInterface{}
        
        void method(Natural y){
            Natural attribute = x;
            Natural attribute2 { return y; }
            class LocalClass(){}
            interface LocalInterface{}
            void innerMethod(Natural y){}
        }
    }

### A few types examples

    void types(){
        Integer i = -20;
        Natural n = 10.times(2); // no primitive types
        Float f = 3.14;
        String[] s = {"foo", "bar"}; // inference
        Number[] r = 1..2;   // intervals
        Boolean b = true;    // enumerated type
        Cube cube = Cube(2); // constructor
        // inference
        function makeCube(Natural width){ 
            return Cube(width);
        }
        value cube2 = makeCube(3);
    }

### Death to NPEs

![Geek And Poke](http://dessert.philipp-soehnlein.de/wp-content/postmaster-attachments/11-24-2009-104650.jpg "Geek And Poke")

### Type safety

    void typeSafety(){
        // optional?
        Cube? cubeOrNoCube() { return null; }
        Cube? cube = cubeOrNoCube();

        print(cube.area.string); // compile error

        if (exists cube) {
            print(cube.area.string);
        } else {
            print("Got no cube");
        }
    }

### Some sugar on top of type safety

    void typeSafety(){
        // default value
        Cube cube2 = cubeOrNoCube() ? Cube(3);

        // nullsafe access
        Natural? area = maybeCube?.area;

        // nullsafe array access
        Cube[]? maybeList = cubeList();
        Cube? c = maybeList?[2];
    }

### Iterations

    void dealingWithLists(){
        Cube[] list = cubeList();
        if(nonempty list){
            print(list.first.string);
        }
        // sequence
        for(Cube cube in list){
            print(cube.string);
        }else{
            print("No cubes!");
        }
        // range
        for(Integer n in +0..+10){
            print(n.string);
        }
    }

### Operations on lists

    void dealingWithLists(){
        Natural[] numbers = {1,2,3};
        // slices
        Natural[] subList = numbers[1..2];
        Natural[] rest = numbers[1...];
        // map/spread
        Natural[] successors = numbers[].successor;
    }

### Operators

- Almost the same as in Java

- Interface based (fixed set)
  - ==, != on Equality.equals()
  - < on Comparable.smallerThan()
  - lhs[i] on Correspondence.item()
  - ++ on Ordinal.successor
  - \* on Numeric.times()
- No symbols as method name

### Typing

### Union type

- To be able to hold values among a list of types
- We must check the actual type before use
- `TypeA|TypeB`
- `Type?` is an alias for `Type|Nothing`

### Union type example

    class Apple() {
        shared void eat() {}
    }

    class Broccoli() {
        shared void throwAway() {}
    }

    void unions() {
        Sequence<Apple|Broccoli> plate = {Apple(), Broccoli()};
        for(Apple|Broccoli food in plate){
            print(box.string);
            if(is Apple box) {
                box.eat();
            } else if(is Garbage box) {
                box.throwAway();
            }
        }
    }

### Intersection type

    interface Food {
        shared formal void eat(); 
    }

    interface Drink {
        shared formal void drink(); 
    }

    class Guinness() satisfies Food & Drink {
        shared actual void drink() {}
        shared actual void eat() {}
    }

    void intersections(){
        Food & Drink specialStuff = Guinness();
        specialStuff.drink();
        specialStuff.eat();
}

### Type parameters

- Constraints:
  - Upper bounds (satisfies)
  - Lower bounds (abstracts)
  - Enumerated bounds (of `X|Y`)
  - Self bounds (of `Self`)
  - Parameter bounds (of `T(String param)`)
- Variance (`in/out`)
- Parameter type sequence (`T...`)
- Reified parameter types

### A lot more features

- Singletons and anonymous classes
- Introductions
- Attribute and method references
- Closures
- Partial application
- Annotations
- Type aliases
- Meta-model
- Interception

### Modularity

- Unit included in packages included in modules
- module.ceylon declares
  - Name, version, license, documentation
  - Dependencies
  - Initialisation and execution methods
- Distribution
  - repository
  - dependecy resolution in the tools

### Tool chain

- Compiler: ceylonc
  - Takes Java and Ceylon code
  - Produces a .car
- Launcher: ceylon
  - Takes a pkg.Name/version to run it
- Documentation generator: ceylond
  - Takes a pkg.Name/version to generate the docs
- Eclipse Plugin

### Demo!

### Community

- Not public public, not private either
- A few from Red-Hat
  - Gavin, Emmanuel…
- And some new blood: Stef, Tako
- Also contributors
  - Gary, Andrew, Tom, David (Serli), Flavio, Sergej, Ben…

### Future

- Three milestones
- M1 (almost done)
  - Project will become “public”
  - Java interoperabilities
  - All the tools (with the IDE)

### M2 & M3

- M2
  - Interfaces with concrete members
  - Reified methods
  - Introductions
  - Switch
  - Default value parameters
- M3
  - Annotations
  - Reified type parameters
  - Interception
  - Meta-model

### Q&A

- Questions! Answers?
- More info
  - TBD