---
layout: reference
title: Operator Polymorphism
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Description

Ceylon supports *operator polymorphism*, which means that most of the
[operators](../..index#operators) in the language correspond to methods
defined on interfaces in the language module. This means that it is possible to 
specify the behaviour of operators in a type-specific way.

### Simple Example

A simple example might be writing a complex number class which implements
`Invertable`, `Number`, `Numeric`, `Castable`  and `Equality`. 
This would allow you to write expressions using the 
operators `+` (unary plus), `-` (unary minus), 
`+` (sum), `-` (difference), `*` (product), `/` (quotient),
`==` (equality) and `!=` (inequality). For example

    void m(Complex z) {
        Complex a = Complex(1, 2); // 1 + 2i
        Complex b = Complex(4, 2); // 4 + 2i
        Complex c = Complex(0, 1); // i
        Complex d = a * b + c;
        if (d == z) {
            print("" d "==" z "");
        } else {
            print("" d "!=" z "");
        }
    }

### Identities

There are certain *identities* which are true of numbers (and of the built-in
numeric types), which may not hold with arbitrary types. 

As an example variables `x` and `y` of a type `T` which has overridden 
`Invertable` and `Numeric`; according to the rules of arithmetic the 
following identity *should* apply:

    x - y ≡ x + (-y)

Ceylon does not (and cannot) check whether the above identity holds for 
`T`'s implementation of `Invertable` and `Numeric`. 

If an identity does not apply for `T` then you cannot use that identity to 
rewrite expressions involving `T`.

Philosphically, the operator symbols are just notation and Ceylon simply
defines how those operators work in terms of the various interfaces. It's up 
to the author to decide what those symbols ought to
mean, *bearing in mind those symbols have a conventional meaning*.

Pragmatically, that same author would be ill-advised to try giving radically 
different meanings to those operators: Doing so will only confuse 
people.

Our advice is that if a type has a notion of arithmetic (or whatever) 
which closely conforms to numerical arithmetic, then by all means implement 
`Numeric` (or whatever). If you do, then document clearly any identities which 
do not hold. 

If on the other hand, the type *doesn't* have some notion of arithmetic, then 
*don't* confuse people by making operators do funky things: Plain old method 
calls will be clearest.

The user of a class which implements the various operator interfaces is 
advised to be cautious about assuming the truth of identities which are not 
documented as being satisfied.

### Non-polymorphic operators

The following operators are fundamental and not polymorphic: 

* `.` (member), 
* `:=` (assignment), 
* `is`, 
* `()` (positional invocation),
* `{}` (named argument invocation)


## See also

* [Operator polymorphism](/documentation/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

