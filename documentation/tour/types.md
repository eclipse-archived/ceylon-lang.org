---
layout: tour
title: Tour of Ceylon&#58; Types
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the sixth leg in the Tour of Ceylon. The [previous leg](../sequences) 
looked at sequences. Now we will cover Ceylon's type system in more detail.


## Narrowing the type of an object reference

In any language with subtyping there is the (hopefully) occasional need to
perform narrowing conversions. In most statically-typed languages, this is a 
two-part process. For example, in Java, we first test the type of the object 
using the `instanceof` operator, and then attempt to downcast it using a 
C-style typecast. This is quite curious, since there are virtually no good 
uses for `instanceof` that don't involve an immediate cast to the tested 
type, and typecasts without type tests are dangerously non-typesafe.

As you can imagine, Ceylon, with its emphasis upon static typing, does 
things differently. Ceylon doesn't have C-style typecasts. Instead, we 
must test and narrow the type of an object reference in one step, using the 
special `if (is ... )` construct. This construct is very, very similar 
to [`if (exists ... )`](../basics#dealing_with_objects_that_arent_there) and 
[`if (nonempty ... )`](../sequences#the_interface_sequence_represents_a...), 
which we met earlier.

    Object obj = ... ;
    if (is Printable obj) {
        obj.print();
    }

The `switch` statement can be used in a similar way:

    Object obj = ... ;
    switch(obj)
    case (is Hello) {
        obj.print();
    }
    case (is Person) {
        print(obj.firstName);
    }
    else {
        print(obj.string);
    }

These constructs protect us from inadvertantly writing code that would cause a 
`ClassCastException` in Java, just like `if (exists ... )` protects us from 
writing code that would cause a `NullPointerException`.

The `if (is ... )` construct actually narrows to an intersection type.


## Intersection types

An expression is assignable to an *intersection type*, written `X&Y`, if it is 
assignable to *both* `X` and `Y`. For example, since `Empty` is is a subtype 
of `Iterable<Bottom>` and of `Sized`, it's also a subtype of the intersection 
`Iterable<Bottom>&Sized`. The supertypes of an intersection type include all 
supertypes of every intersected type.

Therefore, the following code is well-typed:

    Iterable<Bottom>&Sized empty = {};
    Integer sizeZero = empty.size;  //call size of Sized
    Nothing nullIterator = empty.iterator;  //call iterator of Iterable

Consider the following code:

    Iterable<Bottom> empty = {};
    if (is Sized empty) {
        Integer sizeZero = empty.size;
        Nothing nullIterator = empty.iterator;
    }

Inside the body of the `if` construct, `empty` has the type `Iterable<Bottom>&Sized`,
so we can call operations of both `Iterable` and `Sized`.


## Union types

When the type of something is declared using a union type `X|Y`, that means 
only expressions of type `X` and expressions of type `Y` are assignable to it. 
The type `X|Y` is a supertype of both `X` and `Y`. The following code is 
well-typed:

    void print(String|Integer|Float val) { ... }
     
    print("hello");
    print(69);
    print(-1.0);

But what operations does a type like `String|Integer|Float` have? What are 
its supertypes? Well, the answer is pretty intuitive: `T` is a supertype of 
`X|Y` if and only if it is a supertype of both `X` and `Y`. The Ceylon compiler 
determines this automatically. So the following code is also well-typed:

    Integer|Float x = -1;
    Number num = x;  // Number is a supertype of both Integer and Float
    String|Integer|Float val = x; // String|Integer|Float is a supertype of Integer|Float
    Object obj = val; // Object is a supertype of String, Integer, and Float

However, the following code is *not* well-typed, since since `Number` is not a 
supertype of `String`.

    String|Integer|Float x = -1;
    Number num = x; //compile error: String is not a subtype of Number

Of course, it's very common to narrow an expression of union type using a 
`switch` statement. Usually, the Ceylon compiler forces us to write an `else` 
clause in a `switch`, to remind us that there might be additional cases which 
we have not handled. But if we exhaust all cases of a union type, the compiler 
will let us leave off the `else` clause.

    void print(String|Integer|Float val) {
        switch (val)
        case (is String) { print(val); }
        case (is Integer) { print("Integer: " + val); }
        case (is Float) { print("Float: " + val); }
    }


## Enumerated subtypes

Sometimes it's useful to be able to do the same kind of thing with the 
subtypes of an ordinary type. First, we need to explicitly enumerate the 
subtypes of the type using the `of` clause:

    abstract class Point()
            of Polar | Cartesian {
        ...
    }

(This makes `Point` into Ceylon's version of what the functional programming 
community calls an "algebraic" type.)

Now the compiler won't let us declare additional subclasses of `Point`, and 
so the union type `Polar|Cartesian` is exactly the same type as `Point`. 
Therefore, we can write `switch` statements without an `else` clause:

    Point point = ... ;
    switch (point)
    case (is Polar) {
        print("r = " + point.radius);
        print("theta = " + point.angle);
    }
    case (is Cartesian) {
        print("x = " + point.x);
        print("y = " + point.y);
    }

Now, it's usually considered bad practice to write long `switch` statements 
that handle all subtypes of a type. It makes the code non-extensible. 
Adding a new subclass to `Point` means breaking all the `switch` statements 
that exhaust its subtypes. In object-oriented code, we usually try to 
refactor constructs like this to use an abstract method of the superclass 
that is overridden as appropriate by subclasses.

However, there are a class of problems where this kind of refactoring isn't 
appropriate. In most object-oriented languages, these problems are usually 
solved using the "visitor" pattern.


## Visitors

Let's consider the following tree visitor implementation:

    abstract class Node() {
        shared formal void accept(Visitor v);
    }
    
    class Leaf(Object val) extends Node() {
        shared Object element = val;
        shared actual void accept(Visitor v) {
            v.visitLeaf(this);
        }
    }
    
    class Branch(Node left, Node right) extends Node() {
        shared Node leftChild = left;
        shared Node rightChild = right;
        shared actual void accept(Visitor v) {
            v.visitBranch(this);
        }
    }
    
    interface Visitor {
        shared formal void visitLeaf(Leaf l);
        shared formal void visitBranch(Branch b);
    }

We can create a method which prints out the tree by implementing the `Visitor` 
interface:

    void print(Node node) {
        object printVisitor satisfies Visitor {
            shared actual void visitLeaf(Leaf leaf) {
                print("Found a leaf: " leaf.element "!");
            }
            shared actual void visitBranch(Branch branch) {
                branch.leftChild.accept(this);
                branch.rightChild.accept(this);
            }
        }
        node.accept(printVisitor);
    }

Notice that the code of `printVisitor` looks just like a `switch` statement. 
It must explicitly enumerate all subtypes of `Node`. It "breaks" if we add a 
new subtype of `Node` to the `Visitor` interface. This is correct, and is the 
desired behavior; "break" means that the compiler lets us know that we have to 
update our code to handle the new subtype.

In Ceylon, we can achieve the same effect, with less verbosity, by 
enumerating the subtypes of `Node` in its definition, and using a `switch`:

    abstract class Node() of Leaf | Branch {}
    
    class Leaf(Object val) extends Node() {
        shared Object element = val;
    }
    
    class Branch(Node left, Node right) extends Node() {
        shared Node leftChild = left;
        shared Node rightChild = right;
    }

Our `print()` method is now much simpler, but still has the desired behavior 
of "breaking" when a new subtype of `Node` is added.

    void print(Node node) {
        switch (node)
        case (is Leaf) {
            print("Found a leaf: " node.element "!");
        }
        case (is Branch) {
            print(node.leftChild);
            print(node.rightChild);
        }
    }


## Typesafe enumerations

Ceylon doesn't have anything exactly like Java's `enum` declaration. But we 
can emulate the effect using the `of` clause.

    shared class Suit(String name)
            of hearts | diamonds | clubs | spades
            extends Case(name) {}
    
    shared object hearts extends Suit("hearts") {}
    shared object diamonds extends Suit("diamonds") {}
    shared object clubs extends Suit("clubs") {}
    shared object spades extends Suit("spades") {}

We're allowed to use the names of `object` declarations in the `of` clause 
if they extend the language module class `Case`.

Now we can exhaust all cases of `Suit` in a `switch`:

    void print(Suit suit) {
        switch (suit)
        case (hearts) { print("Heartzes"); }
        case (diamonds) { print("Diamondzes"); }
        case (clubs) { print("Clidubs"); }
        case (spades) { print("Spidades"); }
    }

(Note that these cases are ordinary value cases, not `case (is...)` type cases.)

Yes, this is a bit more verbose than a Java `enum`, but it's also slightly 
more flexible.

For a more practical example, let's see the definition of `Boolean` from the 
language module:

    shared abstract class Boolean(String name)
            of true | false
            extends Case(name) {}
    shared object false extends Boolean("false") {}
    shared object true extends Boolean("true") {}

And here's how `Comparable` is defined. First, the typesafe enumeration 
`Comparison`:

    doc "The result of a comparison between two
         Comparable objects."
    shared abstract class Comparison(String name)
            of larger | smaller | equal
            extends Case(name) {}
    
    shared object equal extends Comparison("equal") {}
    shared object smaller extends Comparison("smaller") {}
    shared object larger extends Comparison("larger") {}

Now, the `Comparable` interface itself:

    shared interface Comparable<in Other>
            satisfies Equality
            given T satisfies Comparable<Other> {
        
        shared formal Comparison compare(Other other);
        
        shared Boolean largerThan(Other other) {
            return compare(other)==larger;
        }
        
        shared Boolean smallerThan(Other other) {
            return compare(other)==smaller;
        }
        
        shared Boolean asLargeAs(Other other) {
            return compare(other)!=smaller;
        }
        
        shared Boolean asSmallAs(Other other) {
            return compare(other)!=larger;
        }
        
    }


## Type aliases

It's often useful to provide a shorter or more semantic name to an existing 
class or interface type, especially if the class or interface is a 
parameterized type. For this, we use a *type alias*, for example:

    interface People = Set<Person>;

A class alias must declare its formal parameters:

    shared class People(Person... people) = ArrayList<Person>;


## Type inference

So far, we've always been explicitly specifying the type of every declaration. 
This generally makes code, especially example code, much easier to read and 
understand.

However, Ceylon does have the ability to infer the type of a local variable 
or the return type of a local method. Just place the keyword 
`value` (in the case of a local variable) or `function` (in the case of a 
local method) in place of the type declaration.

    value polar = Polar(pi, 2.0);
    value operators = { "+", "-", "*", "/" };
    function add(Integer x, Integer y) { return x+y; }

There are some restrictions applying to this feature. You can't use `value` 
or `function`:

* for declarations annotated `shared`,
* for declarations annotated `formal`,
* when the value is specified later in the block of statements, or
* to declare a parameter.

These restrictions mean that Ceylon's type inference rules are quite simple. 
Type inference is purely "right-to-left" and "top-to-bottom". The type of any 
expression is already known without needing to look to any types declared 
to the left of the `=` specifier, or further down the block of statements.

* The inferred type of a local declared `value` is just the type of the 
  expression assigned to it using `=` or `:=`.
* The inferred type of a method declared `function` is just the union the 
  returned expression types appearing in the method's `return` statements
  (or `Bottom` if the method has no `return` statement).


## Type inference for sequence enumeration expressions

What about sequence enumeration expressions like this:

    value sequence  = { Polar(0.0, 0.0), Cartesian(1.0, 2.0) };

What type is inferred for `sequence`? You might answer: "`Sequence<X>`
where `X` is the common superclass or super-interface of all the element 
types". But that can't be right, since there might be more than one 
common supertype.

The answer is that the inferred type is `Sequence<X>` where `X` is the 
union of all the element expression types. In this case, the type is 
`Sequence<Polar|Cartesian>`. Now, this works out nicely, because 
`Sequence<T>` is [covariant](../generics#covariance_and_contravariance) in `T`. 
So the following code is well-typed:

    value sequence  = { Polar(0.0, 0.0), Cartesian(1.0, 2.0) }; //type Sequence<Polar|Cartesian>
    Point[] points = sequence; //type Empty|Sequence<Point>

As is the following code:

    value nums = { 12.0, 1, -3 }; //type Sequence<Float|Integer>
    Number[] numbers = nums; //type Empty|Sequence<Number>

What about sequences that contain `null`? Well, do you 
[remember](../basics#dealing_with_objects_that_arent_there) 
the type of `null` was `Nothing`?

    value sequence = { null, "Hello", "World" }; //type Sequence<Nothing|String>
    String?[] strings = sequence; //type Empty|Sequence<Nothing|String>
    String? s = sequence[0]; //type Nothing|Nothing|String which is just Nothing|String

It's interesting just how useful union types turn out to be. Even if you only 
very rarely explicitly write code with any explicit union type declaration 
(and that's probably a good idea), they are still there, under the covers, 
helping the compiler solve some hairy, otherwise-ambiguous, typing problems.


## There's more...

Next we'll explore Ceylon's [generic type system](../generics) in more depth. 
