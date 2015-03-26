---
layout: reference12
title_md: '`super`'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

`super` refers to the current instance of the class or interface that immediately contains the 
immediately containing class or interface (like [`this`](../this/), but as if it 
were an instance of the intersection of the supertypes of the immediately containing 
class or interface.

## Usage 

This example shows `super` being used to distingush a member of the `Inner` class from a 
member of the same name in the `Outer` class:

    class Example() extends Foo() satisfies Bar & Baz {
        shared actual Integer hash => 3 + super.hash;
    }

## Description

### Type

The type of `super` is the intersection of the supertypes of the immediately containing class or interface. 
In the [above example](#usage) `super` has the type `Foo&Bar&Baz`.

### Legal use

Because `super` refers to the instance of the immediately containing class or interface
it cannot be used in contexts where there is no such class or interface, such as
in top level methods or values.

### Of
Continuing the [above example](#usage), if `Bar` and `Baz` both refined `hash` 
then `super.hash` would be an error (since it would be ambiguous). In such 
cases the [`of`](../../operator/of) is used to clarify which supertype is intended:

    shared actual Integer hash => 3 + (super of Bar).hash;

## See also

* [`super`](#{site.urls.spec_current}#super) in the spec
* the other "self references" [`this`](../this) and [`outer`](../outer)
