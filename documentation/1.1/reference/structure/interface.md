---
layout: reference11
title_md: Interfaces
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An interface is a stateless type that, unlike a [class](../class):

- may not hold references to other objects,
- does not define initialization logic, and 
- cannot be directly instantiated.

Interfaces support a more flexible inheritance model: _multiple inheritance_.
"Diamond" inheritance is not a problem for interfaces, because interfaces 
don't have state or logic to initialize that state.

## Usage 

A trivial interface declaration looks like this:

<!-- try: -->
    interface I {
        /* declarations of interface members */
    }

Since interfaces don't contain initialization logic, there's no parameter 
list after the interface name as there would be in a [class declaration](../class).

## Description

### Satisfying interfaces

The `satisfies` keyword specifies the interfaces inherited by an 
interface:

<!-- cat: interface I1{} interface I2{} -->
<!-- try: -->
    interface I satisfies I1 & I2 {
        /* declarations of interface members */
    }

If an interface is declared without using the `satisfies` keyword, 
it does not directly inherit any interfaces. However, _all_ 
interfaces are considered to inherit the class
[`Object`](#{site.urls.apidoc_1_1}/Object.type.html).

`&` is used as the separator between satisfied interfaces because 
`I` is being defined as a subtype of the 
[intersection type](../type#intersection_types) `I1&I2`.

### Enumerated interfaces

The subclasses of an enumerated interface can be constrained to a 
list of named interfaces, classes, or toplevel anonymous classes 
using the `of` clause. If the interface `I` is permitted only two 
direct subtypes, the interface `I1`, and the class `C1`, its 
declaration would look like this:

<!-- cat: interface I1 satisfies I {} class C1() satisfies I {} -->
<!-- try: -->
    interface I of I1 | C1 {
        /* declarations of interface members */
    }

### Generic interfaces

An _generic_ interface declaration lists [type parameters](../type-parameters) 
in angle brackets (`<` and `>`) after the interface name. 

<!-- try: -->
    interface I<Z> {
        /* declarations of interface members 
           type parameter Z treated as a type */
    }

An interface declaration with type parameters may have a `given` 
clause for each declared type parameter to 
[constrain the argument types](../type-parameters#constraints).

### `shared` interfaces

A toplevel interface declaration, or an interface declaration nested 
inside the body of a containing class or interface, may be annotated 
[`shared`](../../annotation/shared):

<!-- try: -->
    shared class C() {
        /* declarations of class members */
    }

- A toplevel `shared` interface is visible wherever the package that 
  contains it is visible.
- A `shared` interface nested inside a class or interface is visible 
  wherever the containing class or interface is visible.

### Members

The permitted members of interfaces are [classes](../class), 
[interfaces](../interface), [methods](../function), and 
[attributes](../value).

Note that an interface cannot have an [`object`](../object) member.

### Aliases

An *interface alias* is a kind of [alias](../alias#interface_aliases).

### Metamodel

Interface declarations can be manipulated at runtime via their representation as
[`InterfaceDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/InterfaceDeclaration.type.html) 
instances. An *applied interface* (i.e. with all type parameters specified) corresponds to 
either an 
[`Interface`](#{site.urls.apidoc_1_1}/meta/model/Interface.type.html) or 
[`MemberInterface`](#{site.urls.apidoc_1_1}/meta/model/MemberInterface.type.html) model instance.

## See also

* [Classes](../class)
* [Interfaces](#{site.urls.spec_current}#interfaces) in the Ceylon 
  language spec

