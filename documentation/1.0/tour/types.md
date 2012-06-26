---
layout: tour
title: Tour of Ceylon&#58; Types
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the seventh step in the Tour of Ceylon. The 
[previous installment](../sequences) introduced sequences. Now it's time to 
explore Ceylon's type system in more detail. 

In this chapter, we're going to discuss the closely related topics of _union 
and intersection types_, _enumerated types_, narrowing types, and finally 
_local type inference_. In this area, Ceylon's type system works quite 
differently from other langauges with static typing.


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

<!-- cat: interface Printable { shared formal void print(); } -->
    void printIfPrintable(Object obj) {
        if (is Printable obj) {
            obj.print();
        }
    }

The `switch` statement can be used in a similar way:

<!-- cat: 
    class Hello() { 
        shared void print() {
        }
    } 
    class Person(String firstName) { 
        shared String firstName = firstName; 
    } 
-->
    void switchingPrint(Object obj) {
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
    }

These constructs protect us from inadvertantly writing code that would cause a 
`ClassCastException` in Java, just like `if (exists ... )` protects us from 
writing code that would cause a `NullPointerException`.

The `if (is ... )` construct actually narrows to an intersection type.


## Intersection types

An expression is assignable to an *intersection type*, written `X&Y`, if it is 
assignable to *both* `X` and `Y`. For example, since 
[`Empty`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html)
is a subtype of 
[`Iterable<Bottom>`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html) 
and of 
[`Sized`](#{site.urls.apidoc_current}/ceylon/language/interface_Sized.html),
it's also a subtype of the intersection 
`Iterable<Bottom>&Sized`. The supertypes of an intersection type include all 
supertypes of every intersected type.

Therefore, the following code is well-typed:

    Iterable<Bottom>&Sized empty = {};
    Integer sizeZero = empty.size;  //call size of Sized
    Iterator<Bottom> nullIterator = empty.iterator;  //call iterator of Iterable

Now consider this code, to see the effect of `if (is ...)`:

<!-- cat: void m() { -->
    Iterable<Bottom> empty = {};
    if (is Sized empty) {
        Integer sizeZero = empty.size;
        Iterator<Bottom> nullIterator = empty.iterator;
    }
<!-- cat: } -->

Inside the body of the `if` construct, `empty` has the type `Iterable<Bottom>&Sized`,
so we can call operations of both `Iterable` and `Sized`.


## Union types

An expression is assignable to a *union type*, written `X|Y`, if it is assigmable
to *either* `X` or `Y`. The type `X|Y` is always a supertype of both `X` and `Y`. 
The following code is well-typed:

<!-- check:none:pedagogical -->
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

However, the following code is *not* well-typed, since 
[`Number`](#{site.urls.apidoc_current}/ceylon/language/interface_Number.html) 
is not a supertype of
[`String`](#{site.urls.apidoc_current}/ceylon/language/class_String.html).

<!-- check:none:demoing compile error -->
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
        case (is Integer) { print("Integer: " + val.string); }
        case (is Float) { print("Float: " + val.string); }
    }

A union type is a kind of *enumerated type*.

## Enumerated types

Sometimes it's useful to be able to do the same kind of thing with the 
subtypes of a class or interface. First, we need to explicitly enumerate the 
subtypes of the type using the `of` clause:

<!-- implicit-id:Polar:
    class Polar(Float radius, Float angle) extends Point() {
        shared Float radius = radius;
        shared Float angle = angle;
    }
    class Cartesian(Float x, Float y) extends Point() {
        shared Float x = x;
        shared Float y = y;
    }
-->

<!-- id:Point -->
    abstract class Point()
            of Polar | Cartesian {
        // ...
    }
<!-- cat-id: Polar -->

(This makes `Point` into Ceylon's version of what the functional programming 
community calls an "algebraic" or "sum" type.)

Now the compiler won't let us declare additional subclasses of `Point`, and 
so the union type `Polar|Cartesian` is exactly the same type as `Point`. 
Therefore, we can write `switch` statements without an `else` clause:

<!-- cat-id: Point -->
<!-- cat-id: Polar -->
    void printPoint(Point point) {
        switch (point)
        case (is Polar) {
            print("r = " + point.radius.string);
            print("theta = " + point.angle.string);
        }
        case (is Cartesian) {
            print("x = " + point.x.string);
            print("y = " + point.y.string);
        }
    }

Now, it's usually considered bad practice to write long `switch` statements 
that handle all subtypes of a type. It makes the code non-extensible. Adding 
a new subclass to `Point` means breaking all the `switch` statements that 
exhaust its subtypes. In object-oriented code, we usually try to refactor 
constructs like this to use an abstract method of the superclass that is 
overridden as appropriate by subclasses.

However, there is a class of problems where this kind of refactoring isn't 
appropriate. In most object-oriented languages, these problems are usually 
solved using the "visitor" pattern.


## Visitors

Let's consider the following tree visitor implementation:

<!-- id:tree -->
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

<!-- cat-id:tree -->
    void printTree(Node node) {
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
desired behavior; "break" means that the compiler lets us know that we have 
to update our code to handle the new subtype.

In Ceylon, we can achieve the same effect, with less verbosity, by 
enumerating the subtypes of `Node` in its definition, and using a `switch`:

<!-- id:tree2 -->
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

<!-- cat-id:tree2 -->
    void printTree(Node node) {
        switch (node)
        case (is Leaf) {
            print("Found a leaf: " node.element "!");
        }
        case (is Branch) {
            print(node.leftChild);
            print(node.rightChild);
        }
    }

## Enumerated interfaces

Ordinarily, Ceylon won't let us use interface types as `case`s of a `switch`.
If `File`, `Directory`, and `Link` are interfaces, we ordinarily can't write:

    File|Directory|Link resource = ... ;
    switch (resource) 
    case (is File) { ... }
    case (is Directory) { ... } //compile error: cases are not disjoint
    case (is Link) { ... }  //compile error: cases are not disjoint

The problem is that the cases are not _disjoint_. We could have a class that
satisfies both `File` and `Directory`, and then we wouldn't know which branch
to execute! 

(In all our previous examples, our `case`s referred to types which were 
provably disjoint, because they were classes, which support only single
inheritance.)

There's a workaround, however. When an interface has enumerated subtypes, the
compiler enforces those subtypes to be disjoint. So if we define the following
enumerated interface:

    interface Resource of File|Directory|Link { ... }

Then the following declaration is an error:

    class DirectoryFile() 
            satisfies File&Directory {} //compile error: File and Directory are disjoint types

Now this is accepted by the compiler:

    Resource resource = ... ;
    switch (resource) 
    case (is File) { ... }
    case (is Directory) { ... }
    case (is Link) { ... }

The compiler is pretty clever when it comes to reasoning about disjointness
and exhaustion. For example, this is acceptable:

    Resource resource = ... ;
    switch (resource) 
    case (is File|Directory) { ... }
    case (is Link) { ... }

As is this, assuming the above declaration of `Resource`:

    File|Directory resource = ... ;
    switch (resource) 
    case (is File) { ... }
    case (is Directory) { ... }

If you're interested in knowing more about how this works, 
[read this](/blog/2012/01/25/enumerated-types/#how_the_compiler_reasons_about_enumerated_types).


## Enumerated instances

Ceylon doesn't have anything exactly like Java's `enum` declaration. But we 
can emulate the effect using the `of` clause.

<!-- id:Suit -->
    shared abstract class Suit(String name)
            of hearts | diamonds | clubs | spades {}
    
    shared object hearts extends Suit("hearts") {}
    shared object diamonds extends Suit("diamonds") {}
    shared object clubs extends Suit("clubs") {}
    shared object spades extends Suit("spades") {}

We're allowed to use the names of `object` declarations in the `of` clause.

Now we can exhaust all cases of `Suit` in a `switch`:

<!-- cat-id:Suit -->
    void printSuit(Suit suit) {
        switch (suit)
        case (hearts) { print("Heartzes"); }
        case (diamonds) { print("Diamondzes"); }
        case (clubs) { print("Clidubs"); }
        case (spades) { print("Spidades"); }
    }

Note that these cases are value cases, not `case (is...)` type cases. They
don't narrow the type of `suit`.

Yes, this is a bit more verbose than a Java `enum`, but it's also somewhat 
more flexible.

For a more practical example, check out the definition of 
[`Boolean`](#{site.urls.apidoc_current}/ceylon/language/class_Boolean.html) 
and [`Comparison`](#{site.urls.apidoc_current}/ceylon/language/class_Comparison.html) 
in the language module.


## Type aliases

It's often useful to provide a shorter or more semantic name to an existing 
class or interface type, especially if the class or interface is a 
parameterized type. For this, we use a *type alias*, for example:

<!-- cat: 
    class Person() {
    }
-->
    interface People = Set<Person>;

A class alias must declare its formal parameters:

<!-- check:none:ArrayList -->
    shared class People(Person... people) = ArrayList<Person>;

### implementation note <!-- m3 -->

Please note that type aliases are not yet supported in Ceylon M3. They will
make their first appearance in the next release.

## Type inference

So far, we've always been explicitly specifying the type of every declaration. 
This generally makes code, especially example code, much easier to read and 
understand.

However, Ceylon does have the ability to infer the type of a local variable 
or the return type of a local method. Just place the keyword 
`value` (in the case of a local variable) or `function` (in the case of a 
local method) in place of the type declaration.

<!-- cat-id: Point -->
<!-- cat-id: Polar -->
<!-- cat: Float pi = 3.14159; -->
<!-- cat: void m() { -->
    value polar = Polar(pi, 2.0);
    value operators = { "+", "-", "*", "/" };
    function add(Integer x, Integer y) { return x+y; }
<!-- cat: } -->

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
* The inferred type of a method declared `function` is just the union of the 
  returned expression types appearing in the method's `return` statements
  (or `Bottom` if the method has no `return` statement).


## Type inference for sequence enumeration expressions

What about sequence enumeration expressions like this:

<!-- cat-id: Point -->
<!-- cat-id: Polar -->
<!-- cat: void m() { -->
    value sequence  = { Polar(0.0, 0.0), Cartesian(1.0, 2.0) };
<!-- cat: } -->

What type is inferred for `sequence`? You might answer: "`Sequence<X>`
where `X` is the common superclass or super-interface of all the element 
types". But that can't be right, since there might be more than one 
common supertype.

The answer is that the inferred type is `Sequence<X>` where `X` is the 
union of all the element expression types. In this case, the type is 
`Sequence<Polar|Cartesian>`. Now, this works out nicely, because 
`Sequence<T>` is [covariant](../generics#covariance_and_contravariance) 
in `T`. So the following code is well-typed:

<!-- cat-id: Point -->
<!-- cat-id: Polar -->
<!-- cat: void m() { -->
    value sequence  = { Polar(0.0, 0.0), Cartesian(1.0, 2.0) }; //type Sequence<Polar|Cartesian>
    Point[] points = sequence; //type Empty|Sequence<Point>
<!-- cat: } -->

As is the following code:

<!-- cat: void m() { -->
    value nums = { 12.0, 1, -3 }; //type Sequence<Float|Integer>
    Number[] numbers = nums; //type Empty|Sequence<Number>
<!-- cat: } -->

What about sequences that contain `null`? Well, do you 
[remember](../basics#dealing_with_objects_that_arent_there) 
the type of `null` was 
[`Nothing`](#{site.urls.apidoc_current}/ceylon/language/class_Nothing.html)?

<!-- cat: void m() { -->
    value sequence = { null, "Hello", "World" }; //type Sequence<Nothing|String>
    String?[] strings = sequence; //type Empty|Sequence<Nothing|String>
    String? s = sequence[0]; //type Nothing|Nothing|String which is just Nothing|String
<!-- cat: } -->

It's interesting just how useful union types turn out to be. Even if you only 
rarely write code with explicit union type declarations, they're still there, 
under the covers, helping the compiler solve some hairy, otherwise-ambiguous, 
typing problems.


## There's more...

You can read a bit more about enumerated types in Ceylon in 
[this blog post](/blog/2012/01/25/enumerated-types).

Next we'll explore Ceylon's [generic type system](../generics) in more depth. 
