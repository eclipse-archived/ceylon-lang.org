---
layout: reference
title: Type abbreviations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

Some types are so commonly used in Ceylon that there are special 
abbreviations for them. 

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

* [`Null`](#{site.urls.apidoc_current}/class_Null.html)
* [`Sequential`](#{site.urls.apidoc_current}/interface_Sequential.html)
* [`Sequence`](#{site.urls.apidoc_current}/interface_Sequence.html)
* [`Empty`](#{site.urls.apidoc_current}/class_Empty.html)
* [`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html)
* [`Tuple`](#{site.urls.apidoc_current}/class_Tuple.html)
* [`Callable`](#{site.urls.apidoc_current}/interface_Callable.html)
