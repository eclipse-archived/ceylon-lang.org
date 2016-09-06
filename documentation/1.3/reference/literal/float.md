---
layout: reference13
title_md: '`Float` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---
# #{page.title_md}

A literal notation for a [`Float`](#{site.urls.apidoc_1_3}/Float.type.html) 
value.

## Usage 

A `Float` literal can be written in a variety of ways:

<!-- cat: void m() { -->
<!-- try: -->
    variable Float one = 1.0;
    one = 1.0000;
    
    variable Float oneMillion = 1000000.0;
    oneMillion = 1_000_000.0;
    oneMillion = 1.0M;
    oneMillion = 1.0e6;
    oneMillion = 1.0E+6;
    
    variable Float half = 0.5;
    half = 5.0E-1;
    half = 5.0e-1;
    half = 500m;
    half = 500.0m;
<!-- cat: } -->

## Description

### Decimal point

`Float` literals almost always contain a decimal point, `.`, which:

- separates the fractional part from the whole number part, and 
- syntactically distinguishes a `Float` literal from an `Integer` 
  literal.

The exception to this rule is any `Float` literal with a one of the 
"fractional" magnitude suffices (`m`, `u`, `n`, `p`, `f`).

### Decimal magnitude suffices

A `Float` literal may be written with a magnitude, a whole magnitude:

* `k` (kilo), 10<sup>3</sup>
* `M` (mega), 10<sup>6</sup>
* `G` (giga), 10<sup>9</sup>
* `T` (tera), 10<sup>12</sup>
* `P` (peta), 10<sup>15</sup>

Or a fractional magnitude:

* `m` (milli), 10<sup>-3</sup>
* `u` (micro), 10<sup>-6</sup> (strictly this should be mu (μ), but that
  would be too hard to type on most keyboards)
* `n` (nano), 10<sup>-9</sup>
* `p` (pico), 10<sup>-12</sup>
* `f` (femto), 10<sup>-15</sup>

For example:

<!-- try: -->
    Float million = 1.0M;
    Float millionth = 1u;

### Grouping digits

An underscore, `_`, may be used to separate groups of three digits in the 
integer or fractional part of the literal.

<!-- try: -->
    Float million = 1_000_000.0;
    Float millionth = 0.000_000_1;

### Exponential notation

Exponential notation is supported using `e` or `E` to separate the mantissa 
(before the `E`) from the scale (after the `E`). 

<!-- try: -->
    Float million = 2.0e6;
    Float millionth = 2.0e-6;

### As a primary

Invoking members of the class `Float` directly on a literal is permitted:

<!-- try: -->
    Float minusOneHalf = 0.5.negativeValue;

## See also

* [Numeric literals](#{page.doc_root}/tour/language-module/#numeric_literals) 
  in the Tour of Ceylon 
* [Numeric literals in the language specification](#{site.urls.spec_current}#numericliterals)

