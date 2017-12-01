---
title: Reification, finally
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [progress]
---

Thanks to a bunch of hard work by Stef, Ceylon finally has fully 
reified types, that is, reified generic type arguments. You can
now write stuff like this very contrived example:

<!-- try: -->
    "Check if the given value is an instance 
     of the given type."
    Boolean check<T>(Anything o) => o is T;
    
    "A string is a list of characters."
    assert (check<List<Character>>("hello"));
    
    "A string is a list of objects."
    assert (check<List<Object>>("hello"));
    
    "A string isn't a list of integers nor a 
     list of floats."
    assert (!check<List<Integer>|List<Float>>("hello"));

This long-promised feature, promised 
[almost two years ago](http://in.relation.to/Bloggers/Ceylon),
will be available in the upcoming M5 release of the language.
The truth is that it's going to take a fair bit more work to
do all the optimizations we plan in order to wring acceptable
performance out of this stuff, but we've got a couple of clever
ideas in this area, that I'm going to keep under wraps for now. ;-)

So why is reified generics important? Well, I took a brief stab
at answering that question [way back when](http://relation.to/Bloggers/ThreeArgumentsForReifiedGenerics),
but since then we've spotted a couple of other compelling reasons.
So lets take a quick look at one practical problem that is 
_extremely_ difficult to solve without reified generics. 

Ceylon's language module has an interface called `Category`

<!-- try: -->
    shared interface Category {
        shared formal Boolean contains(Object element);
        ...
    }

A `Category` is an object that can "contain" other objects. Given
an object, we can ask if it belongs to the category by calling
`contains()`, or using the `in` operator.

Of course, collections are `Category`s:

<!-- try: -->
    shared interface Collection<out Element>
        satisfies {Element*} &
                  Category & 
                  ...

Now, notice that the signature of `contains()` for a
`Collection<String>` is `contains(Object element)`, _not_
`contains(Element element)`. The reason for that is that we
want collections to be _covariant_ in their element type.
I should be able to write the following:

<!-- try: -->
    Collection<String> strings = [ "hello", "world" ];
    Collection<Object> objects = strings;
    print(1 in objects);

Notice that on the last line, an `Integer` gets passed to the
`contains()` method of a `Collection<String>`.

So the, without making use of reified generics, the default 
implementation of `contains()` defined by `Collection` would 
be as follows:

<!-- try: -->
    shared actual default Boolean contains(Object element) {
        for (elem in this) {
            if (exists elem, elem==element) {
                return true;
            }
        }
        else {
            return false;
        }
    }

That's already kinda lame. If I have a `Collection<String>`, 
and `contains()` gets passed an `Integer`, we should be able
to immediately return `false` like this:

<!-- try: -->
    shared actual default Boolean contains(Object element) {
        if (is Element element) {
            for (elem in this) {
                if (exists elem, elem==element) {
                    return true;
                }
            }
        }
        return false;
    }

But, well, whatever, that's merely a minor performance 
optimization, I suppose. But now consider the case of a 
`Range`. A `Range` is a kind of `Collection` whose elements 
are determined by two endpoints, which could potentially have 
_thousands_ or _millions_ or even more values in between! The 
above default implementation of `contains()`, inherited from 
`Collection`, would be so hideously expensive as to be actually 
_wrong_. So `Range` should refine the implementation of 
`contains()` as follows:

<!-- try: -->
    shared actual Boolean contains(Object element) {
        if (is Element element) {
            return includes(element);
        }
        else {
            return false;
        }
    }
    
    shared Boolean includes(Element element) =>
            decreasing then element<=first && element>=last
                    else element>=first && element<=last;

The `is Element element` test requires reified generics. 
Without it, I can't be sure that the given value is a 
`Comparable<Element>`, so I can't compare the given value to 
the endpoints of the `Range`.

What I've shown here, for those interested in type systems, is
that in a type system with declaration-site covariance, there
are _perfectly legitimate_ reasons to want to be able to test
the runtime type of a value. Sure, ML and Haskell don't need
to do this kind of thing, but those languages don't feature
subtyping, and therefore don't have covariance. Object oriented
languages are _very different_, so please take that into account 
before arguing that reified generics are unnecessary.
 
UPDATE:
For more information about the implementation, see Stef's
email here:

<https://groups.google.com/forum/?hl=en&fromgroups=#!topic/ceylon-dev/mIrroqhcf7o>

UPDATE 2:
It was very remiss of me to not mention that we've had support
for reified generics in the JavaScript backend for a while now.
Thanks, Enrique!
