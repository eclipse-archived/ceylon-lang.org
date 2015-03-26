---
layout: reference12
title_md: Interface Declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An interface is a stateless [type declaration](../type-declaration) that, unlike a [class declaration](../class):

- may not hold references to other objects,
- does not define initialization logic, and 
- cannot be directly instantiated.

Interfaces support a more flexible inheritance model: _multiple inheritance_.
"Diamond" inheritance is not a problem for interfaces, because interfaces 
don't have state or logic to initialize that state.

## Usage 

A trivial interface declaration looks like this:

<!-- try: -->
    interface Trivial {
        /* declarations of interface members */
    }

The general form of an interface declaration looks like this:

<!-- lang:none -->
    ANNOTATIONS
    interface Example
            <TYPE-PARAMETERS>
            of ENUMERATED-SUBINTERFACES
            satisfies SUPER-INTERFACES
            given TYPE-PARAMETER-CONSTRAINTS {
        INTERFACE-BODY
    }

Where:

* `ANNOTATIONS` is a list of interface [annotations](../annotation)
* `TYPE-PARAMETERS` is a `,`-separated list of [type parameters](#type_parameters)
* `ENUMERATED-SUBINTERFACES` is a `|`-separated list of [interface types](#enumerated_classes)
* `SUPER-INTERFACES` is a `&`-separated list of [interface type expressions](#satisfying_interfaces)
* `TYPE-PARAMETER-CONSTRAINTS` is a list of [constraints on type parameters](../type-parameters#constraints) 
  declared in the type parameter list
* `INTERFACE-BODY` is the [declaration section](#declaration_section) of the interface

Due to the stateless nature of interfaces, their declarations have:

* no parameter list after the interface name (as there is in a [class declaration](../class)).
* no `extends` clause
* no initializer section in the interface body: It contains only member declarations.

## Description

### Type parameters

An interface may have a list of [type parameters](../type-parameters) 
enclosed in angle brackets (`<` and `>`) after the interface name. 

<!-- try: -->
    interface Generic<Foo, Bar> {
        /* declarations of interface members 
           type parameters Foo and Bar are treated as a types */
    }

An interface with type parameters is sometimes called a *generic interface*.

An interface declaration with type parameters may also have a `given` clause 
for each declared type parameter to 
[constrain the argument types](../type-parameters#constraints):

    interface Constrained<Foo, Bar>
            given Foo satisfies Baz1&Baz2
            given Bar of Gee1|Gee2 {
        /* declarations of interface members 
           type parameters Foo and Bar treated as a types */
    }

### Satisfying interfaces

The `satisfies` clause is used to specify that the interface being declared is a
[subtype](../type-declaration#declarative_subtyping) 
of the given interface type.

<!-- cat: interface I1 {} interface I2 {} -->
<!-- try: -->
    interface I satisfies I1 & I2 {
        /* declarations of class members */
    }

`&` is used as the separator between satisfied interface types 
because the interface (`I`) is being declared as a subtype of an 
[intersection type](../type#union_and_intersection) (`I1&I2`).

If an interface is declared without using the `satisfies` keyword, 
it does not directly inherit any interfaces. However, _all_ 
interfaces are considered to inherit the class
[`Object`](#{site.urls.apidoc_1_1}/Object.type.html).

### Enumerated interfaces

The subtypes of an enumerated interface can be constrained to a 
list of named interfaces, classes, or toplevel anonymous classes 
using the `of` clause. If the interface `I` is permitted only two 
direct subtypes, the interface `I1`, and the class `C1`, its 
declaration would look like this:

<!-- cat: interface I1 satisfies I {} class C1() satisfies I {} -->
<!-- try: -->
    interface I of I1 | C1 {
        /* declarations of interface members */
    }
    
Then `I1` and `I2` are called the *cases* of `I`.

### Declaration section

### Members

The permitted members of interfaces are [classes](../class), 
[interfaces](../interface), [methods](../function), and 
[attributes](../value).

Note that an interface cannot have an [`object`](../object) member.

### Different kinds of interface

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

### `sealed` interfaces

An interface declaration can be annotated `sealed` which prevents 
the declaration of subclasses and subinterfaces outside the module 
in which the sealed interface is declared. This provides a way to 
share an interface's type with other modules.

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

* [Class declarations](../class)
* [Interfaces](#{site.urls.spec_current}#interfaces) in the Ceylon 
  language spec

