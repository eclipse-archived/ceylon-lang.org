---
title: Tuple and entry destructuring
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

The next release of Ceylon features an interesting range of
new language features, including constructors, `if` and
`switch` expression, `let` and `object` expressions, and
_destructuring_ of tuples and entries. In this post, I'm
going to describe our new syntax for destructuring.

A destructuring statement looks a lot like a normal value
declaration, except that where we would expect to see the
value name, a _pattern_ occurs instead.

An _entry_ pattern is indicated using the skinny arrow `->`
we use to construct entries:

<!-- try: -->
    String->Integer entry = "one"->1;
    value key->item = entry;    //destructure the Entry

A _tuple pattern_ is indicated with brackets:

<!-- try: -->
    [String,Integer] pair = ["one",1];
    value [first,second] = pair;    //destructure the Tuple

The _pattern variables_, `key`, `item`, `first`, and `second`
are just regular local values.

We can nest tuple and entry patterns:

<!-- try: -->
    String->[String,Integer] entry = "one"->["one",1];
    value key->[first,second] = entry;

A tuple pattern may have a tail variable, indicated with a
`*`:

<!-- try: -->
    [String+] ints = 1..100;
    value [first,*rest] = ints;    //destructure the Sequence

(This syntax resembles the spread operator.)

Patterns may optionally indicate an explicit type:

<!-- try: -->
    value String key->[String first, Integer second] = entry;

Pattern-based destructuring can occur in a number of other
places in the language. A pattern can occur in a `for` loop:

<!-- try: -->
    for ([x, y] in points) { ... }
    
    for (key->item in map) { ... }

Or in an `exists` or `nonempty` condition:

<!-- try: -->
    if (exists index->item = stream.indexed.first) { ... }
    
    if (nonempty [first,*rest] = sequence) { ... }

Or in a `let` expression:

<!-- try: -->
    value dist = let ([x,y] = point) sqrt(x^2+y^2);

You might wonder why we decided to introduce this syntax, or
at least, why we decided to do it _now_. Well, I suppose the
simple answer is that it always felt a bit incomplete or
unfinished to have a language with tuples but no convenient
destructuring syntax for them. Especially when we did already 
have destructuring for entries, but only in `for`, as a 
special case.

But looking into the future, you could also choose to see 
this as us dipping our toes in the water of eventual support
for _pattern matching_. I remain ambivalent about pattern
matching, and it's certainly not something we find that the
language is missing or needs, but lots of folks tell us they
like it in other languages, so we're keeping our options 
open. Fortunately, the syntax described above well scale
nicely to more complex patterns in a full pattern matching
facility.

This functionality is already implemented and available in
github.
