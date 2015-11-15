---
layout: tour12
title: Union, intersection, and enumerated types
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the eighth step in the Tour of Ceylon. In the 
[previous installment](../typeinference) we learned about type aliases and
type inference. Let's continue our exploration of Ceylon's type system.

In this chapter, we're going to discuss the closely related topics of _union 
and intersection types_ and _enumerated types_. In this area, Ceylon's type 
system works quite differently to other languages with static typing.


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
[`if (nonempty ... )`](../sequences#sequences), which we met earlier.

<!-- try-pre:
    interface Printable {
        shared formal void printObject();
    }
    class PrintableString(String string) satisfies Printable{
        printObject() => print(string);
    }
-->
<!-- try-post:
    printIfPrintable("foo");
    printIfPrintable(PrintableString("bar"));
-->
    void printIfPrintable(Object obj) {
        if (is Printable obj) {
            obj.printObject();
        }
    }
    
There's also a special `if (!is ... )` construct which comes in handy
from time to time.

The `switch` statement can be used in a similar way:

<!-- try-pre:
    class Hello(String txt) {
        shared void printMsg() { print("Hello, ``txt``"); }
    }
    class Person(firstName, lastName) {
        shared String firstName;
        shared String lastName;
    }
-->
<!-- try-post:
switchingPrint(Hello("World"));
switchingPrint(Person("Pietje", "Pluk"));
switchingPrint("foo");
-->
    void switchingPrint(Object obj) {
        switch (obj)
        case (is Hello) {
            obj.printMsg();
        }
        case (is Person) {
            print(obj.firstName);
        }
        else {
            print(obj.string);
        }
    }

These constructs protect us from inadvertently writing code that would 
cause a `ClassCastException` in Java, just like `if (exists ... )` 
protects us from writing code that would cause a `NullPointerException`.

Now, in cases we _really_ want to do something more like a Java-style 
typecast, we would use an `assert` statement, which we saw 
[earlier](../attributes-control-structures/#assertions).

<!-- try-pre:
    interface Printable {
        shared formal void printObject();
    }
    class PrintableString(String string) satisfies Printable{
        printObject() => print(string);
    }
-->
<!-- try-post:
    printIfPrintable("foo");
    //results in an AssertionError!
    printIfPrintable(PrintableString("bar"));
-->
    void printIfPrintable(Object obj) {
        assert (is Printable obj);
        obj.printObject();
    }

But assertions should be avoided where reasonable. They undermine the
ability of the compiler to tell us about logic errors in our program
at compile time, resulting in more errors at runtime.

The `is` conditions in `if`, `switch`, or `assert` actually narrow to 
an intersection type.

## Intersection types

An expression is assignable to an *intersection type*, written `X&Y`, 
if it is assignable to *both* `X` and `Y`. For example, since 
[`Tuple`](#{site.urls.apidoc_1_2}/Tuple.type.html)
is a subtype of 
[`Iterable`](#{site.urls.apidoc_1_2}/Iterable.type.html) 
and of 
[`Correspondence`](#{site.urls.apidoc_1_2}/Correspondence.type.html),
the tuple type `[String,String]` is also a subtype of the intersection 
`{String*} & Correspondence<Integer,String>`. The supertypes of 
an intersection type include all supertypes of every intersected type.

Therefore, the following code is well-typed:

    {String*} & Correspondence<Integer,String> strings 
            = ["hello", "world"];
    String? str = strings.get(0);  //call get() of Correspondence
    Integer size = strings.size;  //call size of Iterable

Now consider this code, to see the effect of `if (is ...)`:

    {String*} strings = ["hello", "world"];
    if (is Correspondence<Integer,String> strings) {
        //here strings has type 
        //{String*} & Correspondence<Integer,String>
        String? str = strings.get(0);
        Integer size = strings.size;
    }

Inside the body of the `if` construct, `strings` has the type 
`{String*} & Correspondence<Integer,String>`, so we can call 
operations of both `Iterable` and of `Correspondence`.


## Union types

An expression is assignable to a *union type*, written `X|Y`, if it is assignable
to *either* `X` or `Y`. The type `X|Y` is always a supertype of both `X` and `Y`. 
The following code is well-typed:

<!-- try:
    void printType( String | Integer | Float val) {
        switch(val)
        case(is String) { print("String: ``val``"); }
        case(is Integer) { print("Integer: ``val``"); }
        case(is Float) { print("Float: ``val``"); }
    }

    printType("hello");
    printType(69);
    printType(-1.0);
-->
<!-- check:none:pedagogical -->
    void printType(String|Integer|Float val) { ... }
     
    printType("hello");
    printType(69);
    printType(-1.0);

But what operations does a type like `String|Integer|Float` have? What are 
its supertypes? Well, the answer is pretty intuitive: `T` is a supertype of 
`X|Y` if and only if it is a supertype of both `X` and `Y`. The Ceylon compiler 
determines this automatically. So the following code is also well-typed:

    Integer|Float x = -1;
    Number<out Anything> num = x;  // Number is a supertype of both Integer and Float
    String|Integer|Float val = x; // String|Integer|Float is a supertype of Integer|Float
    Object obj = val; // Object is a supertype of String, Integer, and Float

However, the following code is *not* well-typed, since 
[`Number`](#{site.urls.apidoc_1_2}/Number.type.html) 
is not a supertype of
[`String`](#{site.urls.apidoc_1_2}/String.type.html).

<!-- check:none:demoing compile error -->
    String|Integer|Float x = -1;
    Number<out Anything> num = x; //compile error: String is not a subtype of Number<out Anything>

Of course, it's very common to narrow an expression of union type using a 
`switch` statement. Usually, the Ceylon compiler forces us to write an `else` 
clause in a `switch`, to remind us that there might be additional cases which 
we have not handled. But if we exhaust all cases of a union type, the compiler 
will let us leave off the `else` clause.

<!-- try-post:
    printType("hello");
    printType(69);
    printType(-1.0);
-->
    void printType(String|Integer|Float val) {
        switch (val)
        case (is String) { print("String: ``val``"); }
        case (is Integer) { print("Integer: ``val``"); }
        case (is Float) { print("Float: ``val``"); }
    }

A union type is a kind of *enumerated type*.

### Gotcha!

The `case`s of a `switch` statement must be [disjoint](#more_about_disjointness).
Since `String`, `Integer`, and `Float` are disjoint types, the above `switch`
statement is legal. If a union type is formed from types which aren't disjoint,
those types can't be used as distinct `case`s. 

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

<!-- try-post:
    class Polar(radius, angle) extends Point() {
        shared Float radius;
        shared Float angle;
    }
    class Cartesian(x, y) extends Point() {
        shared Float x;
        shared Float y;
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

<!-- try-pre:
    abstract class Point() of Polar | Cartesian { }
    class Polar(radius, angle) extends Point() {
        shared Float radius;
        shared Float angle;
    }
    class Cartesian(x, y) extends Point() {
        shared Float x;
        shared Float y;
    }
-->
<!-- try-post:
    printPoint(Polar(10.0, 0.31));
    printPoint(Cartesian(4.0, 5.0));
-->
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
    
    class Leaf(shared Object element) 
            extends Node() {
        accept(Visitor v) => v.visitLeaf(this);
    }
    
    class Branch(shared Node left, shared Node right) 
            extends Node() {
        accept(Visitor v) => v.visitBranch(this);
    }
    
    interface Visitor {
        shared formal void visitLeaf(Leaf l);
        shared formal void visitBranch(Branch b);
    }

We can create a method which prints out the tree by implementing the `Visitor` 
interface:

<!-- try-pre:
    abstract class Node() {
        shared formal void accept(Visitor v);
    }
    
    class Leaf(shared Object element) 
            extends Node() {
        accept(Visitor v) => v.visitLeaf(this);
    }
    
    class Branch(shared Node left, shared Node right) 
            extends Node() {
        accept(Visitor v) => v.visitBranch(this);
    }
    
    interface Visitor {
        shared formal void visitLeaf(Leaf l);
        shared formal void visitBranch(Branch b);
    }

-->
<!-- try-post:

    printTree(Branch(Branch(Leaf("aap"), Leaf("noot")), Leaf("mies")));
-->
<!-- cat-id:tree -->
    void printTree(Node node) {
        object printVisitor satisfies Visitor {
            shared actual void visitLeaf(Leaf leaf) {
                print("Found a leaf: ``leaf.element``!");
            }
            shared actual void visitBranch(Branch branch) {
                branch.left.accept(this);
                branch.right.accept(this);
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
    
    class Leaf(shared Object element) 
            extends Node() {}
    
    class Branch(shared Node left, shared Node right) 
            extends Node() {}

Our `print()` method is now much simpler, but still has the desired behavior 
of "breaking" when a new subtype of `Node` is added.

<!-- try-pre:
    abstract class Node() of Leaf | Branch {}
    
    class Leaf(shared Object element) 
            extends Node() {}
    
    class Branch(shared Node left, shared Node right) 
            extends Node() {}

-->
<!-- try-post:

    printTree(Branch(Branch(Leaf("aap"), Leaf("noot")), Leaf("mies")));
-->
<!-- cat-id:tree2 -->
    void printTree(Node node) {
        switch (node)
        case (is Leaf) {
            print("Found a leaf: ``node.element``!");
        }
        case (is Branch) {
            printTree(node.left);
            printTree(node.right);
        }
    }

## Enumerated interfaces

Ordinarily, Ceylon won't let us use interface types as `case`s of a `switch`.
If `File`, `Directory`, and `Link` are interfaces, we ordinarily can't write:

<!-- try:
    interface File {}
    interface Directory {}
    interface Link {}
    class SymLink() satisfies Link {}

    File|Directory|Link resource = SymLink();
    switch (resource) 
    case (is File) { }
    case (is Directory) { } //compile error: cases are not disjoint
    case (is Link) { }  //compile error: cases are not disjoint
-->
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

<!-- try:
    interface Resource of File | Directory | Link { }

    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}
-->
    interface Resource of File | Directory | Link { ... }

Then the following declaration is an error:

<!-- try-pre:
    interface Resource of File | Directory | Link { }
    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}

-->
    class DirectoryFile() 
            satisfies File & Directory {} //compile error: File and Directory are disjoint types

Now this is accepted by the compiler:

<!-- try:
    interface Resource of File | Directory | Link { }
    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}
    class SymLink() satisfies Link {}

    Resource resource = SymLink();
    switch (resource) 
    case (is File) { print("File"); }
    case (is Directory) { print("Directory"); }
    case (is Link) { print("Link"); }
-->
    Resource resource = ... ;
    switch (resource) 
    case (is File) { ... }
    case (is Directory) { ... }
    case (is Link) { ... }

The compiler is pretty clever when it comes to reasoning about disjointness
and exhaustion. For example, this is acceptable:

<!-- try:
    interface Resource of File | Directory | Link { }
    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}
    class SymLink() satisfies Link {}

    Resource resource = SymLink();
    switch (resource) 
    case (is File|Directory) { print("File or Directory"); }
    case (is Link) { print("Link"); }
-->
    Resource resource = ... ;
    switch (resource) 
    case (is File|Directory) { ... }
    case (is Link) { ... }

As is this:

<!-- try:
    interface Resource of File | Directory | Link { }
    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}
    class SymLink() satisfies Link {}

    Resource? resource = SymLink();
    switch (resource) 
    case (is File|Directory) { print("File or Directory"); }
    case (is Link) { print("Link"); }
    case (null) { print("null"); }
-->
    Resource? resource = ... ;
    switch (resource) 
    case (is File|Directory) { ... }
    case (is Link) { ... }
    case (null) { ... }

As is this, still assuming the above declaration of `Resource`:

<!-- try:
    interface Resource of File | Directory | Link { }
    interface File satisfies Resource {}
    interface Directory satisfies Resource {}
    interface Link satisfies Resource {}
    class SymLink() satisfies Link {}

    File|Link resource = SymLink();
    switch (resource) 
    case (is File) { print("File"); }
    case (is Link) { print("Link"); }
-->
    File|Link resource = ... ;
    switch (resource) 
    case (is File) { ... }
    case (is Link) { ... }

If you're interested in knowing more about how this works, 
[read this](/blog/2012/01/25/enumerated-types/#how_the_compiler_reasons_about_enumerated_types).


## Enumerated instances

Ceylon doesn't have anything exactly like Java's `enum` declaration. But we 
can emulate the effect using the `of` clause.

<!-- id:Suit -->
    abstract class Suit(String name)
            of hearts | diamonds | clubs | spades {}
    
    object hearts extends Suit("hearts") {}
    object diamonds extends Suit("diamonds") {}
    object clubs extends Suit("clubs") {}
    object spades extends Suit("spades") {}

We're allowed to use the names of `object` declarations in the `of` clause.

Now we can exhaust all cases of `Suit` in a `switch`:

<!-- try: -->
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

We can handle multiple cases in a single `case`:

<!-- try: -->
    void printColor(Suit suit) {
        switch (suit)
        case (hearts|diamonds) { print("Red"); }
        case (clubs|spades) { print("Black"); }
    }

For a couple of more practical examples, check out the definitions of 
[`Boolean`](#{site.urls.apidoc_1_2}/Boolean.type.html) and 
[`Comparison`](#{site.urls.apidoc_1_2}/Comparison.type.html) in the 
language module.


## More about disjointness

As we've seen, _disjointness_ is a useful property for two types to have, since
it lets us use them as cases of the same `switch` statement. Therefore, the
compiler expends some effort to determine if two types are disjoint. For 
example:

- if `X` and `Y` are classes, `X` is not a subclass of `Y`, and `Y` is not a 
  subclass of `X`, then `X` and `Y` are disjoint,
- if `X` is a `final` class and `Y` is an interface not satisfied by `X`, then 
  `X` and `Y` are disjoint, and
- two instantiations of a generic type may be disjoint, for example, 
  `MutableList<String>` and `MutableList<Integer>`.

(There's much more information about disjointness in [the spec](../../spec).)

When the compiler encounters an intersection type involving disjoint types,
for example, `String&Integer`, it automatically simplifies this type to the
bottom type `Nothing`.


## Coverage and the `of` operator

The `of` clause of an enumerated type lets us define a relationship called
_coverage_ between types. Coverage is related to, but not the same as, 
subtyping. For example:

- `X|Y` covers `X` for any type `Y`, and
- if `T` has the enumerated cases `X`, `Y`, and `Z`, then `X|Y|Z` covers `T`.

If the union of the types of all cases of a `switch` covers the `switch`ed
expression type, then we know that the whole `switch` statement is exhaustive.

(Again, there's much more information about coverage in [the spec](../../spec).)

If a type covers another type, then we can use the `of` operator to safely 
narrow from the second type to the first type, even if the second type is not
strictly-speaking a subtype of the first type, according to Ceylon's type system.
Going back to an earlier example, we could write:

<!-- try: -->
    Resource resource = ... ;
    File|Directory|Link fileOrDirOrLink = resource of File|Directory|Link;

This is more often useful for self types.

<!-- try: -->
    Comparable<Type> comparable = .... ;
    Type type = comparable of Type;


## There's more...

You can read a bit more about enumerated types in Ceylon in 
[this blog post](/blog/2012/01/25/enumerated-types).

Next we'll explore Ceylon's [generic type system](../generics) in more depth. 
