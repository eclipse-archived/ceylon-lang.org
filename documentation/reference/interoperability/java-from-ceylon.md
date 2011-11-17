---
layout: reference
title: Calling Java from Ceylon
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Description

Although titled '*Calling* Java from Ceylon', this page covers all access to 
Java types from Ceylon, not just method calls.

**Important Note: Everything documented here is subject to change after M1.**

### Declaring Java types

#### Accessing Java types with an initial lowercase letter

In general you can't do this, because in Ceylon types have an initial capital 
letter.

In the particular cases of `boolean`, `long`, `double`, and `char`
you can use `Boolean`, `Integer`, `Float` and `Character` you can exploit 
the [erasure rules](../erasure) to achieve what you need.

### Instantiating Java types

TODO

#### Calling overloaded constructors

TODO

### Accessing Static fields

TODO Accessing java fields with names that a Ceylon keywords

### Accessing Static methods

TODO Calling java methods with names that a Ceylon keywords

#### Calling overloaded static methods

### Accessing instance fields

TODO Accessing java fields with names that a Ceylon keywords

### Accessing instance methods

Firstly, Java Bean-style accessors (`get*()` and `set*()` methods) will be 
treated as Ceylon attributes, and therefore can be accessed as such. The one
exception to this rule would be a write-only (no getter provided) property. 
XXX This can still be used from Ceylon via a direct method call.

Other instance methods can be accessed as a Ceylon method.

TODO Calling java methods with names that a Ceylon keywords

#### Calling overloaded instance methods

TODO

### Catching Java exceptions

A Ceylon-side `catch (Exception e) { ... }` will catch `java.lang.Exception` 
(and, of course its subclasses).

It's currently impossible to catch non-`java.lang.Exception` subclasses of
`java.lang.Throwable`. In particular this means it's currently impossible to 
catch `java.lang.Error`.

### Java primitive types

TODO

### Java array types

TODO

### Java `enum` types

TODO

## See also

* [Calling Ceylon from Java](../ceylon-from-java)
* The [erasure rules](../erasure)

