---
layout: reference
title: 'Conditions and condition lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage

Special form conditions and condition lists are supported 
by the 
[`if`](../if), 
[`while`](../while), 
[`assert`](../assert) statements and 
[`if` comprehensions](../../expression/comprehension)

**Note**: This page is **not** describing the 
[`is`](../../operator/is), 
[`exists`](../../operator/exists) and 
[`nonempty`](../../operator/nonempty)
 *operators*.

## Description

We shall use `if` for the purposes of illustration, but the same constructs 
apply to `while` and `assert` statements.

### `if (is ...)`

`if (is X x)` is a condition that tests whether a value `x` is 
assignable to the type `X`. Within the associated block `x` will have the 
type `X`.

In other words, `if (is ...)` is similar Java's `instanceof` operator
with a suitable typecast occurring automatically within the block. 
Here's a simple example

<!-- try: -->
    Integer plusOneIfInteger(Object x) {
        if (is Integer x) {
            // x of type Integer here
            return = x+1;
        }
        return 0;
    } 

It is also possible to introduce a new local value in the condition, in 
which case it is the new local value that has the narrowed type:

<!-- try: -->
    Integer plusOneIfInteger(Object x) {
        if (is Integer y=x) {
            // x still of type Object here
            // but y is Integer
            return y+1;
        }
        return 0;
    } 

When using `if (...)` with a `variable` value you are *required*
to use this form which creates a new local value. On a platform that 
supports concurrency this protects you from another thread changing 
the value while the block protected by the `if` is being exeucted 
(and thus potentially violating the semantics of the `if` statement).

`if (is ...)` is more sophistocated than a Java `instanceof` though, 
because it inderstand parameterized types: You can say 
`if (is List<Integer> list)` to distinguish a `List<Integer>` from a 
`List<String>`.

**Note**: Do not confuse the `is` *condition* described here and which takes 
the form `is Type t` with the [`is` *operator*](../../operator/is) which 
takes form `t is Type`.


### `if (exists ...)`

`if (exists x)` is equivalent to `if (is X x)` where `x` is an expression 
of `type X?`. Within the associated block `x` will have the type `X`.

In other words `if (exists ...)` is similar to a `if (x != null)` null check in 
Java.

Here's an example

<!-- try: -->
    Integer plusOneIfExists(Integer? x) {
        if (exists x) {
            // x of type Integer here
            return x+1;
        }
        return 0;
    } 

As with `if (is ...)`, it is also possible to introduce a new local 
value in the condition, in  which case it is the new local 
value that has the narrowed type:

<!-- try: -->
    Integer plusOneIfExists(Integer? x) {
        if (exists y=x) {
            // x still of type Integer? here
            return y+1;
        }
        return 0;
    } 

**Note**: Do not confuse the `exists` *condition* described here 
and which takes the form `exists t` with the 
[`exists` *operator*](../../operator/exists) which 
takes form `t exists`.

### `if (nonempty ...)`

`if (nonempty x)` is equivalent to whether the subtype of `Anything[]?` when 
intersected with `[]`  is not `Nothing`, and when intersected with 
`[Nothing+]` is not `Nothing`. Within 
the associated block `x` will have the type `E`

Here's an example

<!-- try: -->
    Integer firstPlusOne(Integer[] x) {
        if (nonempty x) {
            // x of type Integer[] here
            return x.first+1;
        }
        return 0;
    } 

As with `if (is ...)`, it is also possible to introduce a new local 
value in the condition, in which case it is the new local value
that has the narrowed type:

<!-- try: -->
    Integer firstPlusOne(Integer[] x) {
        if (nonempty y=x) {
            // x still of type Integer[] here
            return y.first+1;
        }
        return 0;
    } 

**Note**: Do not confuse the `nonempty` *condition* described here 
and which takes the form `nonempty t` with the 
[`nonempty` *operator*](../../operator/nonempty) which 
takes form `t nonempty`.

### `if (satisfies ...)`

<!-- m-later -->

`if (satisfies X Y)` is a condition that tests whether the type `Y` is a 
subtype of the type `X`. within the associated block `Y` will be treated 
as a subtype of `X`.

### Condition lists

Ceylon supports having multiple conditions (called a *condition list*) 
in `if`, `while`, `assert` statements and in `if` comprehensions. 

A condition list evaluates as true when all conditions in the list evaluate as 
true. The difference between a 
condition list and a single `Boolean` condition constructed using the 
[`&&` operator](../../operator/and/)
is that any special form conditions in the list take effect for conditions 
later in the list, allowing you to write:

<!-- try: -->
    Integer m(Object x) {
        if (is Integer x, x < 10) {
            // x is of type Integer here
            return x + 1;
        }
        return 0;
    }

## See also

* [`if` statement](../if), 
* [`while` statement](../while), 
* [`assert` statement](../assert) 
* [`if` comprehensions](../../expression/comprehension)
<!-- TODO 
* [condition lists](#{site.urls.spec_current}#TODO) 
in the Ceylon spec 
-->
