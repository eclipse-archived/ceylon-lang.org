---
layout: reference13
title_md: '`outer`'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

`outer` refers to the current instance of the class or interface that immediately contains the 
immediately containing class or interface.

## Usage 

This example shows `outer` being used to distingush a member of the `Inner` class from a 
member of the same name in the `Outer` class:

    class Outer(foo) {
        String foo;
        class Inner() {
            variable String foo = outer.foo;
        }
    }

## Description

### Type

The type of `outer` is the type of class or interface that immediately contains the 
immediately containing class or interface. In the [above example](#usage) `outer` 
has the type `Outer`.

### Legal use

Because `outer` refers to the instance of the class or interface that 
immediately contains the immediately containing class or interface
it cannot be used in contexts where there is no such class or interface, such as
in top level classes, interfaces, methods or values.


## See also

* [`outer`](#{site.urls.spec_current}#outer) in the spec
* the other "self references" [`this`](../this) and [`super`](../super)
