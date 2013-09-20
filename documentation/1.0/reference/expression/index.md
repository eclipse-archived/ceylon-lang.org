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

[`String` literals](../literal/string/):

<!-- try: -->
    "hello, world"

[String templates](string-template):

<!-- try: -->
    "Hello ``name``, good ``timeOfDay(now)``!";

[`Character` literals](../literal/character/):

<!-- try: -->
    'a'

[`Integer` literals](../literal/integer/):

<!-- try: -->
    1

[Floating point literals](../literal/float/):

<!-- try: -->
    3.0


    
### Self and outer references 

Current instance reference ([`this`](this/)):

<!-- try: -->
    this
    
Outer instance reference ([`outer`](outer/)):

<!-- try: -->
    outer
    
Supertype reference ([`super`](super/)):

<!-- try: -->
    super

The type of `super` is the union of the direct superclass and superinterfaces 
of the class or interface. Most of the time this is unambiguous and super 
"just works". The typechecker will detect cases where multiple inheritance 
causes an ambiguity and you have to use `of` to specify the required supertype:

<!-- try: -->
    super of Foo
    
Containing [package qualifier](package/):

<!-- try: -->
    package

### References

These are [callable references](callable-reference) references

<!-- try: -->
    print
    String
    
These are [static references](static-reference)
    
    String.size
    String.initial

### Model references

These are [model references](meta-reference):

<!-- try: -->
    `String`
    `Sequential<String>`
    `max<Integer, Null>`
    `true`
    `List<Integer>.size`

### Declaration references

These are [declaration references](meta-reference):

<!-- try: -->
    `class String`
    `interface Sequential`
    `function sum`
    `value true`
    `value List.size`
    `package ceylon.language`
    `module ceylon.language`


### Invocation

[Positional invocations](invocation):

<!-- try: -->
    print("Hello");
    "hello world".initial(5)
    Entry("one", 1)
    
[Named argument invocations](invocation):

<!-- try: -->
    print{
        val = "Hello";
    };
    "hello, world".initial{
        length = 2;
    };
    Entry{
        item = 1;
        key = "one";
    };
    
### Iterable and tuple enumeration

[`Iterable` enumeration](iterable):

<!-- try: -->
    {1, 2}
    
[`Tuple` enumeration](tuple):

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

