---
layout: reference
title_md: '`exists` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, unary postfix `exists` operator is used to test its operand for 
nullness.

## Usage 

<!-- try: -->
    void m(Integer? num) {
        Boolean haveNum = num exists;
    }

## Description

### Definition

The meaning of `exists` is defined as follows:

<!-- check:none -->
<!-- try: -->
    if (exists lhs) true else false

### Polymorphism

The `exists` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `exists` operator is [`Boolean`](#{site.urls.apidoc_1_0}/Boolean.type.html).

### Note

Do not to confuse the `exists` *operator* described here and which 
takes postfix form `attribute exists` with the 
[`exists` *condition*](../../statement/conditions) used in `if`, `assert` and 
`while` statements and which takes the prefix form 
`exists attribute`.

## See also

* [`exists`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
