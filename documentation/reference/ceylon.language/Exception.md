---
layout: reference
title: `ceylon.language.Exception`
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage

See [API doc](FIXME)

## Description

All expressions used with the [`throw` statement](../../statement/throw) 
must be assignable to `Exception`. It follows that all parameters to 
[`catch` blocks](../../statement/try#any_number_of_catch_blocks...) 
must also be assignable to `Exception`.

### Messages

Exceptions support an explanatory message. This should include any details
(such as the values of members and/or method parameters etc) which might help 
diagnosing or reproducing the exception.

### Causes

Although exceptions needn't be declared using the 
[`throws` annotation](../throws) (and aren't checked by the compiler if they 
are) it can be desirable to 'wrap' exceptions of one type within another type 
of exception. This is frequently the case with libraries which 
encapsulation of/abstraction over implementation specifics, and therefore 
should throw library level exceptions, rather than implementation-specific
exceptions.

### Best practice

It is considered good practice to create application-specific subclasses of 
Exception as approriate (often for exception wrapping purposes).

## See Also

* [API documentation](FIXME)

