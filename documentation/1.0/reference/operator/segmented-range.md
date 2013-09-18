---
layout: reference
title: '`:` (segmented range) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The *segmented range* operator creates a `Range` from its endpoints.

## Usage 

    Range<Integer> ten = 1:10;

## Description


### Definition

The `lhs:rhs` operator is defined in pseudocode as:

<!-- check:none -->
    rhs <=0 then [] else Range(lhs, {lhs++ rhs times} )

See the [language specification](#{site.urls.spec_current}#constructors) for 
more details.

### Polymorphism

The `:` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The meaning of `:` depends on the 
[`Range`](#{site.urls.apidoc_current}/Range.type.html) 
class.

## See also

* [`..` (spanned range)](../spanned-range)
* [object creation operators](#{site.urls.spec_current}#constructors) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

