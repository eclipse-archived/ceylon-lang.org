---
layout: reference
title: Comprehensions
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 3
doc_root: ../..
---

# #{page.title}

Comprehensions provide a concise way of constructing sequences or passing an
`Iterable` as the argument to a sequenced parameter in an invocation.

## Usage 

Here's a simple example which is explained 
[below](#for_if_and_expression_clauses):

    for (person in people) if (exists person.spouse) 
        person.name + " is married to " + person.spouse.name


## Description

### Limited to sequenced arguments
Comprehensions are not permitted everywhere an expression is. You can only use
them an 
argument to a sequenced parameter in an [invocation](../invocation). 
[sequence instantiation](../sequence-instantiation) is considered an 
invocation, so comprehensions are also a convenient way of creating a 
[`Sequence`](#{site.urls.apidoc_current}/interface_Sequence.html).

### `for`, `if` and expression clauses

A comprehension is made up of a number of clauses. There are three types of 
clause: `for`, `if` and expression clauses. 
A comprehension always starts with a *`for` clause*. 

A *`for` clause* in a comprehension provides a source of elements, an 
attribute to name the current element and another comprehension clause to 
apply:

    for (/* Iterator expression*/) /* another comprehension */
    
The elements are provided by an `Iterable` instance. 
For example, assuming `people` is an `Iterable`:

    for (person in people) // ...

An *`if` clause* in a comprehension provides a [condition list](../../statement/conditions) 
followed by another comprehension clause to apply:

    if (/* condition list */) /* another comprehension */
    
An `if` clause provides a way of filtering elements: If condition list 
evaluates as `false` for the current element then 
processing of that element stops and we continue with the next element from 
the preceeding 
`for` comprehension.
    
Continuing the example:

    for (person in people) if (exists person.spouse) // ...

An *expression clause* in a comprehension provides the results of the comprehension and for that reason
a comprehension has to end with an expression clause.
The expression can be used to transform elements from the iterator. 

Continuing the example:

    for (person in people) if (exists person.spouse) 
        person.name + " is married to " + person.spouse.name

## See also

* [sequence instantiation](../sequence-instantiation) in the reference,
* [invocation](../invocation) in the reference,
* [`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html) API documentation,
* [comprehenions](../../tour/comprehensions) in the Tour of Ceylon,
<!-- TODO
* [comprehenions](#{page.doc_root}/#{site.urls.spec_relative}#) in Ceylon spec.
-->
