---
layout: reference
title: '`nonempty` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The non-associating, unary `nonempty` operator is used to test its operand for 
emptiness.

## Usage 

<!-- try: -->
    void m(Integer[] nums) {
        Boolean haveNums = nums nonempty;
    }

## Description

### Definition

The meaning of `exists` is defined as follows:

<!-- check:none -->
<!-- try: -->
    if (nonempty lhs) true else false

See the [`language specification`](#{site.urls.spec_current}#nullvalues) for more details.

### Polymorphism

The `nonempty` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Note

Do not to confuse the `nonempty` *operator* described here and which 
takes form `attribute nonempty` with the 
[`nonempty` *condition*](../../statement/conditions) used in `if`, `assert` and 
`while` statements and which takes the form 
`nonempty attribute`.

## See also

* [`nonempty`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
