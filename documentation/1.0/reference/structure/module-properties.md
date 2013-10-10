---
layout: reference
title_md: Format of module.properties files
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

The format of `module.properties` files is extremely simple, they just contain
one or more lines containing the name and version number of their dependecies
just like an `import` statement in a [module descriptor](../module#descriptor):

    full.module.name=version

For example:

    ceylon.collection=1.0.0
    my.module=0.5

To specify that a module is `shared` a '+' can be *prepended* to the beginning
of the name and to specify that a module is `optional` a `?` can be *appended*
to the end of the name. For example:

    +ceylon.collection=1.0.0
    my.module?=0.5

## See also

* About [modules](../module)
* The [module.xml](https://docs.jboss.org/author/display/MODULES/Module+descriptors) specification

