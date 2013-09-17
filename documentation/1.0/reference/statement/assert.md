---
layout: reference
title: '`assert` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `assert` statement throws an exception if a condition is not 
`true`, and can narrow the type of attributes in the statements following it.

## Usage 

The general form of the `assert` statement is

<!-- check:none -->
    
    assert ( /* some conditions */ );


## Description

### Execution

The condition (or conditions) in the assert statement are evaluated. If they 
evaluate as `true` then execution proceeds with the statement following the 
`assert`. Otherwise an `AssertionException` is thrown.

### Purpose

`assert` is usually used to make assertions about a program which 
the programmer *knows* are true, but which cannot be proved 
to be true within the type system. 

Here's an example using the `parseInteger()` method from `ceylon.language` 
which returns `Integer?` so as to force you to handle the possibility that 
the argument was not `String` representing a number:

    value num = parseInteger("1");
    // before the assert statement num is of type Integer?
    assert (exists num);
    // after the assert statement num is of type Integer
    value plusOne = num + 1;
    
In thise case `parseInteger()` is being called with a `String` *literal* which 
we *know* is a valid number. The type checker cannot know this, however, 
because it can only reason about types, not about what the 
`parseInteger()` method does for a particular input. 

### `Boolean` conditions

Any `Boolean` expression can be used as a condition in an `assert` statement.

### 'Special' conditions

The `assert` statement also supports the use of certain special form conditions:

* [`assert (is ...)`](../conditions/#if_is_), 
* [`assert (exists ...)`](../conditions/#if_exists_), 
* [`assert (nonempty ...)`](../conditions/#if_nonempty_), 
* [`assert (satisfies ...)`](../conditions/#if_satisfies_).

these narrow the type of a reference in the statements following the `assert`.


### Condition lists

The condition in an `assert` statement can also be a
[condition list](../conditions#condition_lists).

The difference between a 
condition list and a single `Boolean` condition constructed using the 
[`&&` operator](../../operator/and/)
is that the typecasting of conditions in the list take effect for conditions 
later in the list, allowing you to write:

    void m(Object x) {
        assert (is Integer x, x < 10);
    }
    
### Implementation notes

* Unlike the `assert` statement in the Java programming language, `assert` in 
  Ceylon cannot be disabled at runtime: The conditions are always evaluated. 

## See also

* The [`if` statement](../if) statement and the [`throw` statement](../throw)
  statement can be used together to achieve similar effects.
<!-- TODO 
* [`assert` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#TODO)
-->


