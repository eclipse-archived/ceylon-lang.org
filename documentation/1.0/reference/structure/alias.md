---
layout: reference
title: aliases
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Usage 

A type alias:

    alias BasicType = String|Character|Integer|Float|Boolean;
    
An `interface` alias:

    interface Strings => Collection<String>;
    
A `class` alias:

    class Identifier({Character*} characters) => String(characters);

## Description

Aliases provide a way giving another name to a type or declaration. The different kinds of alias have different semantics.

### Type alises

A type alias is simply another name for a given type. 
Type alias are usually used to avoid having to repeat long or complex type expressions. 
They are not declarations, as such, and are not reified, so you cannot import a type alises from another module, for example. 
Instead the aliases are simply resolved recursively at compile time. 

### Interface aliases

Unlike [type aliases](#type_alias), `interface` interfaces *are* declarations and are reified, 
so they can be imported from other modules, and exist in the metamodel.

You cannot use `interface` alias for a `class`: It must be aliasing an `interface`. 

### Class aliases

Class aliases are similar to [interface aliases](#interface_aliases), can but also be used in [instantiation](../../expression/instantiation) expressions. 

Unlike [type aliases](#type_alias), `class` interfaces *are* declarations and are reified, 
so they can be imported from other modules, and exist in the metamodel.

You cannot use `class` alias for a `interface`: It must be aliasing a `class`.

### Metamodel

Type aliases can be manipulated at runtime via their representation as
[`AliasDeclaration`](#{site.urls.apidoc_current}/meta/declaration/AliasDeclaration.type.html) 
instances. There is no corresponding model interface.

Class and interface aliases TODO

## See also

* [type aliases](#typealiaselimination) in the spec.
* [`interface` aliases](#interfacealiases) in the spec.
* [`class` aliases](#classaliases) in the spec.
* [`import`](../statement/import) statements allow the imported declaration to be renamed within 
  the compilation unit. This is usually called an *import alias*.
