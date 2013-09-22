---
layout: documentation
title: Ceylon roadmap
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---
# #{page.title}

Ceylon M6 [has been released](/download) and we are
already working on a final production-ready release of the 
language, toolset, and IDE.

<!--
However, our roadmap is quite well-defined:

- Ceylon 1.0
  - [Milestone 1](#milestone_1_done)
  - [Milestone 2](#milestone_2_done)
  - [Milestone 3](#milestone_3_done)
  - [Milestone 4](#milestone_4_done)
  - [Milestone 5](#milestone_5_done) 
  - [Milestone 6](#milestone_6_done) (latest release)
-->

## Current progress for 1.0

<div id="milestones-progress">
    <div id="milestone-overall">Loading…</div>
    <h3>Detail</h3>
    <div data-title="Ceylon compiler frontend — Language specification" data-milestone="https://api.github.com/repos/ceylon/ceylon-spec/milestones/7?callback=?">Loading…</div>
    <div data-title="Ceylon compiler — JVM backend" data-milestone="https://api.github.com/repos/ceylon/ceylon-compiler/milestones/8?callback=?">Loading…</div>
    <div data-title="Ceylon compiler — JS backend" data-milestone="https://api.github.com/repos/ceylon/ceylon-js/milestones/5?callback=?">Loading…</div>
    <div data-title="ceylon.language module" data-milestone="https://api.github.com/repos/ceylon/ceylon.language/milestones/7?callback=?">Loading…</div>
</div>

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
* erasure of `Anything`/`Object`/`Nothing`/`Equality`/`IdentifiableObject`
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

## Milestone 4 _DONE_

Milestone 4 has been released.

*Member classes and type families, type aliases.*

### Declarations:
* member class refinement / type families
* class and interface aliases
* union and intersection aliases (`alias`)
* new syntax for package and module descriptors
* fix "object builder" syntax

### Statements:
* `assert`

### Expressions:
* Condition lists in `if`, `while`, `assert` and `if` comprehensions

### Modularity:
* Maven and aether

### Modules:
* `ceylon.net` platform module
* `ceylon.json` platform module (JSON parser)
* `ceylon.collection` platform module (collection implementations
  organized into mutable array-based collections, mutable 
  hashtable-based collections and immutable linked-list based 
  collections) 

### Tools:
* Pluggable tools, `git`-style (`ceylonc` -> `ceylon compile`)

### Interoperability
* Better support for optional types in Java
* Map the JDK into Jigsaw-compatible module lists

## Milestone 5 _DONE_

*Tuples, reified generics, dynamic blocks, various syntax
changes, HTTP server, dates and times.*

### Declarations:
* the `late` annotation
* fat arrow notation `=>` for single-expression functions
  and getters

### Generics:
* reified generics
* defaulted type parameters

### Expressions:
* Tuples
* lengthwise range operator (`start:length` and `ranged[start:length]`)
* Binary and hexadecimal integer literals
* verbatim strings
* `{Element*}` abbreviation for `Iterable<Element>`

### Misc:
* `dynamic` blocks for interop with native JavaScript

### Modules:
* `compose()` and `curry()` functions in language module
* `ceylon.time` platform module (date/time types)
* `ceylon.net.httpd` package (HTTP server)

## Milestone 6 (1.0 beta) _DONE_

*Annotations, metamodel, and serialization.*

### Declarations:
* annotations

### Statements:
* `try` with resources

### Expressions:
* metamodel references
* "static" method references

### Misc:
* annotation constraints

### Modularity
* repository replicator

### Modules:
* `ceylon.language.model` language metamodel
* `ceylon.unicode`

## 1.0 final

### Misc:
* serialization
* interop with Java annotations

### Modules:

* `ceylon.transaction` platform module (support for distributed
  transaction processing)
* `ceylon.local` platform module (basic support for localization)
* `ceylon.format` platform module (text formatting for numbers and 
   dates/times)
