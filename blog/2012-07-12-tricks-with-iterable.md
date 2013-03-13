---
title: Tricks with iterable objects 
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Now that Ceylon has full support for mixin inheritance, we've
been able to fill in all the interesting operations of the
`Iterable` interface defined in `ceylon.language`. You can 
see the [definition of `Iterable` 
here](http://ceylon-lang.org/documentation/1.0/api/ceylon/language/Iterable.ceylon.html).
(But be aware that, like the rest of the language module, the
actual real implementation is in Java and JavaScript. The
Ceylon definition is never actually compiled.)

## Mapping and filtering an `Iterable` object

Of course, `Iterable` has the famous functions `map()`, and
`filter()`. You can call them like this:

<!-- try: -->
    value filtered = "Hello Word".filter((Character c) c.uppercase);
    value mapped = "Hello Word".map((Character c) c.uppercased);

(This works because a `String` is an `Iterable<Character>`.)

These operations each return `Iterable`&#8212;in this case,
`Iterable<Character>`&#8212;so they don't actually allocate
memory (except for a single object instantiation). If you want
to actually get a new `String`, you need to call a function to
do that:

<!-- try: -->
    print(string(filtered...)); //prints "HW"
    print(string(mapped...)); //prints "HELLO WORLD"

As an aside, we think this is the right approach. I understand
that some folks think it's better that calling `filter()` on
a `String` results in a `String`, or that `filter()`ing a `Set`
results in a `Set`, but I think it's quite common that the 
resulting container type should _not_ be the same as the 
original container type. For example, it's unclear that calling 
`map()` on a `Set` should result in a `Set`, and it's certainly 
not correct that `map()`ing a `String` results in another 
`String`, or that `map()`ing a `Map` always results in another
`Map`.)

Now, `map()` and `filter()` have their uses, I suppose, but in
fact they're not the usual way to do mapping and filtering in
Ceylon. We would really write the above code like this:

<!-- try: -->
    print(string(for (c in "Hello Word") if (c.uppercase) c)); //prints "HW"
    print(string(for (c in "Hello Word") c.uppercased)); //prints "HELLO WORLD"

Likewise, `Iterable` has the methods `any()` and `every()`, and
but it's still usually more convenient and idiomatic to use 
comprehensions:

<!-- try: -->
    value allLowercase = every(for (c in "Hello Word") c.lowercase); //false
    value someUppercase = any(for (c in "Hello Word") c.uppercase); //true

## More operations of `Iterable`

However, there are some really useful methods of `Iterable`. 
First, `find()` and `findLast()`:

<!-- try: -->
    value char = "Hello Word".find((Character c) c>`l`); //`o`

We _can_ write this using a comprehension, but to be honest in 
this case it's slightly less ergonomic:

<!-- try: -->
    value char = first(for (c in "Hello World") if (c>`l`) c);

Next, `sorted()`:

<!-- try: -->
    value sorted = "Hello World".sorted(byIncreasing((Character c) c.uppercased)); 
            //" deHllloorW"

Finally, `fold()`:

<!-- try: -->
    value string = "Hello World".fold("", 
            (String s, Character c) 
                s.empty then c.string 
                        else s + c.string + " ");
            //"H e l l o  W o r l d"

    value list = "Hello World".fold({}, 
            (Character[] seq, Character c) 
                c.letter then append(seq,c) 
                         else seq); 
            //{ H, e, l, l, o, W, o, r, l, d }

There's also two very useful attributes declared by `Iterable`.
`coalesced` produces an iterable object containing the non-null
elements:

<!-- try: -->
    value letters = { "Hello World".map((Character c) c.letter 
            then c.uppercased).coalesced... };
            //{ H, E, L, L, O, W, O, R, L, D }

The `indexed` attribute produces an iterable object containing
the elements indexed by their position in the stream:

<!-- try: -->
    value entries = { "Hello World".indexed... }; 
            //{ 0->H, 1->e, 2->l, 3->l, 4->o, 5-> , 6->W, 7->o, 8->r, 9->l, 10->d }

It's quite interesting to see the 
[declaration](http://ceylon-lang.org/documentation/1.0/api/ceylon/language/Iterable.ceylon.html#205,207) 
of these operations. For example:

<!-- try: -->
    shared default Iterable<Element&Object> coalesced {
        return elements(for (e in this) if (exists e) e);
    }

Notice how the use of the intersection type `Element&Object` 
eliminates the need for a type parameter with a lower bound
type constraint, which would be required to write down the
signature of this operation in most other languages. Indeed,
we use the same trick for the operations `union()` and
`intersection()` of `Set`, 
[as you can see here](http://ceylon-lang.org/documentation/1.0/api/ceylon/language/Set.ceylon.html#64,67).

## Set union and intersection

We let you write the union of two `Set`s as `s|t` in Ceylon,
and the intersection of two `Set`s as `s&t`. Now check this 
out:

<!-- try: -->
    Set<String> strings = ... ;
    Set<Integer> ints = ... ;
    value stringsAndInts = strings|ints; //type Set<String|Integer>
    value stringsAndInts = strings&ints; //type Set<Bottom>, since Integer&String is an empty type

That is, the type of the union of a `Set<X>` with a `Set<Y>` is
`Set<X|Y>` and the type of the intersection of a `Set<X>` with 
a `Set<Y>` is `Set<X&Y>`. Cool, huh?

By the way, we just added similar methods `withLeading()` and
`withTrailing()` to `List`:

<!-- try: -->
    value floatsAndInts = { 1, 2, 3.0 }; //type Sequence<Integer|Float>
    value stuff = floatsAndInts.withTrailing("hello", "world"); //type Sequence<Integer|Float|String>

(These operations didn't make it into M3.1.)

## `min()` and `max()`

Well, here's something else that's cool. Ceylon distinguishes 
between empty and nonempty sequences within the type system. 
An empty sequence is of type `Empty`, a `List<Bottom>`. A 
non-empty sequence is a `Sequence<Element>`,a `List<Element>`.
(There's even a convenient `if (nonempty)` construct for 
narrowing a sequence to a nonempty sequence without too much
ceremony.)

This lets us do something pretty cool with the [signature of 
`min()` and `max()`](http://ceylon-lang.org/documentation/1.0/api/ceylon/language/max.ceylon.html#1,21).

<!-- try: -->
    value nothingToMax = max({}); //type Nothing
    value somethingToMax = max({0.0, 1.0, -1.0}); //type Float
    List<Character> chars = "hello";
    value maybeSomethingToMax = max(chars); //type Character?

That is, according to its signature, the `max()` function
returns:

- `null` when passed an empty sequence, 
- a non-`null` value when passed a nonempty sequence, or
- a possibly-null value when passed an iterable object that 
  we don't know is empty or nonempty.

It's important to point out that this is _not_ some special
feature built in as a special case in the type system. Nor
is it in any way related to overloading. Indeed, until a 
couple of weeks ago I didn't even realize that this was 
possible. It's rather a demonstration of how expressive our 
type system is: in this case, the combination of intersection 
types, union types, and principal instantiation inheritance 
of generic types lets us express something within the type 
system that might seem almost magical. The real magic is in 
the declaration of the language module type 
[`ContainerWithFirstElement`](http://ceylon-lang.org/documentation/1.0/api/ceylon/language/ContainerWithFirstElement.ceylon.html).

