---
title: Enumerated types in Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

We're just wrapping up the implementation of Ceylon's enumerated types (_algebraic types_, if you prefer that term). This feature is turning out significantly nicer than what was originally defined in the spec.

## Unions and `switch`

The simplest kind of enumerated type is simply a union of classes. For example, the type `Integer|Float` is a very simple enumerated type. Since `Float` and `Integer` are distinct classes and neither inherits from the other, the compiler reasons that the types are _disjoint_, meaning they have no common instances. Therefore, it lets us write the following:

    void add(Integer|Float x) {
        switch (x)
        case (is Integer x) { integers.add(x); }
        case (is Float x) { floats.add(x); }
    }

Notice that inside the block that follows a `case`, the type of the `switch`ed variable is narrowed to the `case` type. We know that `x` is an `Integer` in the first `case`, and a `Float` in the second, so the compiler lets us make use of this additional information.

There are two basic things to appreciate about Ceylon's `switch` construct:

1. The `case`s must be disjoint. The behavior never depends upon the order in which the `case`s appear.
2. If the `case`s don't completely cover all possible values of the `switch` expression type, we need to include an `else` clause.

A `switch` statement which covers all possible values of the switched type is said to have an _exhaustive_ list of `case`s.

The purpose of the required `else` clause is to syntactically distinguish `switch` statements which don't need to be fixed and recompiled when a new type is added.

    void add(Integer|Float|String x) {
        switch (x)
        case (is Integer x) { integers.add(x); }
        case (is Float x) { floats.add(x); }
        else {}
    }

## Enumerated classes

We can extend this idea for an interface or abstract class. Ceylon lets us declare that an abstract class or interface is _equivalent_ to a union using the `of` clause. For example, the root class of the type hierarchy, `Void`, is declared like this:

    shared abstract class Void() of Nothing | Object {}

This says that the class `Void` has exactly the same instances as the union type `Nothing|Object`. So when we encounter a value of type `Void`, we know it must either be an instance of `Object`, or an instance of `Nothing`. We can write:

    void printVoid(Void v) {
        switch (v)
        case (is Nothing) { print("nothing"); }
        case (is Object) { print(v); }
    }

The compiler won't let us define a third subclass of `Void` that doesn't extend either `Nothing` or `Object`. We call the types mentioned in the `of` clause the _cases_ of an enumerated type.

Since an `object` declaration is also a type, we can even include the names of objects in the `of` clause. For example, this is how the language module expressed the fact that the only instance of `Nothing` is the null value:

    shared abstract class Nothing() of nothing {}
    shared object nothing extends Nothing() {}

More commonly, there will be multiple values, allowing us to recapture the semantics of a Java `enum`, without introducing a special language construct. For example, Ceylon's `Boolean` is an enumerated type with two values:

    shared abstract class Boolean() of true | false {}

    shared object true extends Boolean() {
        shared actual String string { return "true"; }
    }

    shared object false extends Boolean() {
        shared actual String string { return "false"; }
    }

Therefore, we can `switch` on a `Boolean` value:

    void printBoolean(Boolean bool) {
        switch (bool)
        case (true) { print("true"); }
        case (false) { print("false"); }
    }

Note that the classic example of a Java enumerated type works out significantly more verbose in Ceylon:

    shared abstract class Suit() {}
    shared object hearts extends Suit() {} 
    shared object diamonds extends Suit() {} 
    shared object clubs extends Suit() {} 
    shared object spades extends Suit() {} 

I think that's OK. The tradeoff is that enumerated types in Ceylon are simply much more powerful and flexible.

## Enumerated interfaces

Enumerated interfaces are a little more special. Consider:

    interface Association 
        of OneToOne | OneToMany | ManyToOne | ManyToMany { ... }

Interfaces support multiple inheritance, so in general interface types are not disjoint. But when an interface declares an enumerated list of subinterfaces, the compiler enforces that those interfaces be disjoint by rejecting any attempt to define a concrete class or object that is a subtype of more than one of them. This code is not well-typed:

    class BrokenAssociation() 
        satisfies OneToOne & OneToMany {} //error: inherits multiple cases of enumerated type

Note that the types named in the `of` clause don't need to be _direct_ subtypes of the enumerated type. The following code _is_ well-typed:

    interface ToOne satisfies Association {}
    class OneToOne() satisfies ToOne {}
    class ManyToOne() satisfies ToOne {}

The interface `ToOne` is a subtype of the enumerated type `Association` but not of any of its cases. That's acceptable, because `ToOne` is an abstract type that can't be directly instantiated. Of course, every one of its concrete subtypes must be a subtype of one of the enumerated cases of `Association`.

## Handling multiple cases at once

A `case` of a `switch` can handle more than one type at once. For example, `ToOne` could be a `case` type:

    Association assoc = ... ;
    switch (assoc)
    case (is ToOne) { ... }
    else { ... }

Even better, we can form unions of the cases of the enumerated type:

    Association assoc = ... ;
    switch (assoc)
    case (is OneToOne|ManyToOne) { ... }
    case (is OneToMany|ManyToMany) { ... }

For `object` cases, the syntax is slightly different:

    switch (suit)
    case (hearts, diamonds) { return red; }
    case (clubs, spades) { return black; }

## How the compiler reasons about enumerated types

Now let's see something cool. When the compiler encounters an enumerated type in a `switch` statement, it: 

1. first expands the type to a union of its cases. And it does this recursively to any of the cases which are themselves enumerated types, and then
2. to determine if a `switch` statement has an exhaustive list of `case` branches, takes the union of each of the `case` types and determines if it is a supertype of the union type produced in step 1.

Thus, the following `switch` is well-typed:

    void printVoid(Void v) {
        switch (v)
        case (nothing) { print("nothing"); }
        case (is Object) { print(v); }
    }

Likewise, remembering that `Boolean?` means `Nothing|Boolean`, we can write:

    void printBoolean(Boolean? bool) {
        switch (bool)
        case (true) { print("true"); }
        case (false) { print("false"); }
        case (nothing) { print("nothing"); }
    }

But what about disjointness of the `case` types? How is that determined? Well, first of all, the compiler is able to reason that the intersection of two types is empty if they inherit from different cases of an enumerated type. So whenever the compiler encounters a type like `Nothing&Boolean`, it automatically simplifies the type to `Bottom`. 

So the disjointness restriction on `case`s of a `switch` boils down to checking that for each pair of `case`s, the intersection of the `case` types is `Bottom`.
