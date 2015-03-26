---
layout: reference12
title_md: '`this`'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

`this` refers to the current instance of the immediately containing class or interface.

## Usage 

This example shows `this` being used to distingush a member value from a 
parameter of the same name:

    class Example(foo) {
        String foo;
        String foofoo(String foo) 
            => this.foo + foo;
    }

## Description

### Type

The type of `this` is the type of the immediately containing class or interface. 
In the [above example](#usage) `this` has the type `Example`.

### Legal use

Because `this` refers to the instance of the containing class or interface
it cannot be used in contexts where there is no such class or interface, 
such as top level methods or values.

## See also

* [`this`](#{site.urls.spec_current}#this) in the spec
* the other "self references" [`super`](../super) and [`outer`](../super)
