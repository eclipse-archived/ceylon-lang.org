---
layout: reference
title: '`=` (specification) statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

The specification statement is used to define the value of a reference 
or the implementation of a getter or function.

## Usage 

The general form of the specification statement is

<!-- check:none -->
<!-- try: -->
    T t = ... /* some expression of type T */

Where is it permitted, the declaration of the value may be 
separate from its specification:

<!-- check:none -->
<!-- try: -->
    T t;
    t = ... /* some expression of type T */

## Description

There is an ambiguity between the assignment operator (the `=` *operator*) 
and the specification statement (the `=` *statement*). The spec says that, 
where it is possible, the ambiguity is resolved in favour of the 
specification statement.

### Execution

After the specification statement and for the rest of the scope of the reference it 
will have the specified value.

### Not an operator

Because specification is a 
statement and not an operator it cannot be used within expressions:

<!-- check:none -->
<!-- try: -->
    Boolean isEmpty;
    if (isEmpty = sequence.size == 0) { // compilation error
        // ...
    }

## See also

* The [`=` (assignment) *operator*](../../operator/assign/), used for 
  assigning a value to `variable` locals or attributes.

