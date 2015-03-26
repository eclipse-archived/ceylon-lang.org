---
layout: reference12
title_md: Value and attribute declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

There are two kinds of _value_:

- A _reference_ holds state, that is, a reference to another object.
- A value defined as a getter (with, optionally, a matching setter)
  does not directly hold state, instead it defines how a "derived" 
  value is computed.

Crucially, users of the value cannot distinguish a 
reference value from a getter value.

When a value is a member of a type, is it called an _attribute_.

## Usage 

A trivial reference:

    String trivalReference = "Alice";

A trivial getter:

    String trivialSpecifiedGetter => "Bob";


A trivial getter and setter:

    Integer trivialValueWithBlock {
        return i+10;
    }
    assign trivialValueWithBlock {
        i = trivialValueWithBlock-10;
    }
    
The setter uses the `assign` keyword, and has the same name as the 
corresponding getter.

The general form of a value can look like any of these:

<!-- lang:none -->
    ANNOTATIONS
    TYPE exampleReference = INITIAL-EXPRESSION;
    // or
    ANNOTATIONS
    TYPE exampleGetterSpecified => GETTER-EXPRESSION;
    // or
    ANNOTATIONS
    TYPE exampleGetterBlock {
        GETTER-BODY
    }
    // or
    ANNOTATIONS
    TYPE exampleGetterBlock {
        GETTER-BODY
    }
    assign exampleGetterBlock {
        SETTER-BODY
    }

Where:

* `ANNOTATIONS` is a list of value [annotations](../annotation)
* `TYPE` is a [type expression](../type) for the [type the reference](#value_type) returned when the value is evaluated
* `INITIAL-EXPRESSION` is the intial value of the reference
* `GETTER-EXPRESSION` is the [specified value](#function_specifiers) of the getter
* `GETTER-BODY` is a [block](#function_blocks) of statements
* `SETTER-BODY` is a [block](#function_blocks) of statements


## Description

### Value type

A non-local value declaration always specifies the *type* of the value.

#### Type inference

Local value and attribute declarations don't need to explictly declare a type, 
but can instead use [type inference](../type-inference) via the `value` 
keyword.

<!-- try: -->
    void f() {
        value string = ""; //inferred type String
    }

### Reference values

Reference values are just holders of state. 

A toplevel reference represents a "global constant" (or variable).

A reference attribute declared within a 
class body represents state associated with an instance of the class 
(similar to a *field* in other programming languages). 

A local reference (that is, a reference declared within a block) represents state 
associated with execution of that block (similar to a *local variable* 
in other programming languages).

Reference values are computed when the value is specified or assigned
and the exact same instance returned thereafter 
(unless the value is `variable` and is reassigned). 

#### `variable` reference values

If a reference value is annotated [`variable`](#{site.urls.apidoc_1_1}/index.html#variable), 
it can be [assigned](#{page.doc_root}/reference/operator/assign) more than once.
Otherwise it must be [specified](../../statement/specification) exactly once. 

The specification or assignment must occur before its first use.

### Getters

A getter defines a derived value that is computed every time the 
value is required (unlike a reference value).

From the point of view of the code evaluating a value, it is impossible to 
determine whether the value is implemented as a reference or as a getter. 
It's even possible to refine a reference with a getter, or vice versa.

Like [function declarations](../function), you can either use a 
block of statements or the *fat arrow*
(`=>`) syntax if the value can be computed from a single expression.

### Setters

A setter defines what to do when a derived variable value is assigned.

From the point of view of the code assigning a value, it is impossible to 
determine whether the value is implemented as a reference or as a setter. 
It's even possible to refine a `variable` reference with a getter/setter
pair, or vice versa.

Every setter must have a corresponding getter with the same name. 

The getter declaration must occur earlier in the body containing the 
setter declaration.

### Attribute receiver

Attribute evaluations have a 'receiver', an instance of the type that 
declares the method. Within the getter or setter body, the expression 
[`this`](../../expression/this) refers to this receiving 
instance.

A [top level](../type-declaration#top_level_declarations) value does not have a 
receiver.


### Different kinds of value

#### `late` values

A value can be declared [`late`](../../annotation/late/) in which case the 
typechecker's [definite specification](../../annotation/late/#description) 
checks are not performed. 

#### `formal` and `default` attributes

An attribute declaration may be annotated [`formal`](../../annotation/formal)
or [`default`](../../annotation/default). A formal or default attribute must 
also be annotated `shared`.

A formal attribute does not specify an implementation. A formal attribute 
must be refined by concrete classes which inherit the containing class or 
interface. 

A `default` attribute may be refined by types which inherit the containing 
class or interface. 

#### `shared` values

A toplevel value declaration, or a value declaration nested inside the 
body of a containing class or interface, may be annotated 
[`shared`](../../annotation/shared).

- A toplevel `shared` value is visible wherever the package that contains it 
  is visible.
- A `shared` value nested inside a class or interface is visible wherever the 
  containing class or interface is visible.

### Metamodel

Value declarations can be manipulated at runtime via their representation as
[`ValueDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/ValueDeclaration.type.html) 
instances. An *applied function* (i.e. with all type parameters specified) corresponds to 
either a 
[`Value`](#{site.urls.apidoc_1_1}/meta/model/Value.type.html) or 
[`Attribute`](#{site.urls.apidoc_1_1}/meta/model/Attribute.type.html) model instance.

## See also

* [Compilation unit](../compilation-unit)
* [`class` declarations](../class)
* [`interface` declarations](../interface)
* [`object` declarations](../object)
* [Values](#{site.urls.spec_current}#values) in the Ceylon language spec

