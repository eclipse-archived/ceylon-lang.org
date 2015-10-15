---
layout: reference12
title_md: 'Invocation'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Invocation is the act of calling something that is 
[`Callable`](#{site.urls.apidoc_1_2}/Callable.type.html).

## Usage 

Invocation using a [positional argument list](../positional-argument-list/), 
in parentheses:

<!-- try: -->
    put(1, "one")
    
Invocation using a [named argument lists](../named-argument-list/), 
in braces:

<!-- try: -->
    put {
        integer=1;
        name="one";
    }

## Description

The thing that is being invoked is called the *primary* of the invocation. 

The primary is followed by an argument list. There are two distinct 
kinds of argument list:

* Positional argument lists are enclosed in parenthesis and 
  separated with commas (see reference page for 
  [positional argument lists](../positional-argument-list/)).
* Named argument lists are enclosed in braces
  and separated with semicolons (see reference page for 
  [named argument lists](../named-argument-list/)).

It is useful to classify invocations as direct and indirect:

* A *direct invocation* is one where the primary is a function, method, 
  or class. The typechecker knows about the declaration of the primary,
  so invocation using named arguments is supported.
* An *indirect invocation* is one where the primary is a reference with 
  `Callable` type (such as a function reference). 
  Since the primary isn't based on a declaration (or at least, 
  there's no declaration known to the typechecker), invocation 
  using named arguments is not supported.

For example: 

    print("hello world); // direct invocation
    value p = print;
    p("hello world); // indirect invocation

### Function and method invocation

Function and method invocation is *direct* invocation, and supports 
both positional argument lists and named argument lists.

    print("hello world);
    print{
        val="hello world";
    };

### Class invocation

Invoking a [class](../../structure/class/) (*instantiating* it) 
creates a new instance of the class.

Class invocation is a *direct* invocation, and therefore supports 
both positional argument lists and named argument lists.

    value alice = Person("alice");
    value bob = Person{
        name="bob";
    };
    
### Constructor invocation

Invoking a [class constructor](../../structure/class/#constructor_declarations)
creates a new instance of the class, just like class invocation. 
The only difference is that when you're invoking a non-default constructor
you have to specify the constructor name.

    value anon = Person.anonymous();

### Indirect invocation

You can invoke a [reference](../../structure/value/) if it has a 
`Callable` type:

<!-- try: -->
    Callable<Anything, []> fn = // ...
    Anything result = fn();

Because the `Callable` type does not retain any information about
the parameter names, you cannot use a named argument invocation; 
only positional arguments.

### Superclass initializer invocation

Technically, the `extends` clause of a 
[class declatation](../../structure/class/) is also an invocation: 
Of the superclass's initializer. For example:

    class Example(String name) 
            extends Person(name) // invocation! 
    {
    }



### Defaulted parameters

Both direct and indirect invocations allow you to omit 
arguments for some parameters if those parameters have 
a [default value](../../structure/parameter-list/#defaulted_parameters).

This works for indirect invocations because the `Callable` 
type can encode information about 
defaulted parameters, so the 
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

Technically, [tuple](../tuple) and [iterable](../iterable/) 
enumerations are also invocations: They instantiate new
tuples and iterables respectively.

## See also

* [Invocation expressions](#{site.urls.spec_current}#invocationexpressions) in 
  the Ceylon language specification
