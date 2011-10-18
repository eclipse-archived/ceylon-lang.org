---
layout: reference
title: `switch` statement
tab: documentation
author: Tom Bentley
milestone: Milestone 2
---

# #{page.title}

The `switch` statement executes code conditionally according to an enumerated 
list of cases.

## Usage 

The general form of the `switch` statement is

    switch ( /* switch expression */ ) {
        case ( /* case expression */) {
            /* case block */
        }
        case ( /* case expression */) {
            /* case block */
        }
        else {
            /* else block */
        }
    }
    /* code after switch statement */

There can be one or more `case` clauses, and the `else` clause bay be optional
if the switch is [*exhaustive*](#exhaustivity_and_else).

## Description

### Execution

The `switch` expression is evaluated and then each of the `case`s is considered 
in turn. The first matching `case` has its block executed, and then execution 
continues with the code after the `switch` statement. 
If none of the given `case`s match and an `else` clause is given then the 
`else` block is executed, and then execution 
continues with the code after the `switch` statement. 

### Exhaustivity and `else`

If the `case`s cover every possible case of the `switch` expression then the 
switch is said to be *exhaustive*, and the `else` clause is optional. 
Otherwise and `else` clause is required.

### Polymorphism

The `switch` expression can be of any type. 
If `X` or `X?` is a subtype of the `switch` expression type then a `case` 
expression is either

* Assignable to `Matcher<X>` 
* The expression `null` (if `X?`)
* the special `case(is ...)` form
* the special `case(satisfies ...)` form, if X is a subtype of `Type<T>`.

## See also

* The [`if` statement] (../if) is an alternative control structure for 
  conditional execution
* [`switch` in the language specification](#{site.urls.spec}#switchcaseelse)

