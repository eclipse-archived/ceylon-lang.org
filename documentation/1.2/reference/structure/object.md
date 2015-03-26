---
layout: reference11
title_md: object
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An `object` declaration is an anonymous [class](../class) 
whose type is implicitly constructed and 
that is implicitly instantiated
exactly once at the place it is defined, and nowhere else. As such it 
is also a [value](../value).

**Note:** This reference uses `object` (in a monospaced font) when discussing an 
`object` declaration, which is the subject of this page. A class instance 
may be referred to as an object (in the usual font). In other contexts we 
often use the term _anonymous class_.

## Usage 

A trivial `object` declaration looks like this:

<!-- try: -->
    object trivial {
        /* declarations of object members */
    }
    
The general form of an object declaration looks like this:

<!-- lang:none -->
    ANNOTATIONS
    object example
            of ENUMERATED-SUBCLASSES
            extends SUPER-CLASS-INVOCATION
            satisfies SUPER-INTERFACES {
        CLASS-BODY
    }

Where:

* `ANNOTATIONS` is a list of class [annotations](../annotation)
* `SUPER-CLASS-INVOCATION` is [class invocation expression](#extending_classes) for the superclass initializer
* `SUPER-INTERFACES` is a `&`-separated list of [interface type expressions](#satisfying_interfaces)
* `CLASS-BODY` is the [initializer section](#initializer) of the `object`, 
  followed by the [declaration section](#declaration_section) of the `object`

Due to the dual type/value nature of `object`s their declarations have:

* no type parameters (because the type is instantiated implcitly),
* no initializer parameters (because the value is initialized implicitly),
* no enumerated subtypes (because `object` classes cannot be extended).
* no `given` clauses (because there are no type parameters to constrain)
  
## Description

### Extending classes

An `object` is a kind of `class` declaration, so the remarks about the 
[`extends` clause](../class/#extending_classes) of `class` declarations apply equally to `object`s.

Because the type of an `object` declaration is not *denotable* it
is impossible to extends an `object` declaration.

### Satisfying interfaces

An `object` is a kind of `class` declaration, so the remarks about the 
[`satisfies` clause](../class/#satisfying_interfaces) of `class` declarations apply equally to `object`s.

### Initializer

An `object` is a kind of `class` declaration, so the remarks about the 
[initializer](../class/#initializer) of `class` declarations apply equally to `object`s.

### Declaration section

An `object` is a kind of `class` declaration, so the remarks about the 
[declaration section](../class/#declaration_section) of `class` declarations apply equally to `object`s.

#### Members

The permitted members of `object`s are [classes](../class), 
[interfaces](../interface), [methods](../function), [attributes](../value),
and [`object`s](../object).

#### Different kinds of object

### Toplevel objects

A toplevel object is a _singleton_, so there is only one 
instance within the executing program.

### Nested objects

An `object` declaration may occur inside the body of a class, function, 
or value declaration. In this case, a new instance of the `object` is
instantiated each time the body is executed.

An `object` declaration may not occur in the body of an 
[interface](../interface), since `object`s are implicitly stateful (the 
state being the reference to the instance itself).

### Shared objects 

An object may be annotated [`shared`](../../annotation/shared), meaning
it is visible outside the scope in which its declaration occurs.

### Actual objects

An object may be annotated [`actual`](../../annotation/actual), meaning 
that it refines an attribute of a supertype of the class or interface
to which it belongs.

### Metamodel

[`ClassDeclaration.anonymous`](#{site.urls.apidoc_1_1}/meta/declaration/ClassDeclaration.type.html#anonymous) 
can be used to determine whether a given `ClassDeclaration` represents an anonymous class. 

The instance is a [value](../value), so can be manipulated 
[`ValueDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/ValueDeclaration.type.html) and 
[`Value`](#{site.urls.apidoc_1_1}/meta/model/Value.type.html) or 
[`Attribute`](#{site.urls.apidoc_1_1}/meta/model/Attribute.type.html).


## See also

* [Anonymous classes](#{site.urls.spec_current}#anonymousclasses) in the Ceylon 
  language spec
