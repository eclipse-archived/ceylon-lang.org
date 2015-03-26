---
layout: reference12
title_md: Parameters
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A function or class initializer has a *parameter list* declaring the parameters 
of the function or class. A parameter list may contain zero or more *parameters*.

## Usage

You have the choice between 'inline' style:

<!-- try: -->
    class Example(Integer int, String name) {
    }
    
    void example(Integer int, void print(String name)) {
    }

And 'reference' style:

<!-- try: -->
    class Example(int, name) {
        Integer int;
        String name;
    }
    
    void example(int, print) {
        Integer int;
        void print(String name);
    }

The second style is preferred when the parameters are annotated.

## Description

### Parameter lists

Syntactically, a parameter list is a comma separated list enclosed in parentheses 
following the [type parameter list](../type-parameters). Each parameter is either:

- zero or more annotations, a type expression, a name, and, optionally, a 
  one or more parameter lists, or
- a reference to a value or function declaration in the class or function body 
  that follows.

A parameter with its own parameter list is called a _callable parameter_, and
its type is a function type. A function with no parameter list is called a
_value parameter_.

#### Defaulted parameters

A default argument for a parameter may be specified. 

For a value parameter, the default argument expression follows the parameter 
name, separated with an equals sign:

<!-- try: -->
    void example(Integer int, 
            String name = int==0 then "zero" else "") {
    }

For a callable parameter, the default argument expression follows the 
parameter's parameter list, separated with a fat arrow (`=>`):

    void example(String name(Integer int) 
            => int == 0 then "zero" else "") {
    }

A defaulted parameter allows the function or class to be 
[invoked](../../expression/invocation) without an argument for that parameter. 

Parameters with default values may be called  *optional parameters* (not to be confused with an *optional type* `T?`) or 
*defaulted parameters*. Parameters without default values may be called
*required parameters*. The default argument expression may be called the 
*default argument*.

To avoid ambiguity, defaulted parameters are only permitted after all the 
required parameters in the parameter list.

#### Variadic methods (and 'varargs')

**Note:** In Ceylon, functions which accept an `Iterable` parameter are 
generally preferred over variadic functions, since `Iterable`s may be 
evaluated lazily by the called function or class, whereas the arguments 
to a variadic parameter must be evaluated and packaged into a sequence 
before the function or class is called.

A *variadic function* has a *variadic parameter* as the last parameter 
in the parameter list. 

There are two different kinds of variadic parameter:

* _Possibly-empty variadic parameters_ allow the function or class to be 
  [invoked](../../expression/invocation) with the caller specifying zero 
  or more arguments for that parameter. Syntactically, a possibly-empty 
  variadic parameter is declared with a type expression followed by an
  asterisk, `*`, and then the parameter name.
  From within the function or class the parameter has the type [`T[]`](../type-declaration#Sequential).
  A possibly-empty variadic parameter's default argument is implictly 
  the empty sequence `[]`.
* _Nonempty variadic parameters_ allow the function or class to be
  [invoked](../../expression/invocation) with the caller specifying one 
  or more arguments for that parameter.  Syntactically, non-empty 
  variadic parameters are declared with a type expression followed by a 
  plus sign, `+`, and then the parameter name.
  From within the function or class the parameter has the type [`[T+]`](../type-declaration#Sequence).
  A nonempty variadic parameter doesn't have a default argument, and so
  none of the preceding parameters may be [defaulted](#defaulted_parameters).

For example

<!-- try: -->
    void variadic(String string, Integer* ints) {
        /* method body: statements 
           parameter ints has type Integer[] here */
    }

<!-- try: -->
    void nonemptyVariadic(String+ strings) {
        /* method body: statements 
           parameter strings has type [String+] here */
    }

### Invocation

When a reference to the function or class is the primary of an
[invocation](../../expression/invocation), the caller supplies an 
either a [positional argument list](../../expression/positional-argument-list)
or a [named argument list](../../expression/named-argument-list) 
whose type, expressed 
in terms of [`Tuple`](#{site.urls.apidoc_1_1}/Tuple.type.html),
must be a subtype of the type of the parameter list, also expressed 
as a tuple type.

### Multiple parameter lists

A function can have multiple parameter lists. A function with multiple
parameters lists is equivalent to a function with one parameter list
that returns a function.

Here's an example:

<!-- try: -->
    String name(String firstName)(String secondName) {
        return firstName + " " + secondName;
    }
    
This is equivalent to the following higher-order function that returns
an anonymous function:

    String(String) name(String firstName) 
            => (String secondName) {
                return firstName + " " + secondName;
            };

**Note**: A class may not have multiple parameter lists.

## See also

* [Type parameters](../type-parameters)
* [`class` declaration](../class)
* [`function` declaration](../function/) 
* [Parameters](#{site.urls.spec_current}#parameters) in the Ceylon 
  language spec

