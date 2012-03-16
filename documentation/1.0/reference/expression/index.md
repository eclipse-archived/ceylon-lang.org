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

Expressions are a kind of [statement](../#statements) which have a type and 
produce a value when executed.

## Usage 

The following statements each demonstrate an expression statement:

### [Literals](../#literals)

    String greeting = "hello, world";
    Character a = `a`;
    Integer one = 1;
    Float three = 3.0;
    
### [String templates](string-template)

    String greeting = "Hello " name "";
    
### [`this`](this)

    String attr = this.attr;
    
### [`outer`](outer) <!-- m3-->

    outer.m();
    
### [`super`](super)

    super.m();
    
### [Metamodel reference](metamodel-reference) <!-- m5-->

    Type<String> stringType = String;
    Class<String> stringClass = String;
    Method<String, String, Integer> initialMethod = String.initial;
    Attribute<String, Integer> size = String.size;

### [Class instantiation](class-instantiation)

    Person tom = Person("Tom");

### [Sequence instantiation](sequence-instantiation)

    {1, 2};                     // sequence instantiation

### [Method Invocation](invocation)

    process.writeLine("hello"); // method invocation
    process.writeLine{          // method invocation
        line="hello";
    };
    
### [Method reference](method-reference)

    process.writeLine;

### [Attribute Evaluation](attribute-evaluation)
    
    String greeting = greeter.greeting;
    
### [Attribute Assignment](attribute-assignment)

    greeting := "howdy";
    
### [Operators](../#operators)

    1 + 2;

## Description

The Ceylon compiler checks expressions for type safey at compile time.

## See also

