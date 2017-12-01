---
layout: reference13
title_md: '`[]=` (lookup assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The *lookup assign* operator assigns a particular item in a `CorrespondenceMutator`. It
is the mutation variant of the [lookup](../lookup) operator.

## Usage 

<!-- try: -->
    void m(Array<Integer> array) {
        array[0] = 2;
    }

## Description

The lookup assign operator assigns an item in a
`CorrespondenceMutator` to a given key.

The lookup assign operator also works with 
Java `java.util::List` and `java.util::Map` and Java array types.

Most `CorrespondenceMutator` types also satisfy the `Correspondence`
interface and can be accessed with the [lookup](../lookup)
operator.

### Definition

The `[]=` operator is defined as follows:

<!-- check:none -->
<!-- try: -->
    // For IndexedCorrespondenceMutator
    lhs.set(index, item)
    // For KeyedCorrespondenceMutator
    lhs.put(key, item)

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `[]=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `[]=` depends on the 
[`CorrespondenceMutator`](#{site.urls.apidoc_1_3}/CorrespondenceMutator.type.html) 
interface.

### Type

The result type of the `lhs[key] = item` operator is `item` value.

## See also

* API documentation for [`CorrespondenceMutator`](#{site.urls.apidoc_1_3}/CorrespondenceMutator.type.html) 
* The [lookup operator](../lookup)
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

