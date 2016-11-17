---
layout: reference13
title_md: 'destructuring'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

Destructuring allows the specification of several values at once, when their 
value is extracted from a `Tuple` or `Entry`.

## Usage 

    // destructure an Entry
    value key->item = entry;

    [Float, Float, Float] point = [1.0, 1.0, 1.0];
    // declare three values extracting the valee of each from the tuple
    value [x, y, z] = point;
    
    [Float, Float, Float]? maybePoint = point;
    // in conjunction with the exists condition
    if (exists [x, y, z] =  maybePoint) {
        // ...
    }
    
    [Float+] floats = [0.0, 1.0, 2.0, 3.0];
    // destructure with spread
    value [first, *rest] = floats;
    
    [Float, Float, [String, Icon]] labelledPoint = ...;
    // nested destructure
    value [x, y, [name, icon]] = labelledPoint;


## Description

Destructuring specification is supported:

* In [`value` declarations](../../structure/value/) (` value [x, y] = point`),
* In [`for` iteration](../../statement/for/) variables (`for ([x, y] in points) { ... }`),
* In [condition lists](../../statement/condition_list/) (`if (exists [x, y]=maybePoint) { ... }`, `assert(exists [x, y]=maybePoint);`, `assert(nonempty [first, *rest]=seq);` etc),
* In [`cases` of a `switch`](../../statement/switch/) (`case ([Float x, Float  y]) { ... }`),
* In [`let` expressions](../../expression/let/) (`let ([x, y] = point) sqrt(x^2+y^2)`),
* In [comprehensions](../../expression/comprehension/) (`{ for[x, y] in points) sqrt(x^2+y^2) }`),

It is not supported for types other than `Tuple` or `Entry`.

## See also


