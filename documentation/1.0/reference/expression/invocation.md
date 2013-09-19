---
layout: reference
title: 'Invocation'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

Invocation is the act of calling something that is [`Callable`](#{site.urls.apidoc_current}/Callable.type.html).

## Usage 

Invocation using a *positional argument list*, using parentheses:

<!-- try: -->
    method(1, "one");
    
Invocation using a *named argument list*, using braces:

<!-- try: -->
    method{
        integer=1;
        name="one;
    };

## Description

The thing that is being invoked is called the *primary* of the invocation. 
It is followed by an [argument list](../argument-list/).

The type of an invocation expression is the return type of 
the [callable type](../../structure/function#callable_type) of the primary, for example the 
type a function is declared to return 
or the type of the class being invoked.

### Function and method invocation

Function and method invocation is a *direct* invocation, and therefore supports 
named argument lists.

### Class invocation

Invoking a class (*instantiating* it) creates a new instance of that class.

Class invocation is a *direct* invocation, and therefore supports 
named argument lists.

### Indirect invocation

You can invoke a [value](../../structure/value/) that has a 
`Callable` type:

<!-- try: -->
    Callable<Anything, []> fn = // ...
    Anything result = fn();

Because the `Callable` type does not retain any information about
the parameter names, and cannot use a named argument invocation; 
only positional arguments.

The `Callable` type can encode information about 
[defaulted parameters](../../structure/parameter-list/#defaulted_parameters), so the 
invocation need not specify arguments for parameters which are defaulted:

<!-- try: -->
    Callable<Anything, [String=]> defaulted = // ...
    variable Anything result = defaulted();
    result = defaulted("an argument");

### Multiple argument lists

Because a `Callable` can itself have a `Callable` return type you sometimes see
invocations with multiple parameter lists:

    String(String)(Integer) higher = // ...
    String result = higher(1)("");

Note that the [type abbreviation](../../structure/type-abbreviation/) 
for `Callable` means that the argument lists appear in 
reversed order because `String(String)(Integer)`
is parsed as `Callable<Callable<String, [String]>, [Integer]>`

Named argument lists are only allowed as the first argument list in 
an invocation using multiple argument lists, because the second 
invocation is an [indirect invocation](#indirect_invocation).

### Tuple and Iterable enumeration

Technically [tuple](../tuple) and [iterable](../iterable/) 
enumerations are also invocations. 

## See also

* [Iterable enumeration](#{site.urls.spec_current}#enumeration) in the spec
