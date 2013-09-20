---
layout: reference
title: '`exists` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

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

The type of `exists` is [`Boolean`](#{site.urls.apidoc_current}/Boolean.type.html).

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
