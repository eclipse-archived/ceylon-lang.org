---
layout: reference
title: Type abbreviations
tab: documentation
unique_id: docspage
author: Tom Bentley
toc: true
---

# #{page.title}

Some types are so commonly used in Ceylon that there are special 
abbreviations for them. 

#{page.table_of_contents}

## Usage 

<!-- try: - -->
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

### Variadic parameters

Although not an abbrevious like the above, in a [parameter list](../parameter-list/)
*variadic* parameters use a syntax that looks similar `Iterable` and `Tuple`
abbreviations above:

<!-- check:none -->
    T*        // a possibly empty variadic parameter
    T+        // a non-empty variadic parameter

## See Also

* [`Null`](#{site.urls.apidoc_current}/Null.type.html)
* [`Sequential`](#{site.urls.apidoc_current}/Sequential.type.html)
* [`Sequence`](#{site.urls.apidoc_current}/Sequence.type.html)
* [`Empty`](#{site.urls.apidoc_current}/Empty.type.html)
* [`Iterable`](#{site.urls.apidoc_current}/Iterable.type.html)
* [`Tuple`](#{site.urls.apidoc_current}/Tuple.type.html)
* [`Callable`](#{site.urls.apidoc_current}/Callable.type.html)
