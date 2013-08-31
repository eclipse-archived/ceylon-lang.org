---
layout: reference
title: '`/=` (divide assign) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The right associative, binary `/=` operator divides it's left-hand operand by 
the amount given by its right-hand operand. 

## Usage 

<!-- cat: void m() { -->
    variable Float num = 1.0;
    num /= 2.0; // half num 
<!-- cat: } -->

## Description


### Definition

The `/=` operator is defined as follows

    lhs = lhs.divided(rhs)

except that `lhs` is evaluated only once.

See the [language specification](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) for more details.

### Polymorphism

The `/=` operator is [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 
The definition of the `/=` operator depends 
on the [`Numeric`](#{site.urls.apidoc_current}/interface_Numeric.html) 
interface.

## See also

* [arithmetic operators](#{page.doc_root}/#{site.urls.spec_relative}#arithmetic) in the 
  language specification
* [operator precedence](#{page.doc_root}/#{site.urls.spec_relative}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](#{page.doc_root}/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
