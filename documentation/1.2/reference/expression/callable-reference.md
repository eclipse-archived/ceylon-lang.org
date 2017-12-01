---
layout: reference12
title_md: Callable references
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A _callable reference_ is an expression that references something 
(a function, method, or class) that can be invoked by specifying 
a [positional argument list](../positional-argument-list).

## Usage

<!-- try: -->
    value classReference = String;
    value methodReference = 1.plus;
    value functionReference = sum<Integer>;
    // constructor reference
    class Baz {
        shared new (){}
        shared new constructor(String name) {}
    }
    Baz(String) baz = Baz.constructor;
    
## Description

Callable references introduce a level of indirection between the 
definition of a function, method, or class, and the invocation of
the function, method, or class, allowing the definition of generic
functions, called _higher order functions_, that operate upon
callable references and other `Callable` values.

### Type

The type of a callable reference is the 
[callable type](../../structure/function/#callable_type) of the 
thing being referenced, so referring to the [example above](#usage),

* the type of `classReference` is `String({Character*})`,
* the type of `methodReference` is  `Integer(Integer)`,
* the type of `functionReference` is `Integer({Integer+})`,
* the type of `Baz.Constructor` is `Baz(String)`.

### Unreferenceable elements

It's not possible to obtain a callable reference to an `abstract` 
class, because calling it would be the same as instantiating the 
`abstract` class. So, for example, the following code is illegal:

    value objectReference = Object;

A callable reference to a generic declaration must specify type 
arguments, as shown by `functionReference` in the [example above](#usage). 
This code is illegal:

    value functionReference = sum;

### Invocation

A callable reference may be invoked, for example:

    classReference({'h', 'e', 'l', 'l', 'o'})

This is an [indirect invocation](../invocation#indirect_invocation), so 
you cannot use a [named argument list](../named-argument-list).

### Equality

`Callable` does not refine `Object.equals`. This means that
if you obtain two different callable references to the 
same thing they will *not compare as equal*:

    value ref = String;
    // while this assertion will pass...
    assert(ref == ref);
    // ...these assertions will fail
    assert(String == String);
    assert(ref == String);

While this may seem surprising for callable references 
like `String` it would also be surprising if 
some `Callable` instances had a semantic for `equals`, but 
others (such as those produced by higher order functions) 
did not. 

## See also

* [Callable references](#{site.urls.spec_current}#callablereferences) 
  in the Ceylon language specification
