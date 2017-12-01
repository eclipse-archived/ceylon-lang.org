---
layout: reference
title_md: '`nonempty` operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The non-associating, unary postfix `nonempty` operator is used to test its operand for 
emptiness.

## Usage 

<!-- try: -->
    void m(Integer[] nums) {
        Boolean haveNums = nums nonempty;
    }

## Description

### Definition

The meaning of `nonempty` is defined as follows:

<!-- check:none -->
<!-- try: -->
    if (nonempty lhs) true else false

See the [`language specification`](#{site.urls.spec_current}#nullvalues) for more details.

### Polymorphism

The `nonempty` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `nonempty` operator is [`Boolean`](#{site.urls.apidoc_1_0}/Boolean.type.html).

### Note

Do not to confuse the `nonempty` *operator* described here and which 
takes postfix form `attribute nonempty` with the 
[`nonempty` *condition*](../../statement/conditions) used in `if`, `assert` and 
`while` statements and which takes the prefix form 
`nonempty attribute`.

## See also

* [`nonempty`](#{site.urls.spec_current}#nullvalues) in the language specification.
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
