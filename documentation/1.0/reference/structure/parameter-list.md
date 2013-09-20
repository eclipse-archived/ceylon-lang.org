---
layout: reference
title: Parameter lists
tab: documentation
unique_id: docspage
author: Tom Bentley
toc: true
---

# #{page.title}

Methods and class initializers have a *parameter list* to declare what parameters they take. 
A parameter list consists of zero or more *parameters*.

#{page.table_of_contents}

## Usage

<!-- try: -->

    class Example(Integer value, String name) {
    }
    
    void example(Integer value, String name) {
    }

## Description

### Parameter lists

Syntactically, a parameter list is
a comma separated list enclosed in parentheses following
the [type parameter list](../type-parameters). Each parameter is composed of a 
type expression and a name. 

#### Defaulted parameters

A default value for a parameter may be specified. 
The default expression following the parameter name, separated with an equals sign:

<!-- try: -->
    void example(Integer value, 
            String name = value == 0 then "zero" else "") {
    }

A defaulted parameter allows the method or class to 
be [invoked](../../expression/invocation)
without an expression being given for 
that parameter. 

Parameters with default values may be called 
*optional parameters* or *defaulted parameters*. 
Parameters without default values may be called
*required parameters*. The defaulted 
parameter expression may be called the 
*default argument*, or the *default parameter* 
(though this confuses the distinction between 'parameter' and 'argument').

To avoid ambiguity, defaulted parameters are only permitted after all the 
non-defaulted parameters in the parameter list.

#### Variadic methods and ('varargs')

**Note:** In Ceylon methods which accept an `Iterable` parameter are 
generally preferred over variadic methods.

A *variadic method* has a *variadic parameter* (or *sequenced parameter*) 
as the last parameter in the parameter list. 

There are two different kinds of variadic parameter:

* Possibly-empty variadic parameters allow the method to be 
  [invoked](../../expression/invocation) with the caller specifying zero or 
  more arguments for that parameter. Syntactically, possibly-empty 
  variadic parameters are declared as a type name followed by 
  star (`*`) followed by the parameter name.
  From within the method or class the parameter has the type [`T[]`](../type#Sequential).
  A possibly-empty variadic parameter's defaulted value is implictly empty.
* Non-empty variadic parameters allow the method to be
  [invoked](../../expression/invocation) with the caller specifying one or 
  more arguments for that parameter.  Syntactically, non-empty 
  variadic parameters are declared as a type name followed by 
  plus (`+`) followed by the parameter name.
  From within the method or class the parameter has the type [`Sequence<T>`](../type#Sequence).
  A non-empty variadic parameter doesn't have a defaulted value, and none of 
  the preceding parameters may be [defaulted](#defaulted_parameters).

For example

<!-- try: -->
    void variadic(String s, Integer* i) {
        /* method body: statements 
           parameter i treated as an Integer[] */
    }

### Invocation

When the method or class is the primary in an
[invocation](../../expression/invocation), the caller 
supplies an [argument list](../../expression/argument-list) 
whose [Tuple](#{site.urls.apidoc_current}/Tuple.type.html) 
type must be a subtype of the Tuple type of the parameter list.

### Multiple parameter lists

Methods can be declared with multiple parameter lists. Here's an example:

<!-- try: -->
    String name(String firstName)(String secondName) {
        return firstName + " " + secondName;
    }
    
This is equivalent to the higher-order method `String(String) name(String)`, 
that is a method which returns (when invoked with 
a single argument list) a `String(String)` callable reference which can be 
invoked again to produce a `String`. 

**Note**: Classes cannot be declared with multiple parameter lists: That 
wouldn't make sense.

## See also

