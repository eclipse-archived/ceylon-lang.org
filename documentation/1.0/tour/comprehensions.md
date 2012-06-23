---
layout: tour
title: Tour of Ceylon&#58; Comprehensions
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the twelfth stop in our Tour of Ceylon. In the 
[previous section](../named-arguments) we looked at invoking functions 
using named arguments. We're now ready to learn about _comprehensions_.


## Comprehensions

A comprehension is a convenient way to tranform, filter, or combine a
stream or streams of values before passing the result to a function.
Comprehensions always appear as arguments to 
[sequenced parameters](../named-arguments/#sequenced_parameters)
and always act upon, and produce, instances of 
[`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html).

The syntax for instantiating a sequence, [that we met earlier](../sequences#sequence_syntax_sugar)
is considered to have a sequenced parameter, so we can use a comprehension
to build a sequence:

    value names = { for (p in people) p.name }; 

But comprehensions aren't just useful for building sequences! Suppose 
we had a class `HashMap`, with the following signature:

    class HashMap<Key,Item>(Key->Item... entries) { ... }

Then we could construct a `HashMap` like this:

    value peopleByName = HashMap(for (p in people) p.name->p);

Or, equivalently (using a named argument invocation), like this:

    value peopleByName = HashMap { for (p in people) p.name->p };

As you've already guessed, the `for` clause of a comprehension works
a bit like the `for` loop we met earlier. It takes each element of
the `Iterable` stream in turn. But it does it _lazily_, when the 
receiving function actually iterates its argument!

This means that ifthe receiving function never actually needs to 
iterate the entire stream, the comprehension will never be fully 
evaluated. This is extremely useful for functions like `every()` and
`any()`:

    if (every(for (p in people) p.age>=18)) { ... }

The function `every()` (in `ceylon.language`) accepts a stream of
`Boolean` values, and stops iterating the stream as soon as it 
encounters `false` in the stream. 

Now let's see what the other bits of a comprehension do.

## Transformation

The first thing we can do with a comprehension is tranform the
elements of the stream using an expression to produce a new value
for each element. This expression appears at the end of a 
comprehension. It's the thing that the resulting `Iterable` actually
iterates!

For example, this comprehension 

    for (p in people) p.name->p

results in an `Iterable<String->Person>`. For each element of `people`,
a new `Entry<String,Person>` is constructed by the `->` operator.

## Filtering

The `if` clause of a comprehension allows us to skip certain elements
of the stream. This comprehension produces a stream of numbers which
are divisible by `3`.

    for (i in 0..100) if (i%3==0) i

It's especially useful to filter using `if (exists ...)`.

    for (p in people) if (exists s=p.spouse) p->s

## Products and joins

A comprehension may have more than one `for` clause. The allows us
to combine two streams to obtain a stream of values of their cartesian 
product:

    for (i in 0..100) for (j in 0..10) Node(i,j)

Even more usefully, it lets us obtain a stream of associated values,
a lot like a `join` in SQL.

    for (o in orgs) for (e in o.employees) e.name

## There's more...

Next we're going to discuss some of the basic types from the 
[language module](../language-module), in particular numeric types, and introduce 
the idea of operator polymorphism. 


