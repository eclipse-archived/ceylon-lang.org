---
layout: tour
title: Tour of Ceylon&#58; Types
tab: documentation
author: Gavin King
---

# #{page.title}

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
to `if (exists ... )` and `if (nonempty ... )`, which we met earlier.

<pre class="brush: ceylon">
Object obj = ... ;
if (is Hello obj) {
    obj.say();
}
</pre>

The switch statement can be used in a similar way:

<pre class="brush: ceylon">
Object obj = ... ;
switch(obj)
case (is Hello) {
    obj.say();
}
case (is Person) {
    stream.writeLine(obj.firstName);
}
else {
    stream.writeLine("Some miscellaneous thing");
}
</pre>

These constructs protect us from inadvertantly writing code that would cause a 
`ClassCastException` in Java, just like `if (exists ... )` protects us from 
writing code that would cause a `NullPointerException`.

## More about union types

We've seen a few examples of how ad-hoc union types are used in Ceylon. Let's 
just revisit the notion to make sure we completely understand it. When 
I declare the type of something using a union type `X|Y`, I'm saying that 
only expressions of type `X` and expressions of type `Y` are assignable to it. 
The type `X|Y` is a supertype of both `X` and `Y`. The following code is 
well-typed:

<pre class="brush: ceylon">
void print(String|Natural|Integer val) { ... }
 
print("hello");
print(69);
print(-1);
</pre>

But what operations does a type like `String|Natural|Integer` have? What 
are its supertypes? Well, the answer is pretty intuitive: `T` is a supertype of 
`X|Y` if and only if it is a supertype of both `X` and `Y`. The Ceylon compiler 
determines this automatically. So the following code is also well-typed:

<pre class="brush: ceylon">
Natural|Integer i = ... ;
Number num = i;
String|Natural|Integer val = i;
Object obj = val;
</pre>

However, `num` is not assignable to `val`, since `Number` is not a supertype 
of `String`.

Of course, it's very common to narrow an expression of union type using a 
`switch` statement. Usually, the Ceylon compiler forces us to write an `else` 
clause in a `switch`, to remind us that there might be additional cases 
which we have not handled. But if we exhaust all cases of a union type, 
the compiler will let us leave off the `else` clause.

<pre class="brush: ceylon">
void print(String|Natural|Integer val) {
    switch (val)
    case (is String) { writeLine(val); }
    case (is Natural) { writeLine("Natural: " + val); }
    case (is Integer) { writeLine("Integer: " + val); }
}
</pre>

## Enumerated subtypes

Sometimes it's useful to be able to do the same kind of thing with the 
subtypes of an ordinary type. First, we need to explicitly enumerate the 
subtypes of the type using the `of` clause:

<pre class="brush: ceylon">
abstract class Hello()
        of DefaultHello | PersonalizedHello {
    ...
}
</pre>

(This makes `Hello` into Ceylon's version of what the functional programming 
community calls an "algebraic" data type.)

Now the compiler won't let us declare additional subclasses of `Hello`, and 
so the union type `DefaultHello|PersonalizedHello` is exactly the same type 
as `Hello`. Therefore, we can write `switch` statements without an `else` 
clause:

<pre class="brush: ceylon">
Hello hello = ... ;
switch (hello)
case (is DefaultHello) {
    writeLine("What's your name?");
}
case (is PersonalizedHello) {
    writeLine("Nice to hear from you again!");
}
</pre>

Now, it's usually considered bad practice to write long `switch` statements 
that handle all subtypes of a type. It makes the code non-extensible. 
Adding a new subclass to `Hello` means breaking all the `switch` statements 
that exhaust its subtypes. In object-oriented code, we usually try to 
refactor constructs like this to use an abstract method of the superclass 
that is overridden as appropriate by subclasses.

However, there are a class of problems where this kind of refactoring isn't 
appropriate. In most object-oriented languages, these problems are usually 
solved using the 'visitor' pattern.

## Visitors

Let's consider the following tree visitor implementation:

<pre class="brush: ceylon">
abstract class Node() {
    shared formal void accept(Visitor v);
}
class Leaf(Object val) extends Node() {
    shared Object value = val;
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
</pre>

We can create a method which prints out the tree by implementing the `Visitor` 
interface:

<pre class="brush: ceylon">
void print(Node node) {
    object printVisitor satisfies Visitor {
        shared actual void visitLeaf(Leaf l) {
            writeLine("Found a leaf: " l.value "!");
        }
        shared actual void visitBranch(Branch b) {
            b.leftChild.accept(this);
            b.rightChild.accept(this);
        }
    }
    node.accept(printVisitor);
}
</pre>

Notice that the code of `printVisitor` looks just like a `switch` statement. 
It must explicitly enumerate all subtypes of `Node`. It "breaks" if we add 
a new subtype of `Node` to the `Visitor` interface. This is correct, and is the 
desired behavior. By "break", I mean that the compiler lets us know that 
we have to update our code to handle the new subtype.

In Ceylon, we can achieve the same effect, with less verbosity, by 
enumerating the subtypes of `Node` in its definition, and using a `switch`:

<pre class="brush: ceylon">
abstract class Node() of Leaf | Branch {}
class Leaf(Object val) extends Node() {
    shared Object value = val;
}
class Branch(Node left, Node right) extends Node() {
    shared Node leftChild = left;
    shared Node rightChild = right;
}
</pre>

Our `print()` method is now much simpler, but still has the desired behavior 
of "breaking" when a new subtype of `Node` is added.

<pre class="brush: ceylon">
void print(Node node) {
    switch (node)
    case (is Leaf) {
        writeLine("Found a leaf: " node.value "!");
    }
    case (is Branch) {
        print(node.leftChild);
        print(node.rightChild);
    }
}
</pre>


## Typesafe enumerations

Ceylon doesn't have anything exactly like Java's `enum` declaration. 
But we can emulate the effect using the `of` clause.

<pre class="brush: ceylon">
shared class Suit(String name)
        of hearts | diamonds | clubs | spades
        extends Case(name) {}
         
shared object hearts extends Suit("hearts") {}
shared object diamonds extends Suit("diamonds") {}
shared object clubs extends Suit("clubs") {}
shared object spades extends Suit("spades") {}
</pre>

We're allowed to use the names of `object` declarations in the `of` clause if 
they extend the language module class `Case`.

Now we can exhaust all cases of `Suit` in a `switch`:

<pre class="brush: ceylon">
void print(Suit suit) {
    switch (suit)
    case (hearts) { writeLine("Heartzes"); }
    case (diamonds) { writeLine("Diamondzes"); }
    case (clubs) { writeLine("Clidubs"); }
    case (spades) { writeLine("Spidades"); }
}
</pre>
(Note that these cases are ordinary value cases, not `case (is...)` type cases.)

Yes, this is a bit more verbose than a Java `enum`, but it's also slightly 
more flexible.

For a more practical example, let's see the definition of `Boolean` from the 
language module:

<pre class="brush: ceylon">
shared abstract class Boolean(String name)
        of true | false
        extends Case(name) {}
shared object false extends Boolean("false") {}
shared object true extends Boolean("true") {}
</pre>

And here's how `Comparable` is defined. First, the typesafe 
enumeration `Comparison`:

<pre class="brush: ceylon">
doc "The result of a comparison between two
     Comparable objects."
shared abstract class Comparison(String name)
        of larger | smaller | equal
        extends Case(name) {}
doc "The receiving object is exactly equal
     to the given object."
shared object equal extends Comparison("equal") {}
doc "The receiving object is smaller than
     the given object."
shared object smaller extends Comparison("smaller") {}
doc "The receiving object is larger than
     the given object."
shared object larger extends Comparison("larger") {}
</pre>

Now, the `Comparable` interface itself:

<pre class="brush: ceylon">
shared interface Comparable&lt;in Other>
        satisfies Equality
        given T satisfies Comparable&lt;Other> {
     
    doc "The &lt;=> operator."
    shared formal Comparison compare(Other other);
     
    doc "The > operator."
    shared Boolean largerThan(Other other) {
        return compare(other)==larger;
    }
     
    doc "The &lt; operator."
    shared Boolean smallerThan(Other other) {
        return compare(other)==smaller;
    }
     
    doc "The >= operator."
    shared Boolean asLargeAs(Other other) {
        return compare(other)!=smaller;
    }
     
    doc "The &lt;= operator."
    shared Boolean asSmallAs(Other other) {
        return compare(other)!=larger;
    }
     
}
</pre>


## Type inference

So far, we've always been explicitly specifying the type of every declaration. 
I think this generally makes code, especially example code, much easier to 
read and understand.

However, Ceylon does have the ability to infer the type of a locals or the 
return type of a local method. Just place the keyword `local` in place of the 
type declaration.

<pre class="brush: ceylon">
local hello = DefaultHello();
local operators = { "+", "-", "*", "/" };
local add(Natural x, Natural y) { return x+y; }
</pre>

There are some restrictions applying to this feature. You can't use `local`:

* for declarations annotated `shared`,
* for declarations annotated `formal`,
* when the value is specified later in the block of statements,
* for methods with multiple `return` statements, or
* to declare a parameter.

These restrictions mean that Ceylon's type inference rules are quite simple. 
Type inference is purely "right-to-left" and "top-to-bottom". The type of 
any expression is already known without needing to look to any types declared 
to the left of the `= specifier`, or further down the block of statements.

* The inferred type of a local declared `local` is just the type of the 
  expression assigned to it using `=` or `:=`.
* The inferred type of a method declared local is just the type of the 
  returned expression.

## Type inference for sequence enumeration expressions

What about sequence enumeration expressions like this:

<pre class="brush: ceylon">
local sequence  = { DefaultHello(), "Hello", 12.0 };
</pre>

What type is inferred for sequence? You might answer: "`Sequence<X>` 
where `X` is the common superclass or super-interface of all the 
element types". But that can't be right, since there might be more than one 
common supertype.

The answer is that the inferred type is `Sequence<X>` where `X` is the 
union of all the element expression types. In this case, the type is 
`Sequence<DefaultHello|String|Float>`. Now, this works out nicely, because 
`Sequence<T>` is covariant in `T`. So the following code is well typed:

<pre class="brush: ceylon">
local sequence  = { DefaultHello(), "Hello", 12.0 }; //type Sequence&lt;DefaultHello|String|Float>
Object[] objects = sequence; //type Empty|Sequence&lt;Object>
</pre>

As is the following code:

<pre class="brush: ceylon">
local nums = { 12.0, 1, -3 }; //type Sequence&l;tFloat|Natural|Integer>
Number[] numbers = nums; //type Empty|Sequence&lt;Number>
</pre>

What about sequences that contain `null`? Well, do you remember the type of 
`null` from Part 1 was `Nothing`?

<pre class="brush: ceylon">
local sequence = { null, "Hello", "World" }; //type Sequence&lt;Nothing|String>
String?[] strings = sequence; //type Empty|Sequence&lt;Nothing|String>
String? s = sequence[0]; //type Nothing|Nothing|String which is just Nothing|String
</pre>

It's interesting just how useful union types turn out to be. Even if you only 
very rarely explicitly write code with any explicit union type declaration 
(and that's probably a good idea), they are still there, under the covers, 
helping the compiler solve some hairy, otherwise-ambiguous, typing problems.


## There's more...

A more advanced example of an algebraic datatype is shown here.

Next we'll explore Ceylon's [generic type system](../generics) in more depth. 
