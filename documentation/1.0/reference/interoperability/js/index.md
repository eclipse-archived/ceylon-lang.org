---
layout: reference
title: The JavaScript compiler
tab: documentation
unique_id: docspage
milestone: Milestone 6
author: Enrique Zamudio
---

# #{page.title}

Ceylon code can be compiled to JavaScript. There are two styles that can be used:

* Lexical scope, which is the default, and
* Prototype style, also known as _optimized_.

## Lexical scope style

In lexical scope style, a type´s methods and attributes are assigned to each new instance as it is created. This offers good encapsulation but incurs in some performance costs.

## Prototype style

In prototype style, all methods and attributes are assigned to the type´s prototype, so that new instances automatically have all those methods and attributes. This has much better performance but all methods and attributes are visible in native JavaScript.

# Declaration names

A Ceylon module is compiled as a CommonJS module, but since this format has no notion of packages, all the packages in the Ceylon module will be contained in the same CommonJS file. To avoid naming collisions, there are some rules used when generating names for top-level declarations:

* If the declaration is in the module´s root package, then its name is basically the same.
* If the declaration is in a subpackage, its name will have the subpackage name appended to it.

For example, for a module `my.module` the declaration `my.module.MyClass` will simply be called `MyClass` but `my.module.sub1.sub2.MyClass` will be called `MyClass$sub1$sub2`. 

## See also

* [Extending types annotated as `native`](native-anno)
