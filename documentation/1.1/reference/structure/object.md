---
layout: reference11
title_md: object
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An `object` declaration is an anonymous [class](../class) that is 
implicitly instantiated
exactly once at the place it is defined, and nowhere else. As such it 
is also a [value](../value).

## Usage 

A trivial `object` declaration looks like this:

<!-- try: -->
    object o {
        /* declarations of object members */
    }

## Description

### Type parameters and parameters

An `object` declaration does not have parameters or type parameters 
(just like a [value](../value)).

### Notation

This reference uses `object` (in a monospaced font) when discussing an 
`object` declaration, which is the subject of this page. A class instance 
may be referred to as an object (in the usual font). In other contexts we 
often use the term _anonymous class_.

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

### Members

The permitted members of `object`s are [classes](../class), 
[interfaces](../interface), [methods](../function), [attributes](../value),
and [`object`s](../object).

## See also

* [Anonymous classes](#{site.urls.spec_current}#anonymousclasses) in the Ceylon 
  language spec
