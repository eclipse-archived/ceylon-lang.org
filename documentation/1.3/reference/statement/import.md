---
layout: reference13
title_md: '`import` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

In a regular source file, the `import` statement is used to express a 
dependency on a declaration defined in another package. All `import` 
statements for a compilation unit must occur in a list at the top of 
the file.

In a [module descriptor](../../structure/module#descriptor), the
`import` statement declares a dependency on another module.

## Usage 

The `import` statement specifies a source package, and a list of
declarations belonging to that package, with an optional wildcard:

<!-- check:none -->
<!-- try: -->
    // importing a list of declarations
    import math { sqrt, pi, Complex }
    
    // importing all declarations in a package
    // (a 'wildcard' import)
    import com.example.metasyntax { ... }
    
    // assigning a different name to an imported declaration
    // (an 'alias' import)
    import org.example.metasyntax { ExampleFoo = Foo, Bar }

    // assigning a different name to a member of an imported type
    import org.example.metasyntax { Foo { b = bar } }

It's also possible to import the members of a top level `object`, or a 
constructor of a toplevel class:

<!-- check:none -->
<!-- try: -->
    import org.example.person {
        Person { 
            // import the Person.fromName constructor
            // so code can just do namedPerson("Alan", "Turing")
            namedPerson = fromName 
        },
        famousPeople {
            // import values from the famousPeople object
            // so code can use them as if they were top level
            elvis,
            beethoven
        }
    }

In a module descriptor, the `import` statement specifies the name
and version of the imported module, and, optionally, a repository
type, when the module belongs to a foreign module repository system 
such as Maven or npm.

<!-- check:none -->
<!-- try: -->
    import ceylon.collection "1.3.0";
    import maven:org.hibernate:"hibernate-core" "5.0.4.Final";

Module versions are must be quoted. Module names must be quoted if
they contain characters like `-` which aren't legal in a Ceylon 
package name. Maven artifact ids must be quoted.

A module `import` statement may be annotated `shared` and/or `optional`.

## Description

Since Ceylon does not support the use of fully-qualified names in code,
name conflicts between declarations imported from different packages 
must be resolved by assigning a unique name to at least one of the 
declaration in the `import` statement. This new name is called an
_import alias_.

### Advice

Use of wildcard `import`s (e.g. `import com.example.metasyntax { ... }`) 
is discouraged, since:

* when reading, it makes it harder to determine which package a particular 
  type name in the source code is referring to, and
* as the declarations in imported packages change over time, there's the 
  possibility of name collisions, even though none existed at the time 
  the code was written.

## See also

* [Packages and modules](/documentation/tour/modules/) in the 
  Tour of Ceylon
* [Module descriptors](../../structure/module#descriptor)
* [Imports](#{site.urls.spec_current}#imports) in the 
  Ceylon language specification
* [Module system](#{site.urls.spec_current}#modulesystem) in the 
  Ceylon language specification
