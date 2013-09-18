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

_This page is incomplete. Want to help? [See how](/code/website)._


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
* [Values](structure/value)
* [Functions](structure/function)
* [Annotations](structure/annotation)

## Statements

* [`assert` statements](statement/assert) 
* [`break` statements](statement/break)
* [`continue` statements](statement/continue)
* [expression statements](statement/expression)
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

* [Expressions](expression)

## Operators

* [operator polymorphism](operator/operator-polymorphism)
* [`!`   (not)](operator/not)
* [`!=`  (not equal)](operator/not-equal)
* [`%`   (remainder)](operator/remainder)
* [`%=`  (remainder assign)](operator/remainder-assign)
* [`&`   (Set intersection)](operator/intersection) 
* [`&&`  (and)](operator/and)
* [`&&=` (and assign)](operator/and-assign)
* [`&=`  (Set intersect assign)](operator/intersect-assign)
* [`()`  (invoke)](operator/invoke)
* [`()`  (null-safe invoke)](operator/nullsafe-invoke)
* [`*`   (product)](operator/product)
* [`**`  (scale)](operator/scale)
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
* [`..`  (spanned range)](operator/spanned-range)
* [`:`   (segmented range)](operator/segmented-range)
* [`/`   (quotient)](operator/quotient)
* [`/=`  (divide assign)](operator/divide-assign)
* [`<`   (less than)](operator/less-than)
* [`<=`  (less than or equal)](operator/less-than-or-equal)
* [`<=>` (compare)](operator/compare)
* [`=`   (assign)](operator/assign)
* [`==`  (equal)](operator/equal)
* [`===` (identical)](operator/identical)
* [`>`   (greater than)](operator/greater-than)
* [`>=`  (greater than or equal)](operator/greater-than-or-equal)
* [`[]`  (lookup)](operator/lookup)
* [`*.` (spread attribute)](operator/spread-attribute)
* [`*.` (spread invoke)](operator/spread-invoke)
* [`x[y..z]` (span)](operator/span)
* [`x[y...]` (upper span)](operator/upper-span)
* [`x[...z]` (lower span)](operator/lower-span)
* [`x[y:n]`  (segment)](operator/segment)
* [`^`   (power)](operator/power)
* [`in`  (in)](operator/in)
* [`is`  (is)](operator/is)
* [`|`   (Set union)](operator/union) 
* [`|=`  (Set union assign)](operator/union-assign) 
* [`||`  (or)](operator/or)
* [`||=` (or assign)](operator/or-assign)
* [`{}`  (invoke)](operator/invoke)
* [`{}`  (null-safe invoke)](operator/nullsafe-invoke)
* [`~`   (Set complement)](operator/complement) 
* [`~=`  (Set complement assign)](operator/complement-assign) 
* [`else`](operator/else)
* [`then`](operator/then)


## Literals

* [`Integer` literals](literal/integer)
* [`Float` literals](literal/float)
* [`String` literals](literal/string)
* [`Character` literals](literal/character)

## Language module (`ceylon.language`)

The API documentation for [`ceylon.language`](#{site.urls.apidoc_current}).


## Tools

* The `ceylon` command, [`ceylon`](tool/ceylon)
* An index of [`ceylon` subcommands](#{site.urls.ceylon_tool_current}/index.html)
* The Ceylon [`Ant` tasks](tool/ant)
* The [configuration file format](tool/config)

## Interoperability

* [Calling Ceylon from Java](interoperability/ceylon-from-java)
* [Calling Java from Ceylon](interoperability/java-from-ceylon)
* [Type mapping](interoperability/type-mapping)
* [The JavaScript compiler](interoperability/js)

## Module repositories

* [Module repositories](repository)
* [`modules.ceylon-lang.org` aka Ceylon Herd](repository/modules.ceylon-lang.org)
* The [ceylon SDK](https://modules.ceylon-lang.org/categories/SDK)


