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

## Milestone 1

Expressions, basic procedural code, basic object orientation, basic
generics including (co|contra)variance, validation of definite
assignment/initialization and definite return.

### Declarations:
* classes **[done|done]**
* interfaces (except concrete members) **[done|done]**
* methods with blocks (no higher-order methods) **[done|done]**
* simple attributes + locals with specifiers **[done|done]**
* attribute getters/setters with blocks **[done|done]**
* anonymous classes (`object` declaration) [**done**|todo]
* type inference with `value` and `function` **[done|done]**
* inheritance (`satisfies` and `extends`) **[done|done]**
* `abstract` classes **[done|done]**
* `formal` members **[done|done]**
* method / attribute refinement (`default`, `actual`) **[done|done]**
* class and interface aliases [**done**|small bug]
* nested methods (closures) **[done|done]**
* nested getters/setters ?? [**done**|todo]

### Statements:
* expression statements **[done|done]**
* specification statements **[done|done]**
* control structures excluding `switch/case`<a href="#m1-control"><sup>1</sup></a> **[done|done]**
* `if (exists ... )` **[done|done]**
* `if (nonempty ... )` **[done|done]**
* `if (is ...)` **[done|done]**

### Generics:
* generic types **[done|done]**
* generic methods [**done**|todo]
* covariance / contravariance (`in`/`out`) **[done|done]**
* upper bounds [**done**|todo]
* type argument inference [**done**|todo]

### Expressions:
* literals (except single-quoted literals) **[done|done]**
* string templates (interpolation) **[done|done]**
* self references (`this`, `super`) **[done|done]**
* attribute evaluation/assignment **[done|done]**
* operators <a href="#m1-operators"><sup>2</sup></a> [**done**|todo]
* parenthesized expressions [**done**|?]
* positional method invocation<a href="#m1-invocation"><sup>3</sup></a> **[done|done]**
* named-argument method invocation (no object/method/getter args)<a href="#m1-invocation"><sup>3</sup></a> **[done|done]**
* instantiation<a href="#m1-invocation"><sup>3</sup></a> **[done|done]**
* sequence instantiation `{ x, z, y}` **[done|done]**
* invocations with type arguments [**done**|todo]
* assignment **[done]**

### Misc:
* union types `A|B` [**done**|todo]
* type name abbreviations `T[]` and `T?` [**done**|todo]
* imports [**done**|todo]
* initialization/declaration section rules [partly|todo]
* definite assignment/initialization rules [**done**|?]
* definite return rules [**done**|?]
* methods/attributes with named arguments [**done**|todo]
* `shared` members + visibility rules [**done**|?]
* erasure of `Void`/`Object`/`Nothing`/`Equality`/`IdentifiableObject` **[done|done]**
* optimization of locals in class initializer **[done|done]**
* sequenced (varargs) parameters **[done|done]**

### Types:
* "Boolean"
* numeric types
* strings
* sequences

Notes

1. <a name="m1-control"></a>`try/catch/finally` without support for resources
2. <a name="m1-operators"></a>Excluding slotwise operators and those that 
   depend on `Gettable`/`Callable`. Also the *widening* of arithmetic operators
   won't be supported in M1.
3. <a name="m1-invocation"></a>Excluding defaulted arguments and `Callable`

## Milestone 2
Functional programming, mixin inheritance, introductions, switch/case,
and exceptions.

### Declarations:
* concrete interface members
* higher-order methods
* methods with specifiers
* cases (`of` clause)
* introductions (`adapts` clause) ??

### Generics:
* sequenced type parameters
* enumerated bounds ??

### Statements:
* `switch/case`
* `try/catch/finally` with resources

### Expressions:
* Method references
* object/method/getter args in named argument lists
* numeric widening [**done**|todo]
* slotwise operators

### Misc:
* defaulted parameters ??
* exhaustive case lists
* optimization of primitives with auto(un)boxing

### Types:
* most of `ceylon.language` (no metamodel)

## Milestone 3
Annotations, nested/member classes, type aliases, advanced generics,
metamodel, interception.

### Declarations:
* annotations
* nested and member classes

### Generics:
* reified generics
* lower bounds
* initialization parameter specification

### Statements:
* `if (satisfies ...)`

### Expressions:
* outer instance references (`outer`)
* inline callable arguments ??
* metamodel references

### Misc:
* annotation constraints
* interception for methods, attributes, and classes

### Types:
* metamodel
* control expressions?
* collections module?

