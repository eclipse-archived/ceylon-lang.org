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
    if ( /* some condition */ ) {
        /* code executed if some condition is true */
    } else if (/* other condition */ ) {
        /* code executed if other condition is true */
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
execution proceeds with the corresponding block of code and after that 
with the code after the `if` statement. 

If the 'if condition' evaluated false, then the first `else if` condition 
(if any) is evaluated and if that condition is true then it's associated 
block is executed, followed by the 
code after the `if` statement. If the 'else if condition' evaluated as 
`false` then subsequent `else if` clauses (if any) treated in the same way.

Finally, if none of the conditions evaluated as `true` the execution proceeds 
with the `else` block, followed by the code after the `if` statement.

### The use of `if` for typecasting

Ceylon doesn't have an independent syntax for typecasting; you have 
to use one of the 'special' `if` constructs: 
`if (is ...)`, `if (exists ...)`, `if (nonempty ...)` or `if (satisfies ...)`. 

By not separating the operation that checks the satefy of the typecast from 
the operation used to actually perform the typecast Ceylon eliminates the 
possibility that the programmer might forget to do the test before attempting 
the typecast.

### `if (is ...)`

`if (is X x)` is a condition that tests whether a value or variable `x` is 
assignable to the type `X`. Within the associated block `x` will have the 
type `X`. 

In other words, `if (is ...)` is similar Java's `instanceof` operator
with a suitable typecast occuring automatically within the block. 

### `if (exists ...)`

`if (exists x)` is equivalent to `if (is X x)` where `x` is an expression 
of `type X?`. Within the associated block `x` will have the type `X`.

In other words `if (exists ...)` is similar to a `if (x != null)` null check in 
Java.

### `if (nonempty ...)`

`if (nonempty x)` is equivalent to `if (is Sequence<X> x)` where `x` is 
an expression of type `X[]?` (that is, an expression of type 
`Nothing|Empty|Sequence<X>`)

### `if (satisfies ...)`

`if (satisfies X Y)` is a condition that tests whether the type `Y` is a 
subtype of the type `X`. within the associated block `Y` will be treated 
as a subtype of `X`.

## See also

* The [`switch` statement] (../switch) is an alternative control structure
  better suited to handling exhaustive lists of cases
* [`if` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#ifelse)
* [`if (is ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (exists ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (nonempty ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#assignabilityexistencenonemptinessconditions)
* [`if (satisfies ...)` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#subtypeconditions)

