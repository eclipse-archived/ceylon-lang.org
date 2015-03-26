---
layout: reference11
title_md: '`?.` (null-safe method) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary `?.` operator is used to invoke a method 
as if its right-hand operand were not `null`.

## Usage 

<!-- try: -->
    void m(Integer? num) {
        Integer?(Integer) plus = num?.plus;
    }

## Description

### Definition

See the [language specification](#{site.urls.spec_current}#nullvalues) for 
more details.

### Polymorphism

The `?.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `lhs?.rhs` operator is the callable type of the right 
hand operand, with the return type replaced by its corresponding optional type.

## See also

* [`?` (default)](../default) operator
* [`?.`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
