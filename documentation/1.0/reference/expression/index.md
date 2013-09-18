---
layout: reference
title: Expressions
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../..
---

# #{page.title}

An expression produce a value when executed. Complex expressions
may be constructed by recursively applying operators to simpler
expressions. Certain expressions are legal statements, called 
_expression statements_.

## Usage 

Expressions are built using the following constructs. 


### Literals

[`String`](#{site.urls.apidoc_current}/String.type.html) literals:

<!-- try: -->
    "hello, world"

[`Character`](#{site.urls.apidoc_current}/Character.type.html) literals:

<!-- try: -->
    'a'

['Integer'](#{site.urls.apidoc_current}/Integer.type.html) number literals:

<!-- try: -->
    1

[Floating point number](#{site.urls.apidoc_current}/Float.type.html) literals:

<!-- try: -->
    3.0
    
[Further information.](../#literals)

### String templates

<!-- try: -->
    "Hello ``name``, good ``timeOfDay(now)``!";
    
### Self and outer references 

Current instance reference:

<!-- try: -->
    this
    
Outer instance reference:

<!-- try: -->
    outer
    
Supertype reference

<!-- try: -->
    super

The type of `super` is the union of the direct superclass and superinterfaces 
of the class or interface. Most of the time this is unambiguous and super 
"just works". The typechecker will detect cases where multiple inheritance 
causes an ambiguity and you have to use `of` to specify the required supertype:

<!-- try: -->
    super of Foo
    
Containing package qualifier:

<!-- try: -->
    package

Note: `package` by itself is not an expression, but may be
used to qualify a reference.

### References

These are all [`Callable`](#{site.urls.apidoc_current}/Callable.type.html) expressions

<!-- try: -->
    print
    String
    String.size
    String.initial

### `Declaration` references

These evaluate to values of various subtypes of 
[`Declaration`](#{site.urls.apidoc_current}/meta/declaration/Declaration.type.html):

<!-- try: -->
    `class String`
    `interface Sequential`
    `function sum`
    `value true`
    `value List.size`
    `package ceylon.language`
    `module ceylon.language`


### Invocation

<!-- try: -->
    print("Hello");
    "hello world".initial(5)
    Entry("one", 1)
    
### Iterable and tuple enumeration

[`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html) enumeration:

<!-- try: -->
    {1, 2}
    
[`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html) enumeration:

<!-- try: -->
    [1, 2]

### Operators

<!-- try: -->
    x = 1
    2 + 2
    "hello world"[6..11]
    0<=x<10
    names.empty || !enabled

[Further information.](../#operators)


## Description

The Ceylon compiler checks expressions for type safey at compile time.

## See also

