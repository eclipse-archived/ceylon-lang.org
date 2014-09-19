---
layout: reference
title_md: '`Integer` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

A literal notation for an [`Integer`](#{site.urls.apidoc_current}/Integer.type.html) 
value.

## Usage 

An `Integer` literal may be written an a variety of ways

<!-- cat: void m() { -->
<!-- try: -->
    Integer one = 1;
    variable Integer oneMillion = 1000000;
    oneMillion = 1_000_000;
    oneMillion = 1M;
<!-- cat: } -->

## Description

At its simplest, an `Integer` literal is just a series of decimal digits, 
`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8` and `9`. Other digit characters 
(digits from other scripts) are not allowed.

When a negative number is required, the [unary minus](../../operator/unary_minus) 
operator may be used, like this:

<!-- try: -->
    Integer minusTwo = -2;

### Leading zeros

`Integer` literals with a leading zero, `0`, are allowed, but unlike other 
C-like programming languages, such literals are *not* interpreted using 
octal notation. 

### Grouping digits

To make long integer literals easier to read, groups of three digits may be 
separated with an underscore, `_`, similar to how a comma or stop is used 
as a thousands separator in many written numbers. Only the left-most group 
may have one or two digits.

### Decimal suffixes

Use of one of the following metric magnitudes as a suffix is supported:

* `k` (kilo), 10<sup>3</sup>
* `M` (mega), 10<sup>6</sup>
* `G` (giga), 10<sup>9</sup>
* `T` (tera), 10<sup>12</sup>
* `P` (peta), 10<sup>15</sup>

For example:

    Integer oneThousand = 1k;
    
### Binary literals

A binary integer can be written with a `$` prefix, and again `_` may be 
used to group digits, but binary digit groups are of length 4.

For example:

<!-- try: -->
    Integer eight = $1001; // binary literal

### Hexadecimal literals

A hexadecimal integer can be written with a `#` prefix, and again `_` 
may be used to group digits, but hexadecimal digit groups are of length
2 or 4.

<!-- try: -->
    Integer red = #ff_00_00; // hex literal

### As a primary

Invoking members of the class `Integer` directly on a literal is permitted:

<!-- try: -->
    Integer minusFive = 5.negativeValue;

## See also

* [Numeric literals](#{page.doc_root}/tour/language-module/#numeric_literals) 
  in the Tour of Ceylon 
* [unary plus](../../operator/unary_plus) and [unary minus](#{page.doc_root}/reference/operator/unary_minus)

