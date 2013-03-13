---
layout: reference
title: Type Parameters
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

[Class](../class), [interface](../interface) and [method](../method) 
declarations may be one or more type parameters.

## Usage 

A simple type-parameterized (or *generic*) class might look like this:

    class C<X>() {
        /* declarations of class members */
    }
    
A simple type-parameterised (or *generic*) method might look like this:

    void m<X,Y>(X x, Y y) {

    }

**Note**: By convention type parameters are given meaningful names rather than
single letter names, such as `T`, `U`, `V` etc as is common in some other 
languages.


## Description

### As functors

Conceptually a parameterized class or interface declaration is a 
*type constructor* which is a function that produces a type 
given a tuple of compatible type arguments.

Conceptually a parameterized class or method declaration 
defines a function that produces the signature of an 
invokable operation given a tuple of compatible type arguments.

These 'functions operating on types' are sometimes known as *functors*.

### Type parameter lists

Type parameter lists are a comma separated list of types or type parameters 
enclosed in angle brackets (`<` and `>`). The type 
parameter list occurs directly after the class, interface or method name 
in the declaration and before the [parameter list](../parameter-list).

#### Variance

The type names in the type parameter list of a class or interface 
may optionally be preceeded with the variance modifier
`in` (indicating a *contravariant* type parameter) or 
`out` (indicating a *covariant* type parameter). Type parameters without 
either modifier are *invariant*.

Method type parameters are not allowed the `in` or `out` modifiers.

Contravariant and covariant type parameters are only permitted in certain 
places within the type-parameterised declaration. For example a covariant 
type parameter of a method is not permitted in the method's parameter list 
and a contravariant type parameter is not permitted as the method's 
return type.

### Constraints

Type-parameterized declarations may have a `given` clause for each 
declared type parameter to constrain the permitted type argument.

The constraints are:

* Upper bound: `given X satisfies T` constrains `X` to be a subtype of `T`
* Lower bound: `given X abstracts T` constrains `X` to be a supertype of `T`
* Enumerated bound: `given X of T|U|V` constraints `X` to be one of the 
  enumerated types, `T`, `U` or `V`.
* Parameter bound: `given X(...)` constraints `X` to be a class with an 
  initializer the given types.
* Combinations of the above using `&`.


### Defaulted type parameters

Just as a parameter list can define defaulted parameters, a type argument list
can define defaulted type parameters. Here's an example from the language module:

    Iterable<out Element, out Absent=Null>
    
This means we can apply the type constructor `Iterable` using either one 
or two type arguments. If we supply only one type argument, the default 
type (in this case `Null`) is used:

    // same as Iterable<String, Null>
    Iterable<String> zeroOrMore; 

    Iterable<String, Nothing> oneOrMore;
    
Using a defaulted type parameter can be used as an alternative to 
a [type `alias`](../type-alias): We could have declared `Iterable` without a
defaulted type parameter and uses alises:

    alias PossiblyEmpty<T> => Iterable<String, Null>
    alias NonEmpty<T> => Iterable<String, Nothing>

### Parameterized type parameters

Parameterized type parameters are currently only a proposal in the Ceylon 
specification. 

Parameterized type parameters permit a type constraints of form `given X<T>` 
where `X` itself is a type parameter.

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
