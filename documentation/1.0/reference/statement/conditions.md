---
layout: reference
title_md: 'Conditions and condition lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

Ceylon allows one or more _conditions_, which together form a _condition list_, 
in the `if`, `while`, and `assert` statements and in `if` comprehension clauses. 

**Note**: This page is *not* describing the [`is`](../../operator/is), 
[`exists`](../../operator/exists), and [`nonempty`](../../operator/nonempty)
*operators*, which are considered a part of the expression grammar.

## Usage

A condition list may occur in an [`if`](../if), [`while`](../while), or 
[`assert`](../assert) statements, or in an `if` clause of a
[comprehension](../../expression/comprehension).

## Description

A condition list is satisfied if and only if every condition in the list is 
satisfied. The difference between a comma-separated condition list and a single 
`Boolean` condition constructed using the [`&&` operator](../../operator/and/) 
is that a condition list may narrow the type of a reference, or introduce a new 
reference.

<!-- try: -->
    Integer m(Object x) {
        if (is Integer x, x < 10) {
            // x is of type Integer here
            return x + 1;
        }
        return 0;
    }

**Note:** In the following discussion we will use `if` in the code examples. 
Keep in mind that condition lists may also occur in a `while` or `assert`
statement.

### Boolean conditions

A _boolean condition_ is an expression of type `Boolean`. It is satisfied
if the expression evaluates to `true`.

### `is` conditions

A condition of form `is Y x` is satisfied if the reference `x` evaluates 
to an instance of the type `Y`. Within the associated block, `x` will have 
the type `X&Y`, where `X` is the previous type of `x`.

In other words, `if (is Y x)` similar to Java's `if (x instanceof Y)`, 
immediately followed by a typecast, `(Y) x`.
 
<!-- try: -->
    Integer plusOneIfInteger(Object x) {
        if (is Integer x) {
            // x is of type Integer here
            return = x+1;
        }
        return 0;
    } 

It's even possible to introduce a new local reference in the condition, 
in which case it is the new local reference which has the narrowed type:

<!-- try: -->
    Integer plusOneIfInteger(Object x) {
        if (is Integer i=x) {
            // x still of type Object here
            // but i is an Integer
            return i+1;
        }
        return 0;
    }

For a `variable` reference or getter you are *required* to use this form. 
On a platform that supports concurrency this protects you from another 
thread changing the value while the block protected by the `if` is being 
executed (and potentially violating the guarantees of the type system).

It is acceptable to specify a generic type in an `is` condition, for
example, `if (is List<Integer> list)` to distinguish a `List<Integer>` 
from a `List<String>`.

**Note**: Do not confuse the `is` *condition* of form `is Type t` with 
an [`is` *operator*](../../operator/is) of form `t is Type`.

### `exists` conditions

A condition of form `exists x` means `is Object x`, and is satisfied 
if the reference `x` refers to a non-`null` value. Within the associated
block, `x` will have the non-optional type `X&Object`, where `X` is the 
previous type of `x`.

In other words, `if (exists x)` is similar to Java's `if (x != null)`.

<!-- try: -->
    Integer plusOneIfExists(Integer? x) {
        if (exists x) {
            // x is of type Integer here
            return x+1;
        }
        return 0;
    } 

It's possible to introduce a new local reference in the condition, in
which case it is the new local reference that has the narrowed type:

<!-- try: -->
    Integer plusOneIfExists(Integer? x) {
        if (exists i=x) {
            // x still of type Integer? here
            return i+1;
        }
        return 0;
    } 

**Note**: Do not confuse the `exists` *condition* of form `exists t` 
with an [`exists` *operator*](../../operator/exists) of form `t exists`.

### `nonempty` conditions

A condition of form `nonempty xs` means `is [X+] xs`, where `X` is the 
element type of the sequence reference `x`, and is satisfied if the `x` 
refers to a nonempty sequence. Within the associated block, `x` will 
have the nonempty type `[X+]``.

<!-- try: -->
    Integer firstPlusOne(Integer[] xs) {
        if (nonempty xs) {
            // xs of type [Integer+] here
            return xs.first+1;
        }
        return 0;
    } 

It's possible to introduce a new local reference in the condition, in which 
case it is the new local reference which has the narrowed type:

<!-- try: -->
    Integer firstPlusOne(Integer[] xs) {
        if (nonempty ys=xs) {
            // xs still of type Integer[] here
            return ys.first+1;
        }
        return 0;
    } 

**Note**: Do not confuse the `nonempty` *condition* of form `nonempty xs` 
with a [`nonempty` *operator*](../../operator/nonempty) of form `xs nonempty`.

## See also

* [`if` statement](../if), 
* [`while` statement](../while), 
* [`assert` statement](../assert) 
* [comprehensions](/documentation/current/tour/comprehensions)
* [Control structure conditions](#{site.urls.spec_current}#controlstructureconditions) 
  in the Ceylon language spec 
