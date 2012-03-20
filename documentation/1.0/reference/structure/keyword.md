---
layout: reference
title: Keywords
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

Keywords are reserved tokens whose role in the language is defined in the 
language specification.

## Usage 

Usage depends on the keyword in question.

## Description

The keywords in Ceylon are:

* `adapts`
* [`abstracts`](../type-parameters#constraints)
* [`assign`](../attribute#attribute_setters)
* [`break`](../../statement/break)
* [`case`](../../statement/switch)
* [`catch`](../../statement/try)
* [`class`](../class)
* [`continue`](../../statement/continue)
* `else` 
   (used with [`for`](../../statement/for), 
   [`if`](../../statement/if) and 
   [`switch`](../../statement/switch))
* `exists` 
   (used with [`if`](../../statement/if#if_exists_) and as an 
   [operator](../../operator/exists))
* `extends` 
   (used with [class](../class), and as an 
   [operator](../../operator/exists))
* [`finally`](../../statement/try)
* [`for`](../../statement/for)
* [`function`](../attribute#type_inference)
* [`given`](../type-parameters)
* [`if`](../../statement/if)
* [`import`](../../statement/import)
* `in` 
   (used for [variance](../type-parameters#variance) and with 
   [`for`](../../statement/for))
* [`interface`](../interface)
* `is` (used in [`if`](../../statement/if#if_is_) and 
   [`case`](../../statement/switch))
* `nonempty`
* [`object`](../object)
* `of` 
   (used with [`class`](../class) and 
   [`interface`](../interface) declarations)
* [`out`](../type-parameters#variance)
* [`outer`](../../expression/outer)
* [`return`](../../statement/return)
* `satisfies` 
   (used in [`class`](../class) and 
   [`interface`](../interface) declarations and with
   [`if`](../../statement/if#if_satisfies_) and
   [`case`](../../statement/switch))
* [`super`](../../expression/super)
* [`switch`](../../statement/switch)
* `then`
* [`this`](../../expression/this)
* [`throw`](../../statement/throw)
* [`try`](../../statement/try)
* [`value`](../attribute#type_inference)
* `void`
* [`while`](../../statement/while)


### Quoting

It is possible to *quote* keywords, creating an identifier which would 
otherwise be treated as keyword by the lexer. For example `\iout` creates an 
identifier called `out`. The intended purpose of quoting for interoperability 
with other platforms/languages. For example it may be necessary to invoke or 
override a method called `out` on a class written in 
Java (where `out` is not a keyword).

### Annotations

Other identifiers commonly seen in declarations (such as `shared`) are not 
keywords but [annotations](../annotation). 

## See also

* [Annotations](../../../tour/annotations) on the Tour of Ceylon
* [Identifiers and keywords](#{page.doc_root}/#{site.urls.spec_relative}#identifiersandkeywords)
  in the Ceylon specification.


