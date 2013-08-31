---
layout: reference
title: Type aliases
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A type alias declaration assigns a name to an arbitrary type expression.

## Usage 

    shared alias Number => Integer|Float|Decimal|Whole;
    alias BinaryOp<X,Y> => Boolean(X,Y);
    interface Dictionary => Correspondence<String,String>;
    class Strings => ArraySequence<String>;


## Description

A type alias provides a convenient way to abbreviate long type expressions which 
recur in a particular codebase. 
Because of type parameters, union and intersection types long type 
expressions are common in Ceylon code. 

### Forms

A class alias can be declared using `alias` or a `class` declaration 
using a fat arrow. Similarly an interface alias can be declared using 
`alias` or an `interface` declaration using a fat arrow.
To alias a union or intersection type you must use `alias` (since such types 
don't have declarations).

### Limitations

An alias may not appear in an `extends` or `satisfies` clause. 

An alias may not be instantiated.

### Relatated concepts

Type aliases are analogous to [method specifiers](../method#method_specifiers), 
except they operate  on types rather than values. 

The [`import` statement](../../statement/import) permits aliasing in a 
similar way.

## See also

* [type aliases in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#typealiasedeclarations)
