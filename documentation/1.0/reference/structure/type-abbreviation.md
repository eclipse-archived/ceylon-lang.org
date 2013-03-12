---
layout: reference
title: Type abbreviations
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 5
---

# #{page.title}

Some types are so commonly used in Ceylon that there are special 
abbreviations for them. 

## Usage 

    T?        // same as T|Null
    T[]       // same as Sequential[T]
    {T*}      // Iterable<T,Null>
    {T+}      // Iterable<T,Nothing>, has at least one element
    [T]       // The 1-tuple Tuple<T, T, Empty>
    [X,Y]     // The 2-tuple Tuple<X|Y, X, Tuple<Y, Y, Empty>>
    [T*]      // The *-tuple Tuple<T, T, Sequential<T>>
    [T+]      // The +-tuple Tuple<T, T, Sequence<T>>
    R(P1,P2)  // Callable<R,[P1,P2]>
    

## Description

The above abbreviations can be used anywhere a type is expected. 

## See Also

* [`Null`](#{site.urls.apidoc_current}/ceylon/language/class_Null.html)
* [`Sequential`](#{site.urls.apidoc_current}/ceylon/language/interface_Sequential.html)
* [`Sequence`](#{site.urls.apidoc_current}/ceylon/language/interface_Sequence.html)
* [`Empty`](#{site.urls.apidoc_current}/ceylon/language/class_Empty.html)
* [`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html)
* [`Tuple`](#{site.urls.apidoc_current}/ceylon/language/class_Tuple.html)
* [`Callable`](#{site.urls.apidoc_current}/ceylon/language/interface_Callable.html)
