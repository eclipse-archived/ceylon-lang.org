---
layout: reference
title: `import` statement
tab: documentation
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

The `import` statement is used to express a dependency on a type defined in 
another package.

## Usage 

The import statement has several variations. 

Importing a single class:

    import com.example.metasyntax {Foo}
    import math { sqr, sqrt, e, pi }

Importing several classes:

    import com.example.metasyntax {Foo, Bar}
    
Importing several all classes in a package (a *wildcard* `import`):

    import com.example.metasyntax {...}
    
Assigning a difference name to an imported type (to avoid a name conflict):

    import com.example.metasyntax { ExampleFoo=Foo, Bar}

**Note:** Import statements should not end with a semicolon.

## Description

### Modules and versions

The `dependencies` attribute of the [package descriptor](FIXME) is used to 
determine which version of which module is required for compilation and 
execution.

### Execution

Import statements do not affect execution. 

### Advice

Use of wildcard `import`s (`import com.example.metasyntax {...}`) is 
discouraged, since it makes it harder to determine which package a particular
type name in the source code is referring to.

## See also

* [`import` in the language specification](#{site.urls.spec}#imports)
