---
layout: reference11
title_md: Type mapping annotations
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Ceylon uses Java annotations in compiled `.class` files to store information 
about Ceylon types. For example, consider the Ceylon method:

<!-- try: -->
    Object? m() {
        // ...
    }

In Ceylon, the return type (after syntactic desugaring) is `Object|Null`, 
and the compiler needs to know this when typechecking code which 
depends on `m()`.

Currently, these annotations do not form a stable API
which can be used by Java application developers wishing to customize how 
their Java types are treated by Ceylon. For this reason they are not 
documented here. If you're *desperate* to customise something you can look at
the annotations in `com.redhat.ceylon.compiler.java.metadata` in 
`ceylon.language`.

