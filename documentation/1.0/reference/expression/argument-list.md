---
layout: reference
title: 'Argument lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

An argument list is not an expression itself, but is used in the formation of 
[positional invocation expressions](../invocation/) and [tuple](../tuple/) and 
[iterable](../iterable/) enumerations.

## Usage 

A *positional argument list* is simply a series of expressions, separated by 
commas, shown here as a positional invocation of a `put` function using 
[listed arguments](#listed_arguments):

<!-- try: -->
    put(1, "one")

A *named argument list* is a series of "named arguments" enclosed in braces. 
This example of an invocation of a `put` function uses 
[specified arguments](#specified_arguments).

<!-- try: -->
    put {
        integer=1;
        name="one";
    }

## Description

The type of a parameter list is a 
[`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html) type formed from the 
types of the argument expressions in the list. 

### Listed arguments

Listed arguments are just vanilla arguments in a positional invocation, as 
shown in the example in [Usage](#usage). They are just an expressions which 
are evaluated to give the argument to the corresponding formal parameter.

TODO discuss listed arguments with variadic parameters

### Spread arguments

A spread argument assigns the elements of an iterable object or tuple to 
one or more (possibly variadic) parameters.

You can spread any [`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) 
over a variadic parameter:

<!-- try: -->
    void spreadIterable(String* names) {}
    
    {String*} names = { "Tom", "Gavin" };
    
    // A spread iterable
    spreadIterable(*names);

You can also spread a [`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html) 
over *more than one* parameter. In other words a single tuple can be used to 
provide the arguments of more than one parameter:

<!-- try: -->
    void spreadTuple(String name, Integer* numbers) {}
    
    [String, Integer] tup = ["Tom", 1234];
    
    // A spread tuple
    spreadTuple(*tup);
    
    // Variations
    spreadTuple(*["Dick"]);
    spreadTuple(*["Harry", 123, 466]);
    spreadTuple(*["Alice"]);
    spreadTuple("Eve", *[123, 466]);

Of course, the tuple type has to match the type of the parameter list, since
the invocation is checked for typesafety by the compiler.

### Comprehension arguments

A comprehension is a shorthand way of creating an 
[`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) 
to be passed as an argument.

### Anonymous Arguments

### Specified Arguments

### Function Arguments

### Getter Arguments

### `object` Arguments

## See also

* The reference on [invocation](../invocation)
