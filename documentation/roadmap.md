---
layout: documentation
title: Ceylon's roadmap
tab: documentation
author: Emmanuel Bernard
---
# #{page.title}

Ceylon has not been released into the open yet. We are working toward the 
first milestone before pushing it into your hands. We don't have a date. 
We are focusing on software quality and won't release work we are not happy 
with.

Our roadmap is fairly well defined though.

- [Milestone 1](#milestone_1)
- [Milestone 2](#milestone_2)
- [Milestone 3](#milestone_3)

## Milestone 1

Expressions, basic procedural code, basic object orientation, basic
generics including (co|contra)variance, validation of definite
assignment/initialization and definite return, exceptions.

And of course pushing our work into the open.

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
* class and interface aliases [TODO: tests]

### Statements:
* expression statements
* specification statements
* control structures excluding `switch/case`<a href="#m1-control"><sup>1</sup></a>
* `if (exists ... )`
* `if (nonempty ... )`
* `if (is ...)`

### Generics:
* generic types 
* generic methods [TODO: extra tests and bugfix]
* covariance / contravariance (`in`/`out`) [TODO: extra tests]
* upper bounds
* type argument inference [TODO: compiler ignores inferred type arguments]

### Expressions:
* literals (except single-quoted literals)
* string templates (interpolation)
* self references (`this`, `super`) 
* attribute evaluation/assignment
* operators <a href="#m1-operators"><sup>2</sup></a> [TODO: some operators are missing]
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
* optimization of primitives with auto(un)boxing [TODO: lots of tests and bugfixing]

### Types:
* `Boolean`
* `String`
* numeric types
* sequences
* `Comparison`
* `Entry`
* `Range`
* `process`


Notes

1. <a name="m1-control"></a>without support for `try (x)` or `if (satisfies U V)`
2. <a name="m1-operators"></a>Excluding slotwise operators, range operators, 
   and those that depend on `Gettable`/`Callable`. Furthermore, *numeric widening* 
   with arithmetic operators and user-defined numeric types is not supported.
3. <a name="m1-invocation"></a>Excluding defaulted arguments and `Callable`

## Milestone 2
Functional programming, mixin inheritance, nested/member 
classes, switch/case.

### Declarations:
* nested and member classes
* concrete interface members
* higher-order methods
* methods with specifiers
* cases (`of` clause)

### Generics:
* enumerated bounds ??

### Statements:
* `switch/case`
* `try` with resources

### Expressions:
* Method references
* object/method/getter args in named argument lists
* numeric widening
* slotwise operators
* range operators

### Misc:
* defaulted parameters
* exhaustive case lists
* optimization of primitives operators

## Milestone 3 (Ceylon 1.0)
Annotations, reified generics, metamodel, interception.

### Declarations:
* annotations

### Generics:
* sequenced type parameters
* reified generics

### Expressions:
* outer instance references (`outer`)
* metamodel references

### Misc:
* annotation constraints
* interception for methods, attributes, and classes

### Types:
* metamodel
* collections module?

## Ceylon 1.1 or later

* introductions (`adapts` clause)
* lower bounds
* initialization parameter specification
* `if (satisfies ...)`
* `satisfies` and `extends` operators
* inline callable arguments
* control expressions?
* single-quoted literals

