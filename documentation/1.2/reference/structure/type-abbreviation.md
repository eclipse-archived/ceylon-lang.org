---
layout: reference12
title_md: Type abbreviations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Some types are so commonly used in Ceylon that there are special 
abbreviations for them. 

## Usage 

Here are some examples:

<!-- try: -->
    T?          // T|Null
    {T*}        // Iterable<T,Null>
    {T+}        // Iterable<T,Nothing>, has at least one element
    [T*] or T[] // Sequential<T>
    []          // Empty
    [T+]        // Sequence<T>
    X->Y        // Entry<X,Y>

Certain abbreviations have a 
[recursive definition](/documentation/1.0/spec/html_single/#typenameabbreviations),
so we can't enumerate all the possibilities here.

There are abbreviations for tuple types:

<!-- try: -->
    [T]         // The 1-tuple Tuple<T, T, Empty>
    [X,Y]       // The 2-tuple Tuple<X|Y, X, Tuple<Y, Y, Empty>>
                // whose first element is an X and whose 
                // second element is a Y
    [X,Y*]      // The *-tuple Tuple<X|Y, X, Sequential<Y>>
                // whose first element is an X and 
                // which has zero or more further elements 
                // each of type Y
    [X,Y+]      // The +-tuple Tuple<X|Y, X, Sequence<Y>>
                // whose first element is an X and 
                // which has one or more further elements 
                // each of type Y

And for function types:

<!-- try: -->
    R()         // Callable<R,[]>, function with no parameters
    R(P1,P2)    // Callable<R,[P1,P2]>, function with two parameters
    R(P1,P2=)   // Callable<R,[P1]|[P1,P2]>, function with defaulted param
    R(P*)       // Callable<R,[P1*]>, variadic function
    R(P+)       // Callable<R,[P1+]>, nonempty variadic function

## Description

The above abbreviations can be used anywhere a type is expected. 

### Callable

The type abbtreviation `R(P1,P2)` is the same as `Callable<R,[P1,P2]>`, 
which is the type of a function which takes parameters of types `P1` and `P2` 
and returns an `R`. `R(P1,P2)` may also be the type of the class `R` 
if its initializer takes parameters of types `P1` and `P2`.

For higher order `Callable`s, there is the potential for some confusion.
Consider the following abbreviated `Callable` type:

<!-- try: -->
     Bar(String)(Foo)

This is the type of the function:

<!-- try: -->
    Bar higher(Foo)(String) {
        // ...
    }

Notice how the `String` and `Foo` swapped places?

If you think about it, `higher` could be declared like this:

<!-- try: -->
    Bar(String) higher2(Foo) {
        // ...
    }

And when you write it that way, it's not really surprising that `higher2` 
itself has type `Bar(String)(Foo)`.


### Variadic parameters

Although not technically a type abbreviation, 
[variadic parameters](../parameter-list/) are declared using a syntax that 
looks similar to the `Callable`, `Iterable`, and `Tuple` abbreviations above:

<!-- try: -->
<!-- check:none -->
    T*        // a possibly empty variadic parameter
    T+        // a non-empty variadic parameter

Of course, it's no coincidence that the function `Float sum(Float+ floats)`
has the function type `Float(Float+)`.

## See Also

* [`Null`](#{site.urls.apidoc_1_2}/Null.type.html)
* [`Sequential`](#{site.urls.apidoc_1_2}/Sequential.type.html)
* [`Sequence`](#{site.urls.apidoc_1_2}/Sequence.type.html)
* [`Empty`](#{site.urls.apidoc_1_2}/Empty.type.html)
* [`Iterable`](#{site.urls.apidoc_1_2}/Iterable.type.html)
* [`Tuple`](#{site.urls.apidoc_1_2}/Tuple.type.html)
* [`Callable`](#{site.urls.apidoc_1_2}/Callable.type.html)
