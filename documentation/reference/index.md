---
layout: reference
title: Reference
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

This page lists concepts and links to their descriptions. The complete 
[language specification](/documentation/spec) is also available.

_This page is very incomplete. Want to help? [See how](/code/website)._


## Structure

* [Modules](structure/module)
* [Packages](structure/package)
* [Compilation units](structure/compilation-unit)
* [Top-level] - _doc coming soon at_ (structure/top-level) methods and attributes
* [Types](structure/type)
* [Initializers] - _doc coming soon at_ (structure/initializers)
* [Attributes](structure/attribute)
* [Methods](structure/method)

## Types

* [Classes] - _doc coming soon at_ (type/class)
* [Interfaces] - _doc coming soon at_ (type/interface)
* [`extends` (inheritance)] - _doc coming soon at_ (type/inheritance)
* [`satisfies` (satisfaction)] - _doc coming soon at_ (type/satisfaction)
* [Generics] - _doc coming soon at_ (type/generics)
* [Introductions] - _doc coming soon at_ (type/introduction) <!-- m3 -->
* [Annotations] - _doc coming soon at_ (type/annotation) <!-- m3 -->

## Statements

* [`break` statements](statement/break)
* [`continue` statements](statement/continue)
* [expression statements](expression)
* [`for` statements](statement/for)
* [`if` statements](statement/if)
* [`import` statements](statement/import)
* [`return` statements](statement/return)
* [`=` (specification) statement](statement/specification)
* [`switch` statements](statement/switch) <!-- m2 -->
* [`throw` statements](statement/throw)
* [`try` statements](statement/try)
* [`while` statements](statement/while)

## Expressions

* [What is an expression](expression)
* [Attribute Evaluation] - _doc coming soon at_ (expression/attribute-evalaution)
* [Attribute Assignment] - _doc coming soon at_ (expression/attribute-assignment)
* [Callable References] - _doc coming soon at_ (expression/callable-references) <!-- m2 -->
* [Class Instantiation] - _doc coming soon at_ (expression/class-instantiation)
* [Literals](#literals)
* [Metamodel References] - _doc coming soon at_ (expression/metamodel-references) <!-- m3 -->
* [Method Invocation] - _doc coming soon at_ (expression/method-invocation)
* [Operators](#operators)
* [Self References] - _doc coming soon at_ (expression/self-references)
* [Sequence Instantiation] - _doc coming soon at_ (expression/sequence-instantiation)
* [String Templates] - _doc coming soon at_ (expression/string-template)

## Operators

* [operator polymorphism](operator/operator-polymorphism)
* [`!`   (not)](operator/not)
* [`!=`  (not equal)](operator/not-equal)
* [`$`   (format)] - _doc coming soon at_ (operator/format)
* [`%`   (remainder)](operator/remainder)
* [`%=`  (remainder assign)](operator/remainder-assign)
* [`&`   (intersection)](operator/intersection) <!-- m2 -->
* [`&&`  (and)](operator/and)
* [`&&=` (and assign)](operator/and-assign)
* [`&=`  (intersect assign)](operator/intersect-assign) <!-- m2 -->
* [`()`  (invoke)](operator/invoke)
* [`()`  (null-safe invoke)](operator/nullsafe-invoke)
* [`()`  (spread invoke)] - _doc coming soon at_ (operator/spread-invoke)
* [`*`   (product)](operator/product)
* [`**`  (power)](operator/power)
* [`*=`  (multiply assign)](operator/multiply-assign)
* [`+`   (sum)](operator/sum)
* [`+`   (unary plus)](operator/unary_plus)
* [`++`  (increment)](operator/increment)
* [`+=`  (add assign)](operator/add-assign)
* [`-`   (difference)](operator/difference)
* [`-`   (unary minus)](operator/unary_minus)
* [`--`  (decrement)](operator/decrement)
* [`-=`  (subtract assign)](operator/subtract-assign)
* [`->`  (entry)] _doc coming soon at_ (operator/entry)
* [`.`   (member)](operator/member)
* [`..`  (range)] _doc coming soon at_ (operator/range)
* [`.=`  (apply)](operator/apply)
* [`/`   (quotient)](operator/quotient)
* [`/=`  (divide assign)](operator/divide-assign)
* [`:=`  (assignment)](operator/assignment)
* [`<`   (less than)](operator/less-than)
* [`<=`  (less than or equal)](operator/less-than-or-equal)
* [`<=>` (compare)](operator/compare)
* [`=`   (specify)] - _doc coming soon at_ (operator/specify)
* [`==`  (equal)](operator/equal)
* [`===` (identical)](operator/identical)
* [`>`   (greater than)](operator/greater-than)
* [`>=`  (greater than or equal)](operator/greater-than-or-equal)
* [`?=`  (default assign)] - _doc coming soon at_ (operator/default-assign)
* [`?[]` (nullsafe-lookup)](operator/nullsafe-lookup)
* [`[]`  (lookup)](operator/lookup)
* [`[]`  (sequenced lookup)](operator/sequenced-lookup)
* [`[]`  (iterated lookup)](operator/iterated-lookup)
* [`[x..y]` (subrange)](operator/subrange)
* [`[x...]` (upper range)](operator/upper-range)
* [`[].` (spread member)] - _doc coming soon at_ (operator/spread)
* [`^`   (xor)](operator/xor) <!-- m2 -->
* [`^=`  (xor assign)](operator/xor-assign) <!-- m2 -->
* [`in`  (in)](operator/in)
* [`is`  (is)](operator/is)
* [`|`   (union)](operator/union) <!-- m2 -->
* [`|=`  (union assign)](operator/union-assign) <!-- m2 -->
* [`||`  (or)](operator/or)
* [`||=` (or assign)](operator/or-assign)
* [`{}`  (invoke)](operator/invoke)
* [`{}`  (null-safe invoke)](operator/nullsafe-invoke)
* [`{}`  (spread invoke)](operator/spread-invoke)
* [`~`   (complement)](operator/complement) <!-- m2 -->
* [`~`   (complement in)](operator/complement-in) <!-- m2 -->
* [`~=`  (complement assign)](operator/complement-assign) <!-- m2 -->


## Literals

* [Number literals](literal/number)
* [Float literals](literal/float)
* [String literals](literal/string)
* [Character literals](literal/character)
* [Single-quoted literals](literal/single-quoted)

## Language module (`ceylon.language`)

The API documentation for [`ceylon.language`](#{site.urls.apidoc}/ceylon/language).


## Tools

* The Java launcher, [`java`] - _doc coming soon at_ (tool/java)
* The Ceylon launcher, [`ceylon`](tool/ceylon)
* The Ceylon compiler, [`ceylonc`](tool/ceylonc)
* The Ceylon module information tool, [`ceylonp`](tool/ceylonp)
* The Ceylon documentation compiler, [`ceylond`](tool/ceylond)
* The Ceylon repository replicator, [`ceylonr`](tool/ceylonr)
* The Ceylon source archive extractor, [`ceylonf`](tool/ceylonf)

## Interoperability

* ['Calling' Ceylon from Java](interoperability/ceylon-from-java)
* ['Calling' Java from Ceylon](interoperability/java-from-ceylon)
* [Erasure](interoperability/erasure)
* [Ceylon Annotations for Java](interoperability/annotations)

## Other

* [`modules.ceylon-lang.org`] - _doc coming soon at_ (other/modules.ceylon-lang.org)
