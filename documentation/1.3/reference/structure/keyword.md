---
layout: reference13
title_md: Keywords
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

Keywords are reserved tokens whose role in the language is defined in the 
language specification. They may not be used as identifiers.

## Usage 

Usage depends on the keyword in question.

## Description

The following are reserved keywords:

* `abstracts` (currently unused)
* [`alias`](../alias#type_aliases)
* `assembly` (currently unused)
* [`assert`](../../statement/assert)
* [`assign`](../value#a_value_setter)
* [`break`](../../statement/break)
* [`case`](../../statement/switch)
* [`catch`](../../statement/try)
* [`class`](../class)
* [`continue`](../../statement/continue)
* [`dynamic`](../dynamic/)
* `else` 
   (used with the [`for`](../../statement/for), 
   [`if`](../../statement/if) and 
   [`switch`](../../statement/switch) statements, in the
   [`if`](../../expression/if/) expression and as an
   [operator](../../operator/else/))
* `exists` 
   (used with [`if`](../../statement/if#if_exists_) and as an 
   [operator](../../operator/exists))
* `extends`
    used in [class declarations](../class) to specify the superclass and 
    invoke superclass initializers, and also in [constructor declarations](../class#constructor_declarations) 
    to invoke superclass constructors.
* [`finally`](../../statement/try)
* [`for`](../../statement/for)
* [`function`](../type-inference)
* [`given`](../type-parameters#constraints)
* `if`
    used for the [`if` statement](../../statement/if)
    and the [`if` expression](../../expression/if)
* [`import`](../../statement/import)
* `in` 
   (used for [variance](../type-parameters#variance) and with the
   [`for`](../../statement/for) statement and as an
   [operator](../../operator/in))
* [`interface`](../interface)
* `is` (used in the [`if`](../../statement/if#special_conditions),
   [`while`](../../statement/while#special_conditions), and 
   [`case`](../../statement/switch#caseis_assignability_condition) 
   statements and as an [operator](../../operator/is))
* [`let`](../../expression/let)
* [`module`](../module#descriptor)
* [`new`](../class#constructor_declarations)
* `nonempty` (used in the [`if`](../../statement/if#special_conditions),
   [`while`](../../statement/while#special_conditions), and 
   [`case`](../../statement/switch#caseis_assignability_condition) 
   statements and as an [operator](../../operator/nonempty))
* [`object`](../object)
* `of` (used with [`class`](../class) and 
   [`interface`](../interface) declarations) and as an 
   [operator](../../operator/of))
* [`out`](../type-parameters#variance)
* [`outer`](../../expression/#self_and_outer_references)
* [`package`](../package#usage)
* [`return`](../../statement/return)
* `satisfies` (used in [`class`](../class) and 
   [`interface`](../interface) declarations)
* [`super`](../../expression/#self_and_outer_references)
* `switch` is used for the [`switch` statement](../../statement/switch)
  and the [`switch` expression](../../expression/switch)
* `then` is used in [`if` expressions](../../expression/if/) 
  and also as the [`then` operator](../../operator/then)
* [`this`](../../expression/#self_and_outer_references)
* [`throw`](../../statement/throw)
* [`try`](../../statement/try)
* [`value`](../type-inference)
* [`void`](../function#return_type)
* [`while`](../../statement/while)


### Quoting

It is possible to *quote* keywords, creating an identifier from a character
sequence which would otherwise be treated as keyword by the lexer. For example 
`\iout` creates an identifier called `out`. The intended purpose of quoting is
interoperation with other languages. For example, it may be necessary to invoke 
or refine a method named `out` on a class written in Java (where `out` is not a 
keyword).

### Annotations

Other identifiers commonly seen in declarations (such as `shared`) are not 
keywords but [annotations](../annotation). 

## See also

* [Identifiers and keywords](#{site.urls.spec_current}#identifiersandkeywords)
  in the Ceylon specification

