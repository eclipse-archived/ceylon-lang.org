---
layout: reference12
title_md: '`object`' expression
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

An `object` expression allows the declaration of an anonymous `object` 
within a declaration.

## Usage 

An example of an `object` expression being used in a `return` statement:

    return object extends Foo() satisfies Bar {
        // ...
    };
    

## Description

An object expression is basically a shorthand for a local 
[`object` declaration](../../structure/object). The example above could 
have been written:

    object foo extends Foo() satisfies Bar {
        // ...
    };
    return foo;

### Type

The type of a `let` expression is the type of the object expression, which is 
the intersection of the given extended class type and satisfied 
interfaces types.

## See also

* [`object` declarations](../../structure/object)
