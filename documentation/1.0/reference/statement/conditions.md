---
layout: reference
title: 'Conditions and condition lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 4
doc_root: ../../..
---

# #{page.title}

## Usage

Special form conditions and condition lists are supported 
by the 
[`if`](../if), 
[`while`](../while), 
[`assert`](../assert) statements and 
[`if` comprehensions](../../epxression/comprehension)

**Note**: This page is **not** describing the 
[`is`](../../operator/is), 
[`exists`](../../operator/exists) and 
[`nonempty`](../../operator/nonempty)
 *operators*.

## Description

We shall use `if` for the purposes of illustration, but the same constructs 
apply to `while` and `assert` statements.

### `if (is ...)`

`if (is X x)` is a condition that tests whether a value or variable `x` is 
assignable to the type `X`. Within the associated block `x` will have the 
type `X`.

In other words, `if (is ...)` is similar Java's `instanceof` operator
with a suitable typecast occuring automatically within the block. 

Here's an example

    Integer plusOneIfInteger(Object x) {
        if (is Integer x) {
            // x of type Integer here
            return = x+1;
        }
        return 0;
    } 

It is also possible to introduce a new local attribute in the condition, in 
which case it is the new local attribute that has the narrowed type:

    Integer plusOneIfInteger(Object x) {
        if (is Integer y=x) {
            // x still of type Object here
            return y+1;
        }
        return 0;
    } 

### `if (exists ...)`

`if (exists x)` is equivalent to `if (is X x)` where `x` is an expression 
of `type X?`. Within the associated block `x` will have the type `X`.

In other words `if (exists ...)` is similar to a `if (x != null)` null check in 
Java.

Here's an example

    Integer plusOneIfExists(Integer? x) {
        if (exists x) {
            // x of type Integer here
            return x+1;
        }
        return 0;
    } 

It is also possible to introduce a new local attribute in the condition, in 
which case it is the new local attribute that has the narrowed type:

    Integer plusOneIfExists(Integer? x) {
        if (exists y=x) {
            // x still of type Integer? here
            return y+1;
        }
        return 0;
    } 

### `if (nonempty ...)`

`if (nonempty x)` is equivalent to `is Some<E> x` where x is an expression 
whose type is an invariant subtype of `FixedSized<E>`.  Within 
the associated block `x` will have the type `E`

Here's an example

    Integer firstPlusOne(Integer[] x) {
        if (nonempty x) {
            // x of type Integer[] here
            return x.first+1;
        }
        return 0;
    } 

It is also possible to introduce a new local attribute in the condition, in 
which case it is the new local attribute that has the narrowed type:

    Integer firstPlusOne(Integer[] x) {
        if (nonempty y=x) {
            // x still of type Integer[] here
            return y.first+1;
        }
        return 0;
    } 

### `if (satisfies ...)`

<!-- m5 -->

`if (satisfies X Y)` is a condition that tests whether the type `Y` is a 
subtype of the type `X`. within the associated block `Y` will be treated 
as a subtype of `X`.

### Condition lists

<!-- m4 -->

Ceylon supports having multiple conditions (called a *condition list*) 
in `if`, `while`, `assert` statements and in `if` comprehensions. 

A condition list evaluates as true when all conditions in the list evaluate as 
true. The difference between a 
condition list and a single `Boolean` condition constructed using the 
[`&&` operator](../../operator/and/)
is that any special form conditions in the list take effect for conditions 
later in the list, allowing you to write:

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
* [`if` comprehensions](../../epxression/comprehension)
