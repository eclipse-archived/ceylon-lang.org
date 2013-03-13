---
layout: reference
title: Parameter lists
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

### Parameter lists

Methods and class initializers have a *parameter list* to declare what parameters they take. 
A parameter list consists of zero or more *parameters*.

when the method is 
[invoked](../../expression/invocation) or the class is instantiated, the caller 
supplies an *argument list* which has to match the parameter list according to 
certain rules.

Syntactically, a parameter list is
a comma separated list enclosed in parentheses following
the [type parameters](#type_parameters). Each parameter is composed of a 
type expression and a name. 

For example a method taking an Integer parameter `i` and a parameter `b` 
whose type is a type parameter `<Z>` looks like this:

    void m<Z>(Integer i, Z b) {
        /* method body: statements */
    }


#### Defaulted parameters

A default value for a parameter may be specified. This allows the method to 
be [invoked](../../expression/invocation) or the class instantiated 
without passing an argument for 
that parameter. Parameters with default values may be called 
*optional parameters* or *defaulted parameters*. 
Parameters without default values may be called
*required parameters*.

Syntactically default values are [expressions](../../#expression) separated from the 
parameter name with the equals specifier. The expression may be called the 
*default argument*, or the *default parameter* 
(though this confuses the distinction between 'parameter' and 'argument').

For example a method `defaulted` declared like this

<!-- id:defaulted -->
    void defaulted(Integer i = 0) {
        /* method body: statements */
    }

can be [invoked](../../expression/invocation) without supplying an argument 
for the parameter `i`, like this:

<!-- cat-id:defaulted -->
<!-- cat: void m2() { -->
    defaulted();
<!-- cat: } -->

To avoid ambiguity, defaulted parameters are only permitted after all the 
non-defaulted parameters in the parameter list.

#### Variadic methods and  ('varargs')

**Note:** In Ceylon methods which accept an `Iterable` parameter are 
generally preferred over variadic methods.

A *variadic method* has a *variadic parameter* (or *sequenced parameter*) 
as the last parameter 
in the parameter list. This allows the method to be 
[invoked](../../expression/invocation) with the caller specifying zero or 
more arguments after the next-to-last argument.

Syntactically, variadic parameters are declared as a type name followed by 
star (`*`) (for a possibly empty `Sequential`) or plus (`+`) (for a non-empty 
`Sequence`) followed by the parameter name.

For example, a variadic method `variadic` declared like this

    void variadic(String s, Integer* i) {
        /* method body: statements 
           parameter i treated as an Integer[] */
    }

can be [invoked](../../expression/invocation) supplying a zero or more 
expressions for `i`, like this:

    variadic("hello");
    variadic("hello", 1);
    variadic("hello", 1, 2);
    variadic("hello", 1, 2, 3);

Within the method block a sequenced parameter declared as `T*` has 
type [`T[]`](../type#Sequence) and one declared `T+` has 
type [`Sequence<T>`](../type#Sequence).

#### Multiple parameter lists

Methods can be declared with multiple parameter lists. Here's an example:

    String name(String firstName)(String secondName) {
        return firstName + " " + secondName;
    }
    
This is equivalent to the higher-order method `String(String) name(String)`, 
that is a method which returns (when invoked with 
a single argument list) a `String(String)` callable reference which can be 
invoked again to produce a `String`. 

**Note**: Classes cannot be declared with multiple parameter lists.

