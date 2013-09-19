---
layout: reference
title: 'Static references'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A static reference is an "unbound" reference to an attribute, 
method, or member class.

## Usage

<!-- try: -->
    Integer(String) stringSize = String.size;
    Integer(Integer)(Integer) intPlus = Integer.plus;
    class Foo() {
        shared class Bar(String s) {}
    }
    Foo.Bar(String)(Foo) fooBar = Foo.Bar;

## Description

### Type

The type of a static reference is a higher order 
[`Callable`](#{site.urls.apidoc_current}/Callable.type.html):

* A static expression referring to an attribute of type `A` on a type `T` 
  has the type `X(T)`. 
* A static expression referring to a method of callable type 
  `M(P1, P2, ..., Pn)` on a type `T` has type `M(P1, P2, ..., Pn)(T)`
* A static expression referring to a member class of callable type 
  `C(P1, P2, ..., Pn)` on a type `T` has type `C(P1, P2, ..., Pn)(T)`

A static reference to an attribute is also known as a *static value reference* and 
a static reference to a method or member class is also known as a *static Callable reference*.

### Invocation

The first invocation of the `Callable` resulting from a static Callable reference 
(that is, a reference to a method or member class) "binds" it to the instance used as the argument. 
Such an invocation returns a "bound" `Callable` instance 
that is equivalent to the [callable reference](../callable-reference/) we would have obtained 
using that instance. 

For example, continuing the [above example](#usage),

<!-- try: -->
    Integer(Integer) plusOne = intPlus(1);
    Integer(Integer) plusTwo = intPlus(2);
    Foo foo = Foo()
    Foo.Bar(String) bar = fooBar(foo);

`plusOne` is equivalent to the [callable reference](../callable-reference/) `1.plus`,
`plusTwo` is equivalent to the callable reference `2.plus`, and
`bar` is  equivalent to the callable reference `foo.Bar`.

Obviously, we could also invoke the result immediately, but 
supplying two argument lists, like this:

<!-- try: -->
    Integer three = intPlus(1)(2);


## See also

