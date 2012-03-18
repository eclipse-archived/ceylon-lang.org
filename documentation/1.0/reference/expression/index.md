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

<!-- cat: String name = ""; -->
    String greeting = "Hello " name "";
    
### [`this`](this)

<!-- cat: class C() { String attr = ""; void m() { -->
    String attr = this.attr;
<!-- cat: }} -->
    
### [`outer`](outer) <!-- m3-->

<!-- check:none -->
    outer.m();
    
### [`super`](super)

<!-- check:none -->
    super.m();
    
### [Metamodel reference](metamodel-reference) <!-- m5-->

<!-- check:none -->
    Type<String> stringType = String;
    Class<String> stringClass = String;
    Method<String, String, Integer> initialMethod = String.initial;
    Attribute<String, Integer> size = String.size;

### [Class instantiation](class-instantiation)

<!-- cat: class Person(String name) {} -->
    Person tom = Person("Tom");

### [Sequence instantiation](sequence-instantiation)

    Integer[] seq = {1, 2};

### [Method Invocation](invocation)

<!-- cat: void m() { -->
    process.writeLine("hello");
    process.writeLine{
        line="hello";
    };
<!-- cat: } -->
    
### [Callable reference](callable-reference)

<!-- cat: void m() { -->
    function f(String line) = process.writeLine;
<!-- cat: } -->

### [Attribute Evaluation](attribute-evaluation)

<!-- cat: object greeter { shared String greeting = ""; } -->
    String greeting = greeter.greeting;
    
### [Attribute Assignment](attribute-assignment)

<!-- cat: void m() { -->
<!-- cat: variable String greeting; -->
    greeting := "howdy";
<!-- cat: } -->
    
### [Operators](../#operators)

    Integer s = 1 + 2;

## Description

The Ceylon compiler checks expressions for type safey at compile time.

## See also

