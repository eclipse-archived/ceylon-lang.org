---
layout: reference
title: Callable references
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 2
doc_root: ../..
---

# #{page.title}

A callable reference is a reference that can be [invoked](../invocation).

## Usage 

An example [method reference](#method_references)

    Callable<String, Integer> methodRef = "".initial;
    
An example [initializer reference](#initializer_references)

    class Person(String name) {
        // ...
    }
    Callable<Person, String> initRef = Person;

## Description

### Method references

A method reference simply a reference to a method specified as if you were
going to invoke it but without the argument list.

The type of a method reference depends on the result type of the method,
the type of the receiver and the type of the parameters in the method's 
parameter list. For example a method `m` on a type `X` took
`Integer` and `Boolean` parameters and returned a `String` would have type:

<!-- check:none -->
    Callable<String, X, Integer, Boolean>

The general pattern for member methods is:

<!-- lang: none -->
    Callable<ResultType, ReceiverType, ParamType1, ParamType2, ..., ParamTypeN>

Or for top level methods:

<!-- lang: none -->
    Callable<ResultType, ParamType1, ParamType2, ..., ParamTypeN>

### Initializer references

A method reference simply a reference to a class initializer specified as if 
you were going to [instantiate](../instantation) it but without the 
argument list.

The type of an initializer reference depends on the class being referenced 
and the type of the parameters in its initializer's parameter list. 
For example if a class `C` has initializer parameters
`Integer` and `Boolean` then the initializer reference would have type:

<!-- check:none -->
    Callable<C, Integer, Boolean>

The general pattern is:

<!-- lang: none -->
    Callable<ClassType, ParamType1, ParamType2, ..., ParamTypeN>

### Use in method specifiers

It is common to use callable references when using 
[method specifiers](../../structure/method#method_specifiers).
 
For example if you have a factory method which actually just 
instantiated a particular class you could write:

    class C(String name) {
        // ...
    }
    C factoryMethod(String name) = C;

### Use in argument lists

You can pass callable references as arguments to methods 
expecting 
[`Callable`](#{site.urls.apidoc_current}/ceylon/language/interface_Callable.html)
arguments

### Use as return values

You can [`return`](../../statement/return) callable references from methods 
that return [`Callable`](#{site.urls.apidoc_current}/ceylon/language/interface_Callable.html) results.


## See also

* ceylond documentation of 
  [`Callable`](#{site.urls.apidoc_current}/ceylon/language/interface_Callable.html) 
