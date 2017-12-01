---
layout: reference13
title_md: '`switch` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `switch` statement executes code conditionally according to an enumerated 
list of disjoint cases.

## Usage 

The general form of the `switch` statement is

<!-- check:none -->
<!-- try: -->
    switch ( /* switch expression */ )
    case ( /* case */) {
        /* case block */
    }
    case ( /* case */) {
        /* case block */
    }
    else case ( /* case */) {
        /* case block */
    }
    else {
        /* else block */
    }
    /* code after switch statement */

There must be one or more *disjoint* `case` clauses. There may optionally
be one or more non-disjoint `else case` clauses. There may be at most one
`else` clause.

The `else` clause is required if (and only if) the cases are not 
[*exhaustive*](#exhaustivity_and_else).

## Description

Unlike most other programming languages, a `switch` statement in Ceylon must be
_exhaustive_, covering all possible values of the `switch` expression, and its
cases must be _disjoint_, having no value in common.

### Execution

The `switch` expression is evaluated and then each of the `case`s is considered. 
The matching `case` has its block executed, and then execution continues with the 
code after the `switch` statement. If none of the given `case`s match and an `else` 
clause is given, then the `else` block is executed, and then execution continues 
with the code after the `switch` statement. 

**Note:** The compiler need not evaluate the cases in the order they are written.

### Exhaustivity and `else`

If the `case`s cover every possible case of the `switch` expression then the 
`switch` is said to be *exhaustive*, and the `else` clause is prohibited. 
Otherwise the `else` clause is required.

### `case` with an enumerated type (value reference)

If the `switch` expression is of an 
[enumerated type](../../structure/type-declaration#enumerated_types) `U` then a `case` may 
be of the form `case (x)` where `x` is one of the cases of `U`. A list of cases, 
`case(x | y | z)`, is also permitted.
  
Since `Boolean` and `Null` are both enumerated types, we can use their enumerated
values in a `switch`:

<!-- try: -->
    void switchOnEnumValues(Boolean? b) {
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

### `case(is...)` (assignability condition)
  
If the `switch` expression type `U` is a union of disjoint types, or an 
[enumerated type](../../structure/type-declaration#enumerated_types), then a `case` 
may be of the form `case (is V)` where `V` is a case of the type `U`.

<!-- try: -->
    void switchOnEnumTypes(Foo|Bar|Baz var) {
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

### `case(...)` with literals

If the `switch` expression is of type [`Integer`](#{site.urls.apidoc_1_3}/Integer.type.html), 
[`Character`](#{site.urls.apidoc_1_3}/Character.type.html), or 
[`String`](#{site.urls.apidoc_1_3}/String.type.html) then the 
`case`s may be literal values.

<!-- try: -->
    void switchOnLiteralValues(Integer i) {
        switch (i)
        case (0) {
            print("zero"); 
        }
        case (1) {
            print("one");
        }
        case (2) {
            print("two");
        }
        else { 
            print("lots"); 
        }
    }

Since it's impossible to enumerate every value of any of these types, the `else` 
clause is required.

### `case(...)` with tuples

Since Ceylon 1.3.1 it is possible to switch over a `Tuple` (and `Empty`) expression using 
tuples:

<!-- try: -->
    Float[2]|Float[3] coord = ... ;
    switch (coord)
    case ([Float x, Float y]) { 
        print((x^2+y^2)^0.5);
    }
    case ([Float x, Float y, Float z]) {
        print((x^2+y^2+z^2)^0.5);
    }

It is also possible to match tuples with literal elements

<!-- try: -->
    String formatComplex([Integer, Integer] complex) {
        switch(complex)
        case ([0, 0]) {
            return "origin";
        }
        case ([1, 0]) {
            return "1";
        }
        case ([0, 1]) {
            return "i";
        } 
        else {
            return "``complex[0]``+``complex[1]``i";
        }
    }

### Flow typing

Note that `case (is ...)` narrows the type of the switch value within the 
scope of the `case`. Furthermore this flow typing can also affect the `else` 
clause of the control structure:

    void go(Car|Bicycle|Motobike vehicle) {
        switch(vehicle)
        case (is Car) {
            // vehicle has type Car
            vehicle.drive();
        } 
        else {
            // vehicle has type Bicycle|Motobike
            vehicle.ride();
        }
    }

### Variable declaration

As an alternative to the `switch` expression, an inline variable declaration (containing an initializing expression) is allowed. This declares a new variable which is then usable inside the `case` and `else` blocks (with the correct type in each of them).

    switch(line = process.readLine())
    // line has type String?
    case(is Null) {
        // line has type Null
        print("End of file!");
    }
    else {
        // line has type String
        print(line);
    }


## See also

* The [`if` statement](../if) is an alternative control structure for 
  conditional execution
* The [`switch` expression](../../expression/switch/) 
* [`switch` in the language specification](#{site.urls.spec_current}#switchcaseelse)

