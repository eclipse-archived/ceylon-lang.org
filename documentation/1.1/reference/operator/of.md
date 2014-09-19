---
layout: reference
title_md: '`of` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, binary infix `of` operator is used to cast 
the type of an expression, when this can be statically proven to 
be safe.

## Usage 

<!-- try: -->
    void m(Anything obj) {
        Object|Null maybeNull = obj of Object|Null;
    }

## Description

According to the language specification, the `of` operator:

> ... narrows or widens the type of an expression to any  specified type 
> that covers the expression type.

### Definition

The `of` operator is primitive.

### Polymorphism

The `of` operator is not [polymorphic](#{page.doc_root}/tour/language-module/#operator_polymorphism). 

### Type

The result type of the `of` operator is of the given type.

### Note

* This is not an unsafe typecasting operator familiar in most other
  programming languages. If an expression involving `of` is accepted
  by the compiler, it will never result in a typing exception at
  runtime.

## See also

* [Coverage](#{site.urls.spec_current}#coverage) in the language 
  specification

