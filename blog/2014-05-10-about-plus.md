---
title: About the plus symbol
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Operators in Ceylon can't be overloaded. That is to say, I
can't redefine an operator like `+` to do something totally
arbitrary, say, add a new element to a list. Instead,
the semantics of each operator is defined by the language
specification in terms of types defined in the language 
module. However, many of these types, and therefore the 
definitions of the operators associated with them, are quite
abstract. For example, `+` is defined in terms of an 
interface called `Summable`. So if you want to define your
own `Complex` number class, you just make it satisfy 
`Summable`, and you can use `+` to add complex numbers. We
call this approach _operator polymorphism_.

One of the first things people notice about Ceylon is that,
right after singing the praises of not having operator 
overloading, we go right ahead and use `+` for string 
concatenation! I've seen a number of folks object that 
string concatenation has nothing to do with numeric addition, 
and that this is therefore an example of us breaking our own 
rules.

Well, perhaps. I admit that the main motivation for using `+` 
for string concatenation is simply that this is what most
other programming languages use, and that therefore this is
what we find easiest on the eyes.

On the other hand, I don't think there's a strong reason to
object to the use of `+` for concatenation. There's no single
notion of "addition" in mathematics. Quite a few different 
operations are traditionally called "addition", and written 
with the `+` symbol, including addition of vectors and
matrices.

Generalizing over all these operations is the job of 
_abstract algebra_. So I recently spent some time nailing 
down and documenting how Ceylon's language module types and 
operators relate to the algebraic structures from abstract 
algebra.

The following three famous algebraic structures are of 
most interest to us:

- A _semigroup_ is a set of values with an associative
  binary operation.
- A _monoid_ is a semigroup with an identity element.
- A _group_ is a monoid where each value has an inverse 
  element.

If the binary operation is also commutative, we get a
_commutative semigroup_, a _commutative monoid_, or an
_abelian group_.

Finally, a _ring_ is a set of values with _two_ binary 
operations, named addition and multiplication, where:

- the ring is an abelian group with respect to addition,
- the ring is a monoid with respect to multiplication, and
- multiplication distributes over addition.

Strings with concatenation form a monoid, since string
concatenation is associative, and the empty string is an
identity element with respect to concatenation. They don't
form a group, since there are no inverse strings. Also, 
string concatenation isn't commutative.

On the other hand, integers with addition form an abelian 
group. Together with both addition and multiplication, 
the integers form a ring.

We could have chosen to say that Ceylon's `+` operator 
applies only to abelian groups, or perhaps only to groups,
or perhaps only to commutative monoids or only to
commutative semigroups. But any of those choices would be
as arbitrary as any other. Instead, we've decided to say 
that the interface `Summable` abstracts over all semigroups,
thereby blessing the use of `+` with any mathematical 
semigroup. Thus, we can legally use it to denote string 
concatenation or any other pure associative binary operation.

Furthermore:

- The interface `Invertable` abstracts over groups, allowing
  the use of the `-` operator with any mathematical group.
- The interface `Numeric` abstracts over _rings_, allowing
  the use of the `*` and `/` operators with any mathematical
  ring.

Of course, we could have called these interfaces `Semigroup`,
`Group`, and `Ring`, and that would have made us feel smart,
perhaps, but we're trying to communicate with programmers 
here, not mathematicians.
