---
layout: reference12
title_md: '`?.` (null-safe attribute) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The left-associative, binary `?.` operator is used to access an attribute 
as if its right-hand operand were not `null`.

## Usage 

<!-- try: -->
    void m(Integer? num) {
        Integer? int = num?.positiveValue;
    }

## Description

### Definition

The meaning of `?.` is defined as follows:

<!-- check:none -->
<!-- try: -->
    if (exists lhs) lhs.member else null	

### Polymorphism

The `?.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `lhs?.rhs` operator is the optional type of the right 
hand operand.

## See also

* [`?` (default)](../default) operator
* [`?.`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
