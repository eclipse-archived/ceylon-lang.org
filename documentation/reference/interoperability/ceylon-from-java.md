---
layout: reference
title: Calling Ceylon from Java
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Description

Although titled '*Calling* Ceylon from Java', this page covers all access to 
Ceylon types from Java, not just method calls.

**Important Note: Everything documented here is subject to change after M1.**

### Declaring Ceylon types

In general a Ceylon type compilers into a Java type of the same name.

### Instantiating Ceylon classes

TODO

### Accessing Ceylon attributes

In general a Ceylon attribute compiles into a Java Bean-style getter and 
(if the attribute has an `assign` block) setter. If the Ceylon attribute
is annotated `shared` the Java accessor will be declared `public`, otherwise
it will be annotated `private`.

`Boolean` attributes use `get` accessors rather than an `is` accessors. 
Note that a `get` accessor is still valid for `boolean` properties 
according to the Java Bean specification.

### Calling Ceylon methods

In general a Ceylon method compiles directly into a Java method of the same 
name. The method result type and argument types will not, in general, 
translate directly because of the [erasure rules](../erasure).

See [naming] _doc coming soon at_ (../naming) for information about Ceylon method names which are 
Java keywords.

### Catching Ceylon exceptions

The root of the exception hierarchy in Ceylon is `ceylon.language.Exception`, 
which is a `ceylon.language.Exception` (a subclass of 
`java.lang.RuntimeException`) at runtime. This means that pure Ceylon code can only
generate unchecked exceptions.

Impure Ceylon (that is, Ceylon code which access Java code) may throw 
*any* exception that is thrown by that Java code, including checked exceptions. 
Ceylon methods do not declare `throws java.lang.Throwable` in their bytecode, 
even though they can in principle throw `Throwable`. In practice 
Ceylon methods are very unlikely to throw `Throwable` itself 
(because Java methods are unlikely to), but Ceylon methods are quite likely 
to throw `java.lang.Exception`. So unless you know otherwise, it's 
probably sensible to wrap calls to Ceylon methods in a Java-side 
`try/catch` which handles this possibility.


## See also

* [Calling Java from Ceylon](../java-from-ceylon)
* The [erasure rules](../erasure)

