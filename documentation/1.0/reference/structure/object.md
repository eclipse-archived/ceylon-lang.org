---
layout: reference
title: object
tab: documentation
unique_id: docspage
author: Tom Bentley
toc: true
---

# #{page.title}

An `object` declaration is an anonymous [class](../class) that is 
implicitly [instantiated](../../expression/class-instantiation)
exactly once at the place it is defined, and nowhere else. As such it 
functions as a [value](../value).

#{page.table_of_contents}

## Usage 

A trivial `object` declaration looks like this:

<!-- try: -->
    object o {
        /* declarations of object members */
    }

## Description

### Type parameters and parameters

An `object` declaration does not specify parameters or type parameters.

### Notation

This reference uses `object` (in a monospaced font) when discussing an `object`
declaration, which is the subject of this page. A class instance may be 
referred to as an object (in the usual font).

### Constraints

### Parent declaraions

`object` declarations are not permitted as members of 
[interfaces](../interface), since `objects` are implicitly stateful 
(the state being the instance).

### Shared `object`s

Because an `object` declaration is simultaneously defining and instantiating an 
anonymous class it can have the same annotations as an 
[value](../value).

### Metamodel

[`ClassDeclaration.anonymous`](#{site.urls.apidoc_current}/meta/declaration/ClassDeclaration.type.html#anonymous) 
can be used to determine whether a given `ClassDeclaration` represents an anonymous class. 

The instance is a [value](../value), so can be manipulated 
[`ValueDeclaration`](#{site.urls.apidoc_current}/meta/declaration/ValueDeclaration.type.html) and 
[`Value`](#{site.urls.apidoc_current}/meta/model/Value.type.html) or 
[`Attribute`](#{site.urls.apidoc_current}/meta/model/Attribute.type.html).

### Members

The permitted members of `object`s are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
[attributes](../attribute)
and [`object`s](../object).

## See also


