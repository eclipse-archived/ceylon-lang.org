---
layout: reference13
title_md: Specification statements
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

The specification statement is used to define the value of a reference 
or the implementation of a getter or function.

## Usage 

A specification statement for a reference uses the `=` assignment symbol:

<!-- check:none -->
<!-- try: -->
    T t;
    t = ... /* some expression of type T */

A specification statement for a getter of function uses the `=>` fat 
arrow symbol:

<!-- check:none -->
<!-- try: -->
    T f(Float float);
    f(Float float) => ... /* some expression of type T */

The same syntax may be used within a value or function declaration, but
in this case it is not, strictly speaking, a specification statement:

<!-- check:none -->
<!-- try: -->
    T t = ... /* some expression of type T */

<!-- check:none -->
<!-- try: -->
    T f(Float float) => ... /* some expression of type T */

## Description

Note that `=>` syntax consistently implies *lazy evaluation*, and 
`=` implies *eager evaluation*.

There is, in principle, an ambiguity between the assignment operator 
(the `=` *operator*) and the specification statement (the `=` *statement*). 
The specification says that the ambiguity is always resolved in favour of
interpreting the statement as a specification statement. In practice, the
only real semantic difference between these constructs is how they affect
definite specifiction analysis.

### Definite specification

The Ceylon typechecker ensures that references are *definitely specified*
before they are used. Unlike in Java, references are never automatically
initialized to zero or the null value.

These checks can be disabled using the [`late`](../../annotation/late/)
annotation.

### Destructuring

When extracting values from a `Tuple` or `Entry` you can use 
[destructuring](../destructuring):

    // declares values x and y, where location is a tuple
    value [x, y] = object.location;

## See also

* The [`=` (assignment) *operator*](../../operator/assign/), used for 
  assigning a value to `variable` locals or attributes.
* [Specification statements](#{site.urls.spec_current}#specificationstatements) 
  in the Ceylon language specification
* [Destructuring](../destructuring)
