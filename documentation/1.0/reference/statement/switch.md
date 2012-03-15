---
layout: reference
title: `switch` statement
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../../..
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

There can be one or more *disjoint* `case` clauses. 
The `else` clause is required if (and only if) the switch is not 
[*exhaustive*](#exhaustivity_and_else).

A specific example switching on an optional `Boolean` expression
(this is easily generalized to any [enumerated type](../../type/#enumerated_types)):

    void m(Boolean? b) {
        switch(b)
        case (true) {
            print("yes");
        }
        case (false) {
            print("no");
        }
        case (null) {
            print("Who cares");
        }
    }

Another example, using the `case(is...)` special form and a union type:

    class Foo(){}
    class Bar(){}
    class Baz(){}
    void m3(Foo|Bar|Baz var) {
        switch(var)
        case (is Foo) {
            print("FOO");
        }
        case (is Bar) {
            print("BAR");
        }
        case (is Baz) {
            print("BAZ");
        }
    }

## Description

### Execution

The `switch` expression is evaluated and then each of the `case`s is considered. 
The matching `case` has its block executed, and then execution 
continues with the code after the `switch` statement. 
If none of the given `case`s match and an `else` clause is given then the 
`else` block is executed, and then execution 
continues with the code after the `switch` statement. 

### Exhaustivity and `else`

If the `case`s cover every possible case of the `switch` expression then the 
switch is said to be *exhaustive*, and the `else` clause is prohibited. 
Otherwise the `else` clause is required.

### Polymorphism

If the `switch` expression is of an enumerated type `U` then the 
`case`s may be

* **value reference:** of the form `case (x)` where `x` is one of the cases 
  of `U` (a list of cases `case(x, y, z)` is also permitted).
* **assignability condition:** of the form `case (is V)` where `V` is a case 
  of the type `U`.

If the switch expression is of type `Type<U>` for some an enumerated type `U` 
then the `case` must be:

* **subtype condition:** of the form `case (satisfies V)` where `V` is a case 
  of the type `U`.

## See also

* The [`if` statement] (../if) is an alternative control structure for 
  conditional execution
* [`switch` in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#switchcaseelse)

