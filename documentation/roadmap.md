---
layout: documentation
title: Ceylon's roadmap
tab: documentation
author: Emmanuel Bernard
---
# #{page.title}

Ceylon has not been released into the open yet. We are working toward the first milestone before pushing it into your hands. No we don't have date. We focus on quality software and won't release work we are not happy with.

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
* anonymous classes ("object" declaration) [**done**|todo]
* type inference with "value" and "function" **[done|done]**
* inheritance ("satisfies" and "extends") **[done|done]**
* "abstract" classes **[done|done]**
* "formal" members **[done|done]**
* method / attribute refinement ("default", "actual") **[done|done]**
* class and interface aliases [**done**|small bug]
* nested methods (closures) **[done|done]**
* nested getters/setters ?? [**done**|todo]

### Statements:
* expression statements **[done|done]**
* specification statements **[done|done]**
* control structures except "try/catch/finally" and "switch/case" **[done|done]**
* "if (exists ... )" **[done|done]**
* "if (nonempty ... )" **[done|done]**
* "if (is ...)" **[done|done]**
* "try/catch/finally" ?? [**done**|todo]

### Generics:
* generic types **[done|done]**
* generic methods [**done**|todo]
* covariance / contravariance ("in"/"out") **[done|done]**
* upper bounds [**done**|todo]
* type argument inference [**done**|todo]

### Expressions:
* literals (except single-quoted strings) **[done|done]**
* string templates (interpolation) [**done**|todo]
* self references ("this", "super") **[done|done]**
* attribute evaluation/assignment **[done|done]**
* operators (most of them) [**done**|todo]
* parenthesized expressions [**done**|?]
* method invocation (except callable arguments) **[done|done]**
* instantiation **[done|done]**
* sequence instantiation "{ x, z, y}" **[done|done]**
* positional argument lists **[done|done]**
* named argument lists ?? [**done**|todo]

### Misc:
* union types "A|B" [**done**|todo]
* type name abbreviations "T[]" and "T?" [**done**|todo]
* imports [**done**|todo]
* initialization/declaration section rules [partly|todo]
* definite assignment/initialization rules [**done**|?]
* definite return rules [**done**|?]
* methods/attributes with named arguments [**done**|todo]
* "shared" members + visibility rules [**done**|?]
* erasure of Void/Object/Nothing/Equality/IdentifiableObject **[done|done]**
* optimization of locals in class initializer **[done|done]**
* sequenced (varargs) parameters ??

### Types:
* "Boolean"
* numeric types
* strings
* sequences

## Milestone 2
Functional programming, mixin inheritance, introductions, switch/case,
and exceptions.

### Declarations:
* concrete interface members
* higher-order methods
* methods with specifiers
* cases ("of" clause)
* introductions ("adapts" clause) ??

### Generics:
* sequenced type parameters
* enumerated bounds ??

### Statements:
* "switch/case"

### Expressions:
* Method references

### Misc:
* defaulted parameters ??
* exhaustive case lists
* optimization of primitives with auto(un)boxing

### Types:
* most of "ceylon.language" (no metamodel)

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
* "if (satisfies ...)"

### Expressions:
* outer instance references ("outer")
* inline callable arguments ??
* metamodel references

### Misc:
* annotation constraints
* interception for methods, attributes, and classes

### Types:
* metamodel
* control expressions?
* collections module?