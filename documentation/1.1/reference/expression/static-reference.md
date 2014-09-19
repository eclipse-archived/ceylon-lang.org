---
layout: reference
title_md: Static references
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A _static reference_ is an "unbound" reference to an attribute, method, 
or member class.

## Usage

<!-- try: -->
    // static attribute reference
    Integer(String) stringSize = String.size;
    
    // static method reference
    Integer(Integer)(Integer) intPlus = Integer.plus;
    
    class Foo() {
        shared class Bar(String s) {}
    }
    // static member class reference
    Foo.Bar(String)(Foo) fooBar = Foo.Bar;

## Description

### Type

The type of a static reference is a higher order 
[`Callable`](#{site.urls.apidoc_current}/Callable.type.html):

* A static expression referring to an attribute with type `A` of a 
  type `T` has the type `X(T)`. 
* A static expression referring to a method with callable type 
  `M(P1, P2, ..., Pn)` of a type `T` has type `M(P1, P2, ..., Pn)(T)`
* A static expression referring to a member class with callable type 
  `C(P1, P2, ..., Pn)` of a type `T` has type `C(P1, P2, ..., Pn)(T)`

A static reference to an attribute is also known as a *static value reference* 
and a static reference to a method or member class is also known as a *static 
callable reference*.

### Invocation

The first invocation of the `Callable` resulting from a static callable reference 
(that is, a reference to a method or member class) "binds" it to the instance used 
as the argument. Such an invocation returns a "bound" `Callable` instance that is 
equivalent to the [callable reference](../callable-reference/) we would have 
obtained using that instance as the receiver. 

Continuing the [above example](#usage):

<!-- try: -->
    Integer(Integer) plusOne = intPlus(1);
    Integer(Integer) plusTwo = intPlus(2);

Here `plusOne` is equivalent to the [callable reference](../callable-reference/) 
`1.plus`, and `plusTwo` is equivalent to the callable reference `2.plus`.

Similarly:

<!-- try: -->
    Foo foo = Foo()
    Foo.Bar(String) bar = fooBar(foo);

Here `bar` is  equivalent to the callable reference `foo.Bar`.

Obviously, we could also invoke the result immediately, by supplying two argument 
lists, like this:

<!-- try: -->
    Integer three = intPlus(1)(2);
    Foo.Bar bar = fooBar(Foo())("bar");


## See also

* [Static expressions](#{site.urls.spec_current}#staticexpressions) 
  in the Ceylon language specification
