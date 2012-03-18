---
layout: reference
title: `=` (specification) statement
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The specification statement is used to define the value of a non-`variable`
local, attribute or method argument.

## Usage 

The general form of the specification statement is

<!-- check:none -->
    T t = ... /* some expression of type T */

Where is it permitted, the declaration of the attribute or local may be 
separate from its specification:

<!-- check:none -->
    T t;
    t = ... /* some expression of type T */

## Description

Ceylon makes a distinction between assigning mutable state (the `:=` operator) 
and specifying immutable state (the `=` statement). 

### Execution

After the specification statement and for the rest of the scope of the local 
or attribute that member will have the specified value.

### Not an operator

Because specification is a 
statement and not an operator it cannot be used within expressions:

<!-- check:none -->
    Boolean isEmpty;
    if (isEmpty = sequence.size == 0) { // compilation error
        // ...
    }

## See also

* The [`:=` (assignment) operator](../../operator/assignment/), used for 
  assigning a value to `variable` locals or attributes.

