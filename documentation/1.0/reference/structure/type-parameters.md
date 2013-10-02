---
layout: reference
title: Type Parameters
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

[Class](../class/), [interface](../interface/) and [function](../function/) 
declarations may have one or more type parameters.

## Usage 

A simple type-parameterized (or *generic*) class might look like this:

<!-- try: -->
    class Class<out Element>(Element* elements) {
        /* declarations of class members */
    }
    
A simple type-parameterised (or *generic*) function might look like this:

<!-- try: -->
    void fun<First,Second>(First first, Second second) {

    }

**Note**: By convention, type parameters are given meaningful names rather 
than single letter names, such as `T`, `U`, `V`, etc, as is common in many 
other languages.


## Description

### Type constructors

Conceptually, a parameterized class or interface declaration is a *type 
constructor*, that is, a function from types to types. It produces a type 
given a tuple of compatible type arguments.

Conceptually, a parameterized class or function declaration defines a 
function that produces the signature of an invokable operation given a 
tuple of compatible type arguments.

**Note**: we often view the definition of a generic class or function as
a _template_ for producing a class or function. However, this is a 
slightly misleading mental model. Generics in Ceylon are very different
to C++-style templates, and are ultimately derived from the approach taken
in languages like ML.

### Type parameter lists

A type parameter list is a comma separated list of type names enclosed 
in angle brackets (`<` and `>`). The type parameter list occurs directly 
after the class, interface, or function name, and before any 
[value parameter list](../parameter-list).

#### Variance

The type names in the type parameter list of a class, interface, or 
function may optionally be preceded by a variance modifier
`in` (indicating a *contravariant* type parameter) or 
`out` (indicating a *covariant* type parameter). Type parameters without 
either modifier are *invariant*.

References to contravariant and covariant type parameters are only 
permitted in certain locations within the type-parameterised declaration. 
For example a covariant type parameter of a class is not permitted to
occur in the parameter list of a method of the class. Likewise, a 
contravariant type parameter of the class is not permitted as the method's 
return type.

### Constraints

Type-parameterized declarations may have a `given` clause for each declared 
type parameter to constrain the permitted type argument.

The constraints are:

* An _upper bound_, `given X satisfies T`, constrains arguments of `X` to 
  subtypes of `T`.
* An _enumerated bound_, `given X of T|U|V`, constrains arguments of `X` to 
  be one of the enumerated types, `T`, `U`, or `V`.

#### Examples

The default supertype of a type parameter is 
[`Anything`](#{site.urls.apidoc_current}/Anything.type.html), 
so it's common to 
see type constraints which use [`Object`](#{site.urls.apidoc_current}/Object.type.html) 
as an upper bound if the declaration 
doesn't support 
[`Null`](#{site.urls.apidoc_current}/Null.type.html). 
An example of this is [`Set`](#{site.urls.apidoc_current}/Set.type.html) 
from the language module:

<!-- try: -->
    shared interface Set<out Element>
            satisfies Collection<Element> &
                      Cloneable<Set<Element>>
            given Element satisfies Object {
        // ...
    }

Given this declaration it's not allowed to have a `Set<String?>`, because 
`String?` means `String|Null` and although `String` satisfies `Object`, 
`Null` does not.

Another example from the language module is [`Comparable`](#{site.urls.apidoc_current}/Comparable.type.html), 
declared like this:

<!-- try: -->
    shared interface Comparable<in Other> of Other 
            given Other satisfies Comparable<Other> {
        // ...
    }

This is an example of a *self type* bound: The type parameter `Other` is 
constrained to itself be `Comparable<Other>`, loosely meaning that once the 
type `Comparable<Other>` is instantiated, `Other` will be the same type as 
the type instantiated type. Concretely, in the type instantiation 
`Comparable<Integer>`, `Other` has the type `Integer`, and is thus a subtype 
of `Comparable<Integer>`.

A final example is the language module's
[`sort()`](#{site.urls.apidoc_current}/index.html#sort) function, which 
constrains the type parameter `Element` so that it can only be called 
with a `Comparable` type argument:

<!-- try: -->
    shared Element[] sort<Element>({Element*} elements) 
            given Element satisfies Comparable<Element>

This is necessary so that `sort()` can use the `<=>` operator to determine 
how two elements compare, and so that you cannot call `sort()` with elements 
which cannot be compared. 

### Defaulted type parameters

Just as a parameter list can define defaulted parameters, a type argument list
can define defaulted type parameters. Here's an example from the language module:

<!-- try: -->
    Iterable<out Element, out Absent=Null>
    
This means we can apply the type constructor 
[`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) using either one 
or two type arguments. If we supply only one type argument, the default type 
(in this case `Null`) is used:

<!-- try: -->
    // same as Iterable<String, Null>
    Iterable<String> zeroOrMore; 

    Iterable<String, Nothing> oneOrMore;
    
Using a defaulted type parameter can be used as a more flexible alternative to 
a [type `alias`](../alias#type_aliases). We could have declared `Iterable` 
without a defaulted type parameter and used alises:

<!-- try: -->
    alias PossiblyEmpty<T> => Iterable<String, Null>
    alias NonEmpty<T> => Iterable<String, Nothing>

(In fact, we don't need the aliases because Ceylon has built-in syntax sugar
for `PossiblyEmpty<T>` and `NonEmpty<T>`, the type abbreviations `{T*}` and 
`{T+}`.)

## See also

* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`function` declaration](../function/) 
