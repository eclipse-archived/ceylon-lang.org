---
title: Generics and enumerated types
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

[previous post]: /blog/2012/01/25/enumerated-types/

In the [previous post][] I discussed Ceylon's support for enumerated types. Looking back over the post, I notice that I forgot to mention anything about generics! Let's remedy that glaring omission!

## Parameterized enumerated types

An enumerated type may be parameterized:

    interface Container<Item>
        of None<Item> | One<Item> | Many<Item> { ... }

Ceylon currently requires that each case of the enumerated type completely "covers" all possible arguments to the type parameter of the enumerated type itself. So we could not write:

    //bad!
    interface One<Item> 
        satisfies Container<Item>
        given Item satisfies Object { ... }

By adding a new constraint on `Item` that is not present in `Container`, we've created a situation where for some values of `Item`, `Container<Item>` is well-defined, but `One<Item>` is an illegal type. This is currently considered an error.

One thing we _are_ allowed to write, however, is the following:

    interface Container<out Item>
        of None | One<Item> | Many<Item> { ... }

    interface None 
        satisfies Container<Bottom> { ... }

Since `Container<Bottom>` is a subtype of `Container<Item>` for any value of `Item`, this is considered well-typed.

## Removing this restriction

As you've probably guessed, this restriction is an inconvenient one. There are some _very_ useful enumerated types where the list of cases of the enumeration depend upon the value of the type argument. It's so useful that there is a term for this construct in the literature: a _generalized algebraic type_, or GADT.

In the language design FAQ, I already wrote up a mini-explanation of [GADT support][GADT] with an example, so I won't repeat myself here. A future version of Ceylon will likely support GADTs.

[GADT]: http://ceylon-lang.org/documentation/faq/language-design/#generalized_algebraic_types

## Type parameters with enumerated constraints

In the previous post, I started with an example where a union type is used to emulate overloading. Alert readers might have noticed that the only reason this worked was that the "overloaded" type only appeared once in the method signature. We had something like this:

    void add(Integer|Float x) { ... }

What if the overloaded type appears more than once? Well, to handle this sort of thing, we would need to introduce a type parameter:

    Num increment<Num>(Num x) 
            given Num of Integer|Float {
        ...
    }

The syntax `given Num of Integer|Float` defines a type parameter with an enumerated  type constraint. The unknown type must be one of a list of types.

This looks like a very nice feature, but the truth is that Ceylon is still missing one extra thing in order for it to be truly useful. The problem is that the following code is not well-typed:

    Num increment<Num>(Num x) 
            given Num of Integer|Float {
        switch (x)
        case (is Integer) { return x+1; } //error: Integer not assignable to Num
        case (is Float) { return x+1.0; } //error: Float not assignable to Num
    }

The `if (is ...)` and `case (is ...)` constructs let us narrow the type of a single value. What we need here is the ability to narrow a type parameter itself, "pinning" the value of the type parameter within the body of the method, letting us write:

    Num increment<Num>(Num x) 
            given Num of Integer|Float {
        switch (Num)
        case (Integer) { return x+1; }
        case (Float) { return x+1.0; }
    }

Unfortunately, this functionality depends upon having fully reified type parameters, so it will have to wait until M5, later this year.

I think this is ultimately quite a powerful feature. It looks like overloading when we look at simple examples like this parameterized method, but it's actually a bit more than that. Notice that a whole _type_ could have a parameter with an enumerated type constraint! With upper bound type constraints, generics let us abstract a parameterized declaration over all types which share a common supertype. Enumerated type constraints help us abstract over types which _don't_ have a common ancestor, and which weren't designed to be treated polymorphically.
