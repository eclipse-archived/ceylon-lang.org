---
layout: tour13
title: Comprehensions
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the thirteenth stop in our Tour of Ceylon. In the 
[previous section](../named-arguments) we looked at invoking functions 
using named arguments. We're now ready to learn about _comprehensions_.


## Comprehensions

A comprehension is a convenient way to transform, filter, or combine a
stream or streams of values before passing the result to a function.
Comprehensions act upon, and produce, instances of 
[`Iterable`](#{site.urls.apidoc_1_3}/Iterable.type.html).
A comprehension may appear:

- inside braces, producing an iterable,
- inside brackets, producing a sequence, 
- inside a positional argument list, as an argument to a 
  [variadic parameter](../basics/#variadic_parameters), or
- inside a named argument list, as an 
  [iterable argument](../named-arguments/#iterable_arguments). 

### Comprehensions in iterable and sequence instantiation expressions

The brace syntax for [instantiating an iterable](../sequences#streams_iterables)
accepts a comprehension, so we can use a comprehension to transform any
iterable:

<!-- try-pre:
    class Person(shared String name) {}
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

-->
<!-- try-post:

    print(names);
-->
    {String*} names = { for (p in people) p.name };

Executing the above line of code doesn't actually _do_ very much. In 
particular it doesn't actually iterate the collection `people`, or 
evaluate the `name` attribute. That's because elements of the resulting 
`Iterable` are evaluated _lazily_.

The bracket syntax for [instantiating a sequence](../sequences#sequence_syntax_sugar)
also accepts a comprehension, so we can use a comprehension to build a sequence:

<!-- try-pre:
    class Person(shared String name) {}
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

-->
<!-- try-post:

    print(names);
-->
    String[] names = [ for (p in people) p.name ];

Since sequences are by nature immutable, executing the previous 
statement _does_ iterate the `people` and evaluate their 
`name`s. But it's best to think of that as the effect of the
bracket syntax, not of the comprehension itself.

Now, comprehensions aren't only useful for building iterables and 
sequences! They're a significantly more general purpose construct. 
The idea is that you can write a comprehension anywhere the language 
syntax accepts multiple values. That is to say, anywhere you could 
write a list of comma-separated expressions, or spread an iterable 
using `*`.

(Aside: actually, we sometimes prefer think of the iterable 
instantiation syntax and sequence instantiation syntax as just a
syntactic shorthand for an [ordinary named argument instantiation 
expression](../named-arguments/#iterable_arguments). That's not 
_precisely_ how the language specification defines these constructs, 
but it's a useful mental model to keep handy. So the idea is that 
anything we can write inside braces or brackets should also be 
syntactically legal inside a named argument list.)

### Gotcha!

It's important to have the right mental model of where a comprehension
starts and finishes and what precisely it means. The comprehension is 
the bit which starts with `for`, and ends in an expression. The braces 
or brackets are _not_ included. 

A comprehension produces multiple values, not a single value.
_Therefore a comprehension is not considered an expression and we
can't directly assign a comprehension to a value reference!_ If we 
just need to store the iterable stream somewhere, without evaluating 
any of its elements, we can use an iterable instantiation expression, 
exactly like the one we've just seen.

### Comprehensions as variadic arguments

One place where the language "accepts multiple values" is in the
positional argument list for a function with a variadic parameter.

<!-- try-pre:
    class Person(shared String name) {}
    value people = { Person("Gavin"), Person("Stephane"), Person("Tom"), Person("Tako") };

-->
    void printNames(String* names) => printAll(names, " and ");
    
    printNames(for (p in people) p.name);

Arguments to variadic parameters are packaged into a sequence, so
the comprehension is iterated _eagerly_, before the result is passed 
to the receiving function. Therefore, we don't usually use variadic
parameters for processing streams in Ceylon. That's OK, because we
have an alternative option that is designed precisely with stream
processing in mind.

### Comprehensions in named argument lists

Now let's see what makes comprehensions really useful.

Suppose we had a class `HashMap`, with the following signature:

<!-- try: -->
    class HashMap<Key,Item>({Key->Item*} entries) { ... }

According to the [previous chapter](../named-arguments/#iterable_arguments), 
we can pass multiple values to this parameter using a named argument
list:

<!-- try: -->
    value numbersByName = HashMap { "one"->1, "two"->2, "three"->3 };

If multiple values are acceptable, so is a comprehension:

<!-- try: -->
    value numNames = ["one", "two", "three"];
    value numbersByName = HashMap { for (i->w in numNames.indexed) w->i };

Going back to our previous example, we could construct a `HashMap<String,Person>` 
like this:

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

    print( every { for (p in people) p.age>=18 } );
-->
    if (every { for (p in people) p.age>=18 }) { ... }

The function [`every()`](#{site.urls.apidoc_1_3}/index.html#every) 
in `ceylon.language` accepts a stream of `Boolean` values, and stops 
iterating the stream as soon as it encounters `false`.

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

    printAll { for (p in people) p.name->p };
-->
    for (p in people) p.name->p

results in an `Iterable<String->Person>`. For each element of `people`,
a new `Entry<String,Person>` is constructed by the `->` operator.

## Filtering

The `if` clause of a comprehension allows us to skip certain elements
of the stream. This comprehension produces a stream of numbers which
are divisible by `3`.

<!-- try:
    printAll { for (i in 0..100) if (i%3==0) i };
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

    printAll { for (p in people) if (exists s = p.spouse) p->s };
-->
    for (p in people) if (exists s = p.spouse) p->s

You can even use [multiple `if` conditions](../attributes-control-structures#condition_lists):

<!-- try: -->
    for (p in people) 
        if (exists s = p.spouse, 
            nonempty inlaws = s.parents) 
                    p->inlaws

## Products and joins

A comprehension may have more than one `for` clause. This allows us
to combine two streams to obtain a stream of the values in their 
cartesian product:

<!-- try:
    class Node(Integer x, Integer y) { 
        shared actual String string = "(``x``,``y``)"; 
    }

    printAll { for (i in 0..5) for (j in 0..5) Node(i,j) };
-->
    for (i in 0..100) for (j in 0..10) Node(i,j)

Even more usefully, it lets us obtain a stream of associated values,
a lot like a `join` in SQL.

<!-- try:
    class Employee(name) { shared String name; }
    class Organisation(name, employees) { shared String name; shared Employee* employees; }
    value orgs = { Organisation("RedHat", Employee("Joe"), Employee("Jack")),
                   Organisation("Fedora", Employee("Lisa")) };

    printAll { for (o in orgs) for (e in o.employees) o.name->e.name };
-->
    for (o in orgs) for (e in o.employees) e.name

## Comprehensions beginning in `if`

A comprehension may begin with an `if` clause. For example, this
comprehension:

<!-- try: -->
    [ if (x>=0.0) x^0.5 ]

Produces the singleton `[2.0]` if `x==4.0`, and the empty tuple
`[]` if `x<0.0`. Likewise, the comprehension:

<!-- try: -->
    { if (exists list) for (x in list) x.string }

Produces an empty stream if `list` is `null`.

## There's more...

Next we're going to discuss some of the basic types from the 
[language module](../language-module), in particular numeric types, and 
introduce the idea of operator polymorphism.

You can read more about working with iterable objects in Ceylon in
[this blog post](/blog/2012/07/12/tricks-with-iterable).


