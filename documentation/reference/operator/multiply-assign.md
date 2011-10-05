---
layout: reference
title: `*=` (multiply assign) operator
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

The right-associative, binary `*=` operator:

    variable Natural num := 1;
    num *= 2; // double num 
    num *= num; // square num

## Description

The `*=` operator multiplies it's left hand operand by the amount given by 
its right hand operand. 

### Side effects

In the process of performing a multiply & assign the left hand argument 
may be evaluated *more than once*, in contrast to how this operator is defined
in some other languages. This doesn't usually cause problems, but if evaluating
the left hand operand has side-effects it could result in unexpected behaviour,
as an example consider:

    void m(Natural[] seq, Natural index) {
        seq[index++] *= 2;
    }

The above code doesn't double the `index`<sup>th</sup> element of `seq`, as it 
may appear, it instead doubles the `index`<sup>th</sup> element and 
assigns the result to the (`index+1`)<sup>th</sup> element.

## See also

* [arithmetic operators](#{site.urls.spec}#arithmetic) in the 
  language specification
* [operator precedence](#{site.urls.spec}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  and 
  [Numeric operator semantics](/documentation/tour/language-module/#numeric_operator_semantics) 
  in the Tour of Ceylon
