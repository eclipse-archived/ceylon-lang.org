---
layout: reference12
title_md: '`for` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `for` statement iterates the elements produced by an iterable object.

## Usage 

The general form of the `for` statement is:

<!-- check:none -->
<!-- try: -->
    for ( /* variable declaration */ in /* iterable expression */ ) {
        /* for block */
    }
    else {
        /* code executed if iteration doesn't exit early */
    }

The `else` clause is optional.

## Description

### Execution

A `for` statement accepts an expression of type 
[`Iterable`](#{site.urls.apidoc_1_2}/Iterable.type.html), which is evaluated
to produce an `Iterable` object. 

The `for` block is executed repeatedly, with the iteration variable taking the 
value of each successive item produced by an `Iterator` obtained from the iterable 
object. Iteration of the loop terminated when the `Iterator` produces `finished` or an 
[early exit](#early_exit) occurs.

If an early exit does not terminate iteration of the loop, the `else` block is
executed. 

### `break` and `continue`

Within the `for` block the [`break` directive](../break/) can be used to exit 
the block early without iterating over the remaining items in the `Iterator`. 
This is one form of [early exit](#early_exit).

The [`continue` directive](../continue) can be used to skip execution of the 
remainder of the block and proceed with the next item produced by the `Iterator`.

### Early Exit

If the `for` block ends with a [`return`](../return/), [`break`](../break/), 
or [`throw`](../throw/) directive, the iteration is said to have *exited early*. 
In the case of `return` or `throw`, control is returned directly to the caller. 
In the case of a `break` statement, execution continues with the statement
immediately following the `for` statement. Therefore, the `else` block is never 
executed in any case of early exit.

The `else` clause is ideally suited to situations where the `for` statement 
is being used to find something in a sequence or list, and the sought item has 
not been found:

<!-- try: -->
    Boolean definitelyInitialize(Person[] people) {
        Boolean minors;
        for (p in people) {
            if (p.age<18) {
                minors = true;
                break;
            }
        }
        else {
            minors = false;
        }
        return minors;
    }

### Iterating entries and tuples

The `for` statement supports [destructuring](../destructure) for iterating instances
of `Entry` and `Tuple`:

<!-- try: -->
    for (key->item in map) {
        //...
    }

    for ([x, y, z] in points) {
        //...
    }
    
    for ([x, y, z]->label in labelledPoints) {
        //...
    }

### Notes

* Ceylon does not support the C-style `for` statement, with an initialising statement,
  iteration statement and termination condition. This isn't a problem in practice; 
  see [what the Tour has to say](#{page.doc_root}/tour/sequences#iterating_sequences).

## See also

* The [`break` statement](../break)
* The [`continue` statement](../continue)
* The [`while` statement](../while)
* [`Iterable`](#{site.urls.apidoc_1_2}/Iterable.type.html)
* The [`for` statement](#{page.doc_root}/tour/attributes-control-structures#control_structures) 
  and [Iterating Sequences](#{page.doc_root}/tour/sequences#iterating_sequences)
  in the Tour of Ceylon
* The [`for` statement](#{site.urls.spec_current}#forelse) in the Ceylon language 
  specification
