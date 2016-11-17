---
layout: reference13
title_md: '`if` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `if` statement allows a block of code to be executed conditionally.

## Usage 

The general form of the `if` statement is:

<!-- check:none -->
<!-- try: -->
    if ( /* some conditions */ ) {
        /* code executed if some conditions are true */
    } else if (/* other conditions */ ) {
        /* code executed if other conditions are true */
    } else {
        /* code executed otherwise */
    }
    /* code after if statement */

There can be zero or more `else if` clauses, and the `else` clause is optional.

## Description

Ceylon's `if` statement should already be familiar to anyone who has programmed 
using a C-like language.

### Execution

The `if` condition is evaluated first, and if it is satisfied then 
execution proceeds with the following block of code, and after that 
with the code after the `if` statement. 

Otherwise, if the `if` condition is not satisfied, then the first 
`else if` condition, if any, is evaluated and if that condition 
satisfied then its associated block is executed, followed by the code 
after the `if` statement. If the `else if` condition is not satisfied, 
then subsequent `else if` clauses, if any, are treated in the same way.

Finally, if none of the conditions are satisfied, the `else` block, if
any, is executed, followed by the code after the `if` statement.

### Conditions

The conditions in an `if` statement occur in
[condition lists](../conditions#condition_lists).

Any expression of type [`Boolean`](#{site.urls.apidoc_1_3}/Boolean.type.html) 
may occur in the condition list of an `if` statement. The `if` 
statement also supports the use of typing conditions:

* [`is` conditions](../conditions/#is_conditions), 
* [`exists` conditions](../conditions/#exists_conditions), and
* [`nonempty` conditions](../conditions/#nonempty_conditions).

These conditions narrow the type of a reference within the associated block, 
and in later conditions in the condition list and the rest of the 
control structure.

<!-- try: -->
    void printSqrt(Object x) {
        if (is Float x, x >= 0.0) {
            print(x^0.5);
        }
    }

By not separating the operation that checks the safety of the typecast from 
the operation used to actually perform the typecast Ceylon eliminates the 
possibility that the programmer might forget to do the test before attempting 
the typecast, and eliminates repetition of the narrower type.

Flow typing can also affect the rest of the control structure:

    void go(Car|Bicycle vehicle) {
        if (is Car vehicle) {
            // vehicle has type Car
            vehicle.drive();
        } else {
            // vehicle has type Bicycle
            vehicle.ride();
        }
    }

### Destructuring in `exists` and `nonempty` conditions

Since ceylon 1.3, `exists` and `nonempty` conditions support destructuring. For example:

    if (nonempty [name, *rest] = process.arguments) {
        print("Hello ``name``!");
    }

## See also

* The [`switch` statement](../switch) is an alternative control structure
  better suited to handling exhaustive lists of cases
* The [`assert` statement](../assert) is an alternative control structure
  better suited to expressing invariants.
* [`if` in the language specification](#{site.urls.spec_current}#ifelse)
* [`if (is ...)` in the language specification](#{site.urls.spec_current}#assignabilityexistencenonemptinessconditions)
* [`if (exists ...)` in the language specification](#{site.urls.spec_current}#assignabilityexistencenonemptinessconditions)
* [`if (nonempty ...)` in the language specification](#{site.urls.spec_current}#assignabilityexistencenonemptinessconditions)
* [`if` expressions](../../expression/if/)
