---
layout: reference
title: `Number` literals
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

## Usage 

A `Number` literal can be written an a variety of ways


    Number one = 1;
    variable Number oneMillion := 1000000;
    oneMillion := 1_000_000;
    oneMillion := 1M;

## Description

At its simplest, a `Number` literal is just a series of decimal digits, 
`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8` and `9`. Other digit characters 
(digits from other scripts) are not allowed.

Number literals with a leading zero (`0`) are allowed, but unlike other 
C-like programming languages such numbers are *not* treated as octal. 
Neither octal nor hexadecimal notation is supported using the literal format.

To ease reading long number literals, groups of three digits may be separated 
with an underscore (`_`), similar to how a comma or stop is used as a thousands
separator in many written numbers. Only the left-most group may have one or 
two digits.

Use of one of the following metric magnitudes as a suffix is supported:

* `k` (kilo), 10<sup>3</sup>
* `M` (mega), 10<sup>6</sup>
* `G` (giga), 10<sup>9</sup>
* `T` (tera), 10<sup>12</sup>
* `P` (peta), 10<sup>15</sup>

Ceylon does not have direct support for `Integer` literals. If an `Integer` is
required the [unary plus](../../operator/unary_plus) 
(or [unary minus](../../operator/unary_minus), if a negative value is required) 
operator can be used in the  declaration of the `Integer`, like this:


    Integer two = +2;
    Integer minusTwo = -2;

## See also

* [Numeric literals](/documentation/tour/language-module/#numeric_literals) 
  in the Tour of Ceylon 
* [unary plus](../../operator/unary_plus) and [unary minus](../../operator/unary_minus)

