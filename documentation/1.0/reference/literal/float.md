---
layout: reference
title: `Float` literals
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---
# #{page.title}

## Usage 

A `Float` literal can be written in a variety of ways:


    variable Float one := 1.0;
    one := 1.0000;
    
    variable Float oneMillion := 1000000.0;
    oneMillion := 1_000_000.0;
    oneMillion := 1.0M;
    oneMillion := 1.0e6;
    oneMillion := 1;0E+6;
    
    variable Float half := 0.5;
    half := 5.0E-1;
    half := 5.0e-1;
    half := 500m;
    half := 500.0m;

## Description

`Float` literals usually use a decimal point (`.`) to separate the fractional 
part from the whole number part. Like [`Number` literals](../number) use of an 
underscore (`_`) to separate groups of three digits in the integer part of the 
number is supported (it is not permitted in the fractional part).

The one exception to the *always-has-a-decimal* rule is when one of the 
following metric magnitudes is used as a suffix:

* `m` (milli), 10<sup>-3</sup>
* `u` (micro), 10<sup>-6</sup> (strictly this should be mu (μ), but that's too 
  hard to type on most keyboards)
* `n` (nano), 10<sup>-9</sup>
* `p` (pico), 10<sup>-12</sup>
* `f` (femto), 10<sup>-15</sup>

As well as the above magnitudes, the following magnitudes are also 
supported, but require a fractional part to the number before the suffix:

* `k` (kilo), 10<sup>3</sup>
* `M` (mega), 10<sup>6</sup>
* `G` (giga), 10<sup>9</sup>
* `T` (tera), 10<sup>12</sup>
* `P` (peta), 10<sup>15</sup>:

Exponential notation is supported using `e` or `E` to separate the mantissa 
(before the `E`) from the scale (after the `E`). 

Invoking `Float` members directly on `Float` literals is permitted:


    Integer minusOneHalf = 0.5.negativeValue;

## See also

* [Numeric literals](#{page.doc_root}/tour/language-module/#numeric_literals) 
  in the Tour of Ceylon 
* [Numeric literals in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#numericliterals)

