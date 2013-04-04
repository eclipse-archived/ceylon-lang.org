---
layout: reference
title: Operator Polymorphism
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../../..
---

# #{page.title}

## Description

### Primitive and polymorphic operators

Almost all of the operators in Ceylon can be expressed in terms of 
methods defined on classes and/or interfaces in the language module. 
Those operators which do not have such a definition are called 
*primitive* operators. The primitive operators are:

* `.` (member), 
* `=` (assignment), 
* `==` (identity), 
* `is`, 
* `of`, 
* `()` (positional invocation),
* `{}` (named argument invocation)

Many non-primitive operators are *polymorphic*, which means that it 
is possible to specify the behaviour of operators in a type-specific 
way by satisfying the interface(s) used in the operator's definition.

Not every non-primitive operators are polymorphic. Some are defined 
only in terms of the primitive operators, for example.

### Simple Example

A simple example might be writing a complex number class which implements
`Exponentiable`. This would allow us to write expressions using the 
operators `+` (unary plus), `-` (unary minus), `+` (sum), `-` (difference), 
`*` (product), `/` (quotient), and `^` (power). For example:

    class Complex(shared Float re, shared Float im) 
            satisfies Exponentiable<Complex,Integer> {
        
        positiveValue => this;
    
        negativeValue => Complex(-re,-im);
    
        plus(Complex other) => Complex(re+other.re, im+other.im);
    
        minus(Complex other) => Complex(re-other.re, im-other.im);
    
        times(Complex other) =>
                Complex(re*other.re-im*other.im, 
                        re*other.im+im*other.re);
        
        shared actual Complex divided(Complex other) {
            Float d = other.re^2 + other.im^2;
            return Complex((re*other.re+im*other.im)/d, 
                           (im*other.re-re*other.im)/d);
        }
        
        shared actual Complex power(Integer other) {
            "exponent must be non-negative"
            assert(other>=0);
            //lame impl
            variable Complex result = Complex(1.0, 0.0);
            for (i in 0:other) {
                result*=this;
            }
            return result;
        }
    
        string => im<0.0 then "``re``-``-im``i" 
                         else "``re``+``im``i";
        
        hash => re.hash + im.hash;
        
        shared actual Boolean equals(Object that) {
            if (is Complex that) {
                return re==that.re && im==that.im;
            }
            else {
                return false;
            }
        }
        
    }
    
    Complex i = Complex(0.0, 1.0);
    Complex a = Complex(1.0, 2.0); // 1 + 2i
    Complex b = Complex(4.0, 2.0); // 4 + 2i
    Complex d = a * b + i;
    if (d == z) {
        print("``d`` == ``z``");
    }
    else {
        print("``d`` != ``z``");
    }

### Identities

There are certain *identities* which are true of numbers (and of the built-in
numeric types), which may not hold with arbitrary types. For example, given any 
`x` and `y` of a type `T` which implements `Invertable` and `Summable`, the 
following identity *should* be satisfied:

<pre>
    <i>x</i> - <i>y</i> ≡ <i>x</i> + (-<i>y</i>)
</pre>

Unfortunately, Ceylon can't validate that the above identity holds for `T`'s 
implementation of `Invertable` and `Summable`. 

### Advice

The single most important thing to remember is that 
**if an identity does not apply for `T` then you cannot use that identity to 
rewrite expressions involving `T`**.

Philosophically, the operator symbols are just notation and Ceylon simply
defines how those operators work in terms of the various interfaces. It's up 
to the author of a class to decide what those symbols ought to mean for that 
class, *bearing in mind those symbols have a conventional meaning*.

Pragmatically, that same author would be ill-advised to try giving radically 
different meanings to those operators: doing so will only confuse people.

Our advice is that if a type has a notion of arithmetic (or whatever) 
which closely conforms to numerical arithmetic, then by all means implement 
`Numeric` (or whatever). If you do, then document clearly any identities which 
do not hold.

If on the other hand, the type *doesn't* have some notion of arithmetic, then 
*don't* confuse people by making operators do funky things: plain old method 
calls will be clearest.

The user of a class which implements the various operator interfaces is 
advised to be cautious about assuming the truth of identities which are not 
documented as being satisfied.


## See also

* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

