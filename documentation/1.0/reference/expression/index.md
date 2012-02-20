---
layout: reference
title: Expressions
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

Expressions are a kind of [statement](../#statements) which have a type and 
when executed produce a value.

## Usage 

The following statements are all expression statements:

    "hello, world" // literal expression
    this; // self-reference
    TODO // metamodel reference
    TODO // callable reference
    process.writeLine("hello"); // method invocation
    process.writeLine{ // method invocation
        line="hello";
    };
    MyClass(); // instantiation
    process.arguments; // attribute evaluation
    TODO // attribute assignment
    1 + 2; // operator expression

## Description

The Ceylon compiler checks expressions for type safey at compile time.

## See also

* [Operators](../#operators)
* [Literals](../#literals)
