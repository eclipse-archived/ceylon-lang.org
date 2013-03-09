---
layout: tour
title: Tour of Ceylon&#58; Comprehensions
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the thirteenth stop in our Tour of Ceylon. In the 
[previous section](../named-arguments) we looked at invoking functions 
using named arguments. We're now ready to learn about _comprehensions_.


## Comprehensions

A comprehension is a convenient way to transform, filter, or combine a
stream or streams of values before passing the result to a function.
Comprehensions act upon, and produce, instances of 
[`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html).
A comprehension may appear:

- inside brackets, producing a sequence,
- inside braces, producing an iterable, or
- inside a named argument list. 

The syntax for instantiating a sequence, [that we met earlier](../sequences#sequence_syntax_sugar)
is considered to have a parameter of type `Iterable`, so we can use a 
comprehension to build a sequence:

<!-- try-pre:
    class Person(shared String name) {}
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

-->
<!-- try-post:

    print(names);
-->
    String[] names = [ for (p in people) p.name ]; 

But comprehensions aren't just useful for building sequences! Suppose 
we had a class `HashMap`, with the following signature:

<!-- try: -->
    class HashMap<Key,Item>({Key->Item*} entries) { ... }

Then we could construct a `HashMap<String,Person>` like this:

<!-- try: -->
    value peopleByName = HashMap { for (p in people) p.name->p };

As you've already guessed, the `for` clause of a comprehension works
a bit like the `for` loop we met earlier. It takes each element of
the `Iterable` stream in turn. But it does it _lazily_, when the 
receiving function actually iterates its argument!

This means that if the receiving function never actually needs to 
iterate the entire stream, the comprehension will never be fully 
evaluated. This is extremely useful for functions like `every()` and
`any()`:

<!-- try:
    class Person(shared String name, shared Integer age) {}
    value people = { Person("Wim", 43), Person("Zus", 20), Person("Jet", 37) };

    print(every { for (p in people) p.age>=18 });
-->
    if (every { for (p in people) p.age>=18 }) { ... }

The function `every()` (in `ceylon.language`) accepts a stream of
`Boolean` values, and stops iterating the stream as soon as it 
encounters `false` in the stream.

If we just need to store the iterable stream somewhere, without 
evaluating any of its elements, we can use an iterable constructor 
expression, like this:

<!-- try-pre:
    class Person(shared String name) {}
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

-->
<!-- try-post:

    print(names);
-->
    {String*} names = { for (p in people) p.name }; 

Now let's see what the various bits of a comprehension do.

## Transformation

The first thing we can do with a comprehension is transform the
elements of the stream using an expression to produce a new value
for each element. This expression appears at the end of a 
comprehension. It's the thing that the resulting `Iterable` actually
iterates!

For example, this comprehension 

<!-- try:
    class Person(name) { shared String name; }
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

    value ps = { for (p in people) p.name->p };
-->
    for (p in people) p.name->p

results in an `Iterable<String->Person>`. For each element of `people`,
a new `Entry<String,Person>` is constructed by the `->` operator.

## Filtering

The `if` clause of a comprehension allows us to skip certain elements
of the stream. This comprehension produces a stream of numbers which
are divisible by `3`.

<!-- try:
    print({for (i in 0..100) if (i%3==0) i});
-->
    for (i in 0..100) if (i%3==0) i

It's especially useful to filter using `if (exists ...)`.

<!-- try:
    class Person(name) {
        shared String name;
        shared variable Person? spouse = null;
        shared actual String string = name;
    }
    value wim = Person("Wim");
    value zus = Person("Zus");
    value jet = Person("Jet");
    wim.spouse = jet;
    jet.spouse = wim;
    value people = { wim, zus, jet };

    print({for (p in people) if (exists s=p.spouse) p->s});
-->
    for (p in people) if (exists s=p.spouse) p->s

You can even use [multiple `if` conditions](../attributes-control-structures#condition_lists):

    for (p in people) 
            if (exists s=p.spouse, 
                nonempty inlaws=s.parents) 
                    p->inlaws

## Products and joins

A comprehension may have more than one `for` clause. The allows us
to combine two streams to obtain a stream of values of their cartesian 
product:

<!-- try:
    class Node(Integer x, Integer y) { shared actual String string = "(" x "," y ")"; }

    print({for (i in 0..5) for (j in 0..5) Node(i,j)});
-->
    for (i in 0..100) for (j in 0..10) Node(i,j)

Even more usefully, it lets us obtain a stream of associated values,
a lot like a `join` in SQL.

<!-- try:
    class Employee(name) { shared String name; }
    class Organisation(name, employees) { shared String name; shared Employee[] employees; }
    value orgs = { Organisation("RedHat", { Employee("Joe"), Employee("Jack") }),
                   Organisation("Fedora", { Employee("Lisa") }) };

    print({for (o in orgs) for (e in o.employees) o.name->e.name});
-->
    for (o in orgs) for (e in o.employees) e.name

## There's more...

Next we're going to discuss some of the basic types from the 
[language module](../language-module), in particular numeric types, and 
introduce the idea of operator polymorphism.

You can read more about working with iterable objects in Ceylon in
[this blog post](/blog/2012/07/12/tricks-with-iterable).


