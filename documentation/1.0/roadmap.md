---
layout: documentation
title: Ceylon roadmap
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---
# #{page.title}

Ceylon code is released and available on [GitHub](http://github.com/ceylon). 

Milestone 2 of Ceylon [has been released](/download) and we are working on milestone 3 
at the moment. Because quality is important to us, we won't release work until we think 
it's usable. Therefore, we can't give you dates on each milestone.

However, our roadmap is quite well-defined:

- Ceylon 1.0
  - [Milestone 1](#milestone_1_done)
  - [Milestone 2](#milestone_2_done)
  - [Milestone 3](#milestone_3_done) (latest release)
  - [Milestone 4](#milestone_4)
  - [Milestone 5](#milestone_5_ceylon_10)
- [Ceylon 1.1](#ceylon_11_or_later)

## Milestone 1 _DONE_

Milestone 1 has been released.

*Expressions, basic procedural code, basic object orientation, 
basic generics including variance, validation of definite
assignment/initialization and definite return, exceptions,
modularity.*

### Declarations:
* toplevel classes
* toplevel interfaces (except concrete members)
* toplevel methods (no higher-order or first-class functions)
* toplevel simple attributes
* toplevel attribute getters
* toplevel anonymous classes (`object` declaration)
* member methods with blocks (no higher-order methods)
* member simple attributes
* member attribute getters/setters
* member anonymous classes (`object` declaration)
* locals
* nested methods (closures)
* nested getters/setters
* nested anonymous classes
* nested classes
* type inference with `value` and `function`
* inheritance (`satisfies` and `extends`)
* `abstract` classes
* `formal` members
* method / attribute refinement (`default`, `actual`)

### Statements:
* expression statements
* specification statements
* control structures excluding `switch/case`<a href="#m1-control"><sup>1</sup></a>
* `if (exists ... )`
* `if (nonempty ... )`
* `if (is ...)`

### Generics:
* generic types 
* generic methods
* covariance / contravariance (`in`/`out`) [TODO: extra tests]
* upper bounds
* type argument inference [TODO: compiler ignores inferred type arguments]

### Expressions:
* literals (except single-quoted literals)
* string templates (interpolation)
* self references (`this`, `super`) 
* attribute evaluation/assignment
* operators <a href="#m1-operators"><sup>2</sup></a>
* parenthesized expressions
* positional method invocation<a href="#m1-invocation"><sup>3</sup></a>
* named-argument method invocation (no object/method/getter args)<a href="#m1-invocation"><sup>3</sup></a>
* instantiation<a href="#m1-invocation"><sup>3</sup></a>
* sequence instantiation `{ x, z, y}`
* invocations with type arguments
* assignment

### Misc:
* union types `A|B`
* intersection types `A&B`
* type name abbreviations `T[]` and `T?`
* imports
* initialization/declaration section rules [TODO: check this against latest spec]
* definite assignment/initialization rules
* definite return rules
* methods/attributes with named arguments
* `shared` members + visibility rules
* local capture [TODO: test and bugfix capture of forward declared locals]
* erasure of `Void`/`Object`/`Nothing`/`Equality`/`IdentifiableObject`
* optimization of locals in class initializer
* sequenced (varargs) parameters
* optimization of primitives with auto(un)boxing
* defaulted parameters [TODO: bugfixes]

### Types:
* `Boolean`
* `Character` and `String`
* numeric types
* sequences
* `Comparison`
* `Entry`
* `Range`
* `process`

### Modularity:
* module and package descriptors
* `car` archives
* local repositories
* module versioning
* module runtime

Notes:

1. <a name="m1-control">Without support for `try (x)` or `if (satisfies U V)`.</a>
2. <a name="m1-operators">Excluding set operators, and operators that depend 
   on `Gettable`/`Callable`. Furthermore, *numeric widening* with arithmetic 
   operators and user-defined numeric types is not supported.</a>
3. <a name="m1-invocation">Excluding defaulted arguments and `Callable`.</a>

## Milestone 2 _DONE_

Milestone 2 has been released.

*Numeric type optimization, Java interop, `switch/case`,
higher-order methods, types with enumerated cases, 
remote repositories.*

### Declarations:
* cases (`of` clause)
* higher-order methods
* methods with specifiers
* defaulted parameters

### Generics:
* enumerated bounds

### Statements:
* `switch/case`

### Expressions:
* method references

### Misc:
* optimization of primitive operators
* Java interoperability
* exhaustive case lists

### Types:
* `Collection`, `List`, `Map`, `Set`
* Remove `Equality`, `Slots`, `Natural`

### Modularity:
* remote repositores
* `modules.ceylon-lang.org`

## Milestone 3 _DONE_

Milestone 3 has been released.

*Mixin inheritance, anonymous functions, comprehensions,
file IO.*

### Integration of JavaScript compiler:
* compilation to JavaScript is a compiler switch

### Declarations:
* concrete interface members
* new syntax for attribute initialization parameters
* multiple parameter lists
* nested interfaces
* self types
* shortcut syntax for formal member refinement

### Expressions:
* object/method/getter args in named argument lists
* anonymous functions (`(Type x) result(x)`)
* comprehensions (`for (x in xs) if (select(x)) collect(x)`)
* indirect invocations of `Callable` instances
* outer instance references (`outer`)
* set operators (`|`, `&`, `^`, `~`)

### Misc:
* "lazy" semantics for sequenced parameters

### Modules:
* `ceylon.math` platform module  (arbitary precsision decimals/integers 
   and common floating point functions)
* `ceylon.file` platform module (access to hierarchical filesystems)
* `ceylon.process` platform module (operating system processes)

## Milestone 4

*Member classes and type families, type aliases.*

### Declarations:
* member class refinement / type families
* class and interface aliases
* union and intersection aliases _POSSIBLY_
* new syntax for package and module descriptors
* fix "object builder" syntax

### Statements:
* `try` with resources _POSSIBLY_

### Expressions:
* named argument-style syntax for instantiating interfaces
* lengthwise range operator (`:`)
* laziness for string interpolation _POSSIBLY_

### Modularity:
* repository replicator

### Modules:
* `ceylon.net` platform module
* `ceylon.json` platform module (JSON parser)
* `ceylon.time` platform module (date/time types)
* `ceylon.local` platform module (basic support for localization)
* `ceylon.format` platform module (text formatting for numbers and 
   dates/times)
* `ceylon.collection` platform module (collection implementations
  organized into mutable array-based collections, mutable 
  hashtable-based collections and immutable linked-list based 
  collections) 
   _POSSIBLY_

## Milestone 5 (Ceylon 1.0)

*Annotations, reified generics, metamodel, interception.*

### Declarations:
* annotations

### Generics:
* sequenced type parameters
* reified generics

### Expressions:
* metamodel references
* numeric widening for custom numeric types

### Misc:
* annotation constraints
* interception for methods, attributes, and classes
* serialization

### Modules:
* language metamodel
* `ceylon.transaction` platform module (support for distributed
  transaction processing)
* `ceylon.relational.connect` platform module (access to relational
  databases)
* `ceylon.relational.sql` platform module (SQL statement builder)
* `ceylon.http.client` platform module (HTTP client)
* `ceylon.http.server` platform module (HTTP server)

## Ceylon 1.1 or later

* interfaces upper bounded by classes
* lower bound constraints
* parameter bound constraints
* `if (satisfies ...)`
* `satisfies` operator
* single-quoted literals
* generalized algebraic types
* introductions (`adapts` clause) ?
* metatypes (type classes) ?
* type constructor parameterization ?