---
layout: reference
title: Expressions
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
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

String literals:

<!-- try: -->
    "hello, world"

Character literals:

<!-- try: -->
    'a'

Integer number literals:

<!-- try: -->
    1

Floating point number literals:

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
    
Superclass reference

<!-- try: -->
    super
    
Containing package qualifier:

<!-- try: -->
    package

Note: `package` by itself is not an expression, but may be
used to qualify a reference.

### References

<!-- try: -->
    print
    String
    String.size
    String.initial

### Invocation

<!-- try: -->
    print("Hello");
    "hello world".initial(5)
    Entry("one", 1)
    
### Iterable and tuple enumeration

Iterable enumeration:

<!-- try: -->
    {1, 2}
    
Tuple enumeration:

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

