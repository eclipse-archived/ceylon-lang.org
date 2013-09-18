---
layout: reference
title: '`import` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The `import` statement is used to express a dependency on a type defined in 
another package.

**Note:** This page is **not** about the `import` declarations in 
a [module descriptor](../../structure/module#descriptor)

## Usage 

The import statement has several variations:

<!-- check:none -->
    // importing a list of declarations
    import math { sqrt, pi, Complex }
    // importing all declarations in a package
    // (a 'wildcard' import)
    import com.example.metasyntax {...}
    // assigning a different name to an imported declaration
    // (an 'import alias'), e.g. to avoid a name conflict
    import org.example.metasyntax { ExampleFoo=>Foo, Bar}



## Description

### Modules and versions

The `import` declarations in the 
[module descriptor](../module#descriptor) 
are used to determine which version of which module is required for 
compilation and execution.

### Execution

Import statements do not affect execution. 

### Advice

Use of wildcard `import`s (e.g. `import com.example.metasyntax {...}`) is 
discouraged, since:

* when reading, it makes it harder to determine which package a particular 
  type name in the source code is referring to,
* as the declarations in imported packages change over time, there's the 
  possibility of name collisions, even though none existed at the time 
  the code was written

## See also

* [`import` in the language specification](#{site.urls.spec_current}#imports)
