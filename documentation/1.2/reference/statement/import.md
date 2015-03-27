---
layout: reference12
title_md: '`import` statement'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `import` statement is used to express a dependency on a type defined 
in another package. All `import` statements for a compilation unit must
occur in a list at the top of the file.

**Note:** This page is *not* about module `import` statements occurring 
in a [module descriptor](../../structure/module#descriptor).

## Usage 

The `import` statement has several variations:

<!-- check:none -->
<!-- try: -->
    // importing a list of declarations
    import math { sqrt, pi, Complex }
    
    // importing all declarations in a package
    // (a 'wildcard' import)
    import com.example.metasyntax { ... }
    
    // assigning a different name to an imported declaration
    // (an 'alias' import)
    import org.example.metasyntax { ExampleFoo=Foo, Bar }

    // assigning a different name to a member of an imported type
    import org.example.metasyntax { Foo { b=bar } }

It is also possible to import the members of a top level `object`, or a 
constructor from a toplevel class:

    import org.example.person {
        Person { 
            // import the Person.FromName constructor
            // so code can just do NamedPerson("Alan", "Turing")
            NamedPerson=FromName 
        },
        famousPeople {
            // import values from the famourPeople object
            // so code can use them as if they were top level
            elvis,
            beethoven
        }
    }
    

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

* [Imports](#{site.urls.spec_current}#imports) in the Ceylon language 
  specification
