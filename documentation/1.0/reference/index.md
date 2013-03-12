---
layout: reference
title: Reference
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ..
---

# #{page.title}

This page lists concepts and links to their descriptions. The complete 
[language specification](#{page.doc_root}/spec) is also available.

_This page is very incomplete. Want to help? [See how](/code/website)._


## Structure and Declarations

* [Keywords](structure/keyword)
* [Modules](structure/module)
* [Packages](structure/package)
* [Compilation units](structure/compilation-unit)
* [Types](structure/type)
* [Type abbreviations](structure/type-abbreviation)
* [Type parameters](structure/type-parameters)
* [Classes](structure/class)
* [Interfaces](structure/class)
* [`object`s](structure/object)
* [Methods](structure/method)
* [Attributes](structure/attribute)
* [Annotations](structure/annotation) <!-- m5 -->

## Statements

* [`assert` statements](statement/assert) <!-- m4 -->
* [`break` statements](statement/break)
* [`continue` statements](statement/continue)
* [expression statements](expression)
* [`for` statements](statement/for)
* [`if` statements](statement/if)
* [`import` statements](statement/import)
* [`return` statements](statement/return)
* [`=` (specification) statement](statement/specification)
* [`switch` statements](statement/switch)
* [`throw` statements](statement/throw)
* [`try` statements](statement/try)
* [`while` statements](statement/while)

## Expressions

* [What is an expression](expression)
* [Attribute Evaluation](expression/attribute-evaluation)
* [Attribute Assignment](expression/attribute-assignment)
* [Callable References](expression/callable-reference)
* [Class Instantiation](expression/class-instantiation)
* [Literals](#literals)
* [Metamodel References](expression/metamodel-reference) <!-- m5 -->
* [Method Invocation](expression/invocation)
* [Operator expressions](#operators)
* [`this`](expression/this)
* [`outer`](expression/outer) <!-- m3 -->
* [`super`](expression/super)
* [`::` supertype access](expression/supertype-access) <!-- m4 -->
* [Sequence Instantiation](expression/sequence-instantiation)
* [String Templates](expression/string-template)

## Operators

* [operator polymorphism](operator/operator-polymorphism)
* [`!`   (not)](operator/not)
* [`!=`  (not equal)](operator/not-equal)
* [`%`   (remainder)](operator/remainder)
* [`%=`  (remainder assign)](operator/remainder-assign)
* [`&`   (Set intersection)](operator/intersection) <!-- m3 -->
* [`&&`  (and)](operator/and)
* [`&&=` (and assign)](operator/and-assign)
* [`&=`  (Set intersect assign)](operator/intersect-assign) <!-- m3 -->
* [`()`  (invoke)](operator/invoke)
* [`()`  (null-safe invoke)](operator/nullsafe-invoke)
* [`*`   (product)](operator/product)
* [`^`   (power)](operator/power)
* [`*=`  (multiply assign)](operator/multiply-assign)
* [`+`   (sum)](operator/sum)
* [`+`   (unary plus)](operator/unary_plus)
* [`++`  (increment)](operator/increment)
* [`+=`  (add assign)](operator/add-assign)
* [`-`   (difference)](operator/difference)
* [`-`   (unary minus)](operator/unary_minus)
* [`--`  (decrement)](operator/decrement)
* [`-=`  (subtract assign)](operator/subtract-assign)
* [`->`  (entry)](operator/entry)
* [`.`   (member)](operator/member)
* [`..`  (range)](operator/range)
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
* [`?[]` (nullsafe-lookup)](operator/nullsafe-lookup)
* [`[]`  (lookup)](operator/lookup)
* [`[].` (spread attribute)](operator/spread-attribute)
* [`[].` (spread invoke)](operator/spread-invoke)
* [`[x..y]` (span)](operator/span)
* [`[x...]` (upper span)](operator/upper-span)
* [`^`   (Set exclusive union)](operator/exclusive-union) <!-- m3 -->
* [`^=`  (Set exclusive union assign)](operator/exclusive-union-assign) <!-- m3 -->
* [`in`  (in)](operator/in)
* [`is`  (is)](operator/is)
* [`|`   (Set union)](operator/union) <!-- m3 -->
* [`|=`  (Set union assign)](operator/union-assign) <!-- m3 -->
* [`||`  (or)](operator/or)
* [`||=` (or assign)](operator/or-assign)
* [`{}`  (invoke)](operator/invoke)
* [`{}`  (null-safe invoke)](operator/nullsafe-invoke)
* [`~`   (Set complement)](operator/complement) <!-- m3 -->
* [`~=`  (Set complement assign)](operator/complement-assign) <!-- m3 -->


## Literals

* [Number literals](literal/number)
* [Float literals](literal/float)
* [String literals](literal/string)
* [Character literals](literal/character)
* [Single-quoted literals](literal/single-quoted) <!-- m-later -->

## Language module (`ceylon.language`)

The API documentation for [`ceylon.language`](#{page.doc_root}/api/ceylon/language).


## Tools

* The `ceylon` command, [`ceylon`](tool/ceylon)
* An index of [`ceylon` subcommands](tool/ceylon/subcommands)
* The Ceylon [`Ant` tasks](tool/ant)

## Interoperability

* ['Calling' Ceylon from Java](interoperability/ceylon-from-java)
* ['Calling' Java from Ceylon](interoperability/java-from-ceylon)
* [Type mapping](interoperability/type-mapping)

## Module repositories

* [Module repositories](repository)
* [`modules.ceylon-lang.org` aka Ceylon Herd](repository/modules.ceylon-lang.org)
