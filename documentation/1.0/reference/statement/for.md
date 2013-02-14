---
layout: reference
title: '`for` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The `for` statement supports iteration.

## Usage 

The general form of the `for` statement is

<!-- check:none -->
    for ( /* variable declaration and expression */ ) {
        /* for block */
    } else {
        /* code executed if iteration doesn't exit early */
    }
    /* code after for statement */

The `else` clause is optional.


## Description

### Execution

A `for` statement works with `Iterable`s. Before the `for` block an iteration 
variable (assignable to `Iterator<T>`, for some `T`) is declared, and an
`Iterable`-typed expression is given. The 
`for` block is executed with the declared variable taking the value of successive 
items returned from the `Iterator` obtained from the `Iterable`. Execution 
proceeds until the `Iterator` is exhausted or an ['early exit'](#early_exit) occurs.


### `break` and `continue`

Within the `for` block the [`break` directive](../break/) can be used to exit 
the block early without iterating over the remaining items in the `Iterator`. This is 
one form of ['early exit'](#early_exit).

The [`continue` directive](../continue) can be used to skip execution of
the remainder of the block and proceed with the next item from the `Iterator`.

### Early Exit

If the `for` block ends with a [`return`](../return/), 
[`break`](../break/), or [`throw`](../throw/) directive the 
iteration is said to have *exited early*. In the `return` and `throw` cases
control is returned directly to the caller; in the `break` case execution 
proceeds with the code following the `else` clause. Therefore, in all cases of 
early exit the `else` block is not executed.

The `else` clause is ideally suited to situations where the `for` statement 
is being used to find something in a sequence or list, and the sought item has 
not been found:

<!-- cat: class Person() {shared Integer age = 0;} -->
<!-- cat: void m(Person[] people) { -->
    variable Boolean minors;
    for (p in people) {
        if (p.age<18) {
            minors := true;
            break;
        }
    }
    else {
        minors := false;
    }
<!-- cat: } -->

### Unsupported features

Ceylon not support the C-style `for` statement, with an initialising statement,
iteration statement and termination condition. 
This isn't a problem in practice; see 
[what the Tour has to say](#{page.doc_root}/tour/sequences#iterating_sequences).

## See also

* The [`break` statement](../break)
* The [`continue` statement](../continue)
* The [`while` statement](../while)
* [`Iterable`](#{page.doc_root}/api/ceylon/language/interface_Iterable.html)
* The [`for` statement](#{page.doc_root}/tour/attributes-control-structures#control_structures) 
  and [Iterating Sequences](#{page.doc_root}/tour/sequences#iterating_sequences)
  in the Tour of Ceylon
* The [`for` statement](#{page.doc_root}/#{site.urls.spec_relative}#forelse) 
  in the language specification
