---
layout: reference
title: Extending types with native JavaScript
tab: documentation
unique_id: docspage
author: Enrique Zamudio
---

# #{page.title}

When a class which is annotated `native` is compiled to JavaScript, you can include
two functions which will be called when creating new instances of that class: one
before the class body is executed and one after that. Both functions are optional.

The names of these functions are `$init$native$TYPE_NAME$before` and
`$init$native$TYPE_NAME$after`, where `TYPE_NAME` is the generated name for the type
in JavaScript (see the _Declaration names_ section of the [compiler](..)).

You can define one or both functions in a JavaScript file and include it right after
the Ceylon source (or at any point *after* the Ceylon source containing the type´s
definition). These functions will be passed one or two parameters:

* The instance being initialized,
* and the type arguments, if the type has type parameters.

# Example

As a matter of fact, we use this facility of the compiler when compiling one of our
own classes, the `Exception` class. The class is annotated `native` and the `before`
hook is used to add the stack trace to new exceptions.
