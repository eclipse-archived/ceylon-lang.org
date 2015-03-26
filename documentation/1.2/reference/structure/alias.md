---
layout: reference11
title_md: Type aliases
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A type alias assigns a name to a type expression. 

## Usage 

A type alias:

<!-- try: -->
    alias BasicType => String|Character|Integer|Float|Boolean;

A generic type alias:

<!-- try: -->
    alias ListOrMap<Element> => List<Element>|Map<Integer,Element>;

An `interface` alias:

<!-- try: -->
    interface Strings => Collection<String>;
    
A `class` alias:

<!-- try: -->
    class Identifier({Character*} characters) => String(characters);

## Description

Type aliases allow us to avoid having to repeat long or complex type 
expressions. 

Type aliases are not type declarations as such, and are not reified at 
runtime. Instead, a type alias is replaced (recursively) by its definition 
as part of the compilation process. 

The different kinds of alias declaration have slightly different semantics, 
affecting where the alias can appear:

- an interface alias may appear anywhere an interface type may appear,
- a class alias may appear anywhere a class type may appear, and
- a type alias declared using the keyword `alias` may only appear where 
  an arbitrary type expression may appear.

### Metamodel

Type aliases can be manipulated at runtime via their representation as
[`AliasDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/AliasDeclaration.type.html) 
instances. There is no corresponding model interface.

Class and interface aliases are treated as normal classes and interfaces,
therefore their declarations are
[`ClassDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/ClassDeclaration.type.html)
and
[`InterfaceDeclaration`](#{site.urls.apidoc_1_1}/meta/declaration/InterfaceDeclaration.type.html).
The 
[`ClassOrInterfaceDeclaration.isAlias`](#{site.urls.apidoc_1_1}/meta/declaration/ClassOrInterfaceDeclaration.type.html#isAlias) 
attribute is used to distinguish aliases from normal classes and interfaces.
The corresponding models are
[`Class`](#{site.urls.apidoc_1_1}/meta/model/Class.type.html)
and
[`Interface`](#{site.urls.apidoc_1_1}/meta/model/Interface.type.html).

## See also

* [Type alias elimination](#{site.urls.spec_current}#typealiaselimination),
  [Type aliases](#{site.urls.spec_current}#typealiases),
  [Interface aliases](#{site.urls.spec_current}#interfacealiases), and
  [Class aliases](#{site.urls.spec_current}#classaliases) in the Ceylon
  language specification
* [`import`](../../statement/import) statements allow the imported 
  declaration to be renamed within the compilation unit. This is 
  usually called an *import alias*.
