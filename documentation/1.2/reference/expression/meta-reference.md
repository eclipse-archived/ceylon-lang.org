---
layout: reference12
title_md: 'Meta references'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Meta references are a way to obtain models from 
[`ceylon.language.meta.model`](#{site.urls.apidoc_1_1}/meta/model/index.html)
and declarations from 
[`ceylon.language.meta.declaration`](#{site.urls.apidoc_1_1}/meta/declaration/index.html).

## Usage 

Obtaining models:

<!-- try: -->
    Class<String, [{Character*}]> cls = `String`;

    Constructor constr = `Class.Constructor`;
        
    Interface<{String*}> iface = `Iterable<String, Null>`;
    
    Function<Integer?, [{Integer*}]> func = `max<Integer, Null>`;
    
    Method<Integer, Integer, [Integer]> meth = `Integer.plus`;
    
    Value<Basic> val = `process`;
    
    Attribute<String, String> attr = `String.string`;
    
    UnionType<String|Integer> union = `String|Integer`;
    
    Type<Nothing(String)> intersection = `String(String)&Integer(String)`;

Obtaining declarations:

<!-- try: -->
    ClassDeclaration c = `class String`;
    
    ConstructorDeclaration ctor = `new Class.Constructor`;
    
    InterfaceDeclaration i = `interface Iterable`;
    
    FunctionDeclaration f = `function max`;
    
    FunctionDeclaration iterator = `function Iterable.iterator`;
    
    ValueDeclaration vm = `value process`;
    
    ValueDeclaration str = `value String.string`;
    
    Module m = `module ceylon.language`;
    
    Package p = `package ceylon.language`;
    
    class TypeParameterExample<Other>() {
        TypeParameter otherDecl = `given Other`;
    }

## Description

### Syntax

To obtain model references you just enclose the name of the thing you're refering to in 
backticks (`` ` ``). Type arguments are required for generic references.

To obtain declaration references you also need to use the relevant keyword for the declaration. 
That is, what you would use to declare the element you are referring to. 
Type arguments are not required (though not an error).

### Type

The type of a model reference depends on the thing being referred 
to, as detailed in 
[the spec](#{site.urls.spec_current}#typeofametamodelexpression).

The type of a declaration reference also depends on the thing 
being referred to, as detailed in 
[the spec](#{site.urls.spec_current}#typeofareferenceexpression).

## See also

* [Metamodel expressions](#{site.urls.spec_current}#metamodelexpressions) and
  [Reference expressions](#{site.urls.spec_current}#referenceexpressions) in 
  the Ceylon language specification

