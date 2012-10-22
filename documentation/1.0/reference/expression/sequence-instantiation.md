---
layout: reference
title: Sequence Instantiation
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

Sequence instantiation creates a new instance of a 
[`Sequence`](../../structure/type#sequence)`|`[`Empty`](../../structure/type#empty)


## Usage 

Some simple examples using literals to specify the elements:

    String[] none = {};
    Integer[] ints = {1, 2, 3};
    Sequence<String|Integer>|Empty mixed = {1, 2, "a few"};


## Description

In some ways, sequence instantiation can be considered a form of 
[invocation  with sequenced arguments](../invocation#sequenced_arguments), and
the  expressions within the braces may be called the *arguments* to 
the instantiation.

### Type inference

The typechecker inspects the arguments to a sequence 
instantiation:

* If there are none then the type is `Empty`,
* Otherwise it forms the 
  [union type](../../structure/type#union_types) of the types of the 
  arguments as the type argument to the `Sequence`.

This makes type inference (using `value`) work as you would expect,
for example:

    // seq has type Sequence<Integer|Boolean|Float>
    value seq = {1, true, 3.4}
    // none has type Empty
    value none = {}


### Comprehension

A [comprehension](../comprehensions) provides a convenient way of 
instantiating a `Sequence|Empty` from (some of) the (possibly transformed) 
elements returned from an `Iterable`.

    // get the names of all planets without moons
    value moonless = { for (p in planets) if (p.moons.size == 0) p.name };
    
See the reference on [comprehensions](../comprehensions) for more details.

## See also

* [Comprehensions](../comprehensions) can be used to transform, filter and join
  [Iterables](#{page.doc_root}/api/ceylon/language/interface_Iterable.html) 
  in a sequence instantiation.
