---
layout: reference
title: '`if` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

The `if` statement allows a block of code to be executed conditionally.

## Usage 

The general form of the `if` statement is

<!-- check:none -->
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

The 'if condition' is evaluated first, and if it evaluates as `true` then 
execution proceeds with the followin block of code and after that 
with the code after the `if` statement. 

If the 'if condition' evaluated false, then the first `else if` condition 
(if any) is evaluated and if that condition is true then it's associated 
block is executed, followed by the 
code after the `if` statement. If the 'else if condition' evaluated as 
`false` then subsequent `else if` clauses (if any) treated in the same way.

Finally, if none of the conditions evaluated as `true` the execution proceeds 
with the `else` block, followed by the code after the `if` statement.

### `Boolean` conditions

Any `Boolean` expression can be used as a condition in an `if` statement.

### 'Special' conditions

The `if` statement also supports the use of certain special form conditions:

* [`if (is ...)`](../conditions/#if_is_), 
* [`if (exists ...)`](../conditions/#if_exists_), 
* [`if (nonempty ...)`](../conditions/#if_nonempty_), 
* [`if (satisfies ...)`](../conditions/#if_satisfies_).

these narrow the type of a reference within the associated block.

By not separating the operation that checks the safety of the typecast from 
the operation used to actually perform the typecast Ceylon eliminates the 
possibility that the programmer might forget to do the test before attempting 
the typecast.

### Condition lists

The condition in an `if` statement can also be a
[condition list](../conditions#condition_lists).

The difference between a 
condition list and a single `Boolean` condition constructed using the 
[`&&` operator](../../operator/and/)
is that the typecasting of conditions in the list take effect for conditions 
later in the list, allowing you to write:

    void m(Object x) {
        if (is Integer x, x < 10) {
            // ...
        }
    }


## See also

* The [`switch` statement](../switch) is an alternative control structure
  better suited to handling exhaustive lists of cases
* The [`assert` statement](../assert) is an alternative control structure
  better suited to expressing invariants.
* [`if` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#ifelse)
* [`if (is ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (exists ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (nonempty ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (satisfies ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#subtypeconditions)

