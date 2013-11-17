---
title: Intersections and variance
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [generics]
---

_Warning: the following post is for people who enjoy
thinking about types, and want to understand how the
Ceylon compiler reasons about them. This post is partly 
an attempt to demystify 
[§3.7 of the spec](http://ceylon-lang.org/documentation/1.0/spec/html/typesystem.html#principalinstantiations). 
To understand the following, you first need to understand 
how [variance](/documentation/1.0/tour/generics/#covariance_and_contravariance) 
works in Ceylon._

### Snap quiz!

Consider:

<!-- try: -->
    MutableList<Topic> & MutableList<Queue> list;

1. What is the type of `list.first`?
2. What is the type of the parameter of `list.add()`?

### Background

One of the key goals of Ceylon's type system is to make
subtyping and generics play nicely together. Almost 
every object-oriented language since C++ and Eiffel has 
tried this, and more recent languages have been getting 
gradually closer to a really convincing solution, without,
in my opinion, completely _nailing_ it. Ceylon's 
contribution, of course, is to introduce first-class union 
and intersection types to the mix. In this post we'll see
one of the ways in which they help.

### Four useful identities

To begin to fully understand how the Ceylon typechecker 
reasons about generic types, you need to grasp the central 
importance of the following identities:

1. Given a covariant type `List<Element>`, the 
   union `List<String>|List<Integer>` is a subtype of
   `List<String|Integer>`.
2. Given a contravariant type `ListMutator<Element>`, 
   the union `ListMutator<Queue>|ListMutator<Topic>` 
   is a subtype of `ListMutator<Queue&Topic>`.
3. Given a covariant type `List<Element>`, the 
   intersection `List<Queue>&List<Topic>` is a subtype 
   of `List<Queue&Topic>`.
4. Given a contravariant type `ListMutator<Element>`, 
   the intersection `ListMutator<String>&ListMutator<Integer>` 
   is a subtype of `ListMutator<String|Integer>`.

Note that in each identity, we take a union or 
intersection of two _instantiations_ of the same generic 
type, and produce an instantiation of the generic type 
that is a supertype of the union or intersection.

These identities are actually quite intuitive. No? OK
then, let's consider them one at a time, and convince 
ourselves that they make sense:

1. If we have a list that, when iterated, either produces 
   `String`s or produces `Integer`s then clearly every 
   object it produces is either a `String` or an `Integer`.
2. If we have a list in which we can either insert
   `Queue`s or insert `Topic`s, then we clearly have a list 
   in which we can insert something that is both a  `Queue`
   and a `Topic`.
3. If we have a list that, when iterated produces only
   `Queue`s, and, when iterated, produces only `Topic`s,
   then clearly every object it produces must be both a 
   `Queue` and a `Topic`.
4. If we have a list in which we can both insert a
   `String` and insert an `Integer`, then we clearly
   have a list in which we can insert something that we 
   know is either a `String` or an `Integer`.

Satisfied? Good.

### Generic supertypes and principal instantiations

So, how are these identities useful? Well, imagine that
we have a type `T` whose supertypes include multiple 
distinct instantiations of a generic type. For example, 
imagine that `T` has the supertypes `List<String>` and 
`List<Integer>`. And suppose we want to determine the 
type of one of the members inherited by `T` from the 
generic type, say 
[`List.first`](http://modules.ceylon-lang.org/repo/1/ceylon/language/1.0.0/module-doc/List.type.html#first). 

Then we would first need to form a _principal 
instantiation_ of the generic type `List`. In this case 
the principal instantiation would be 
`List<String|Integer>`, according to identity 1. It's a 
"principal" instantiation because every other 
instantiation of `List` that is a supertype of `T` is 
also a supertype of `List<String|Integer>`. That it is 
even possible to form a principal instantiation like this 
is one of the things that makes Ceylon's type system 
special. Now we can determine the type of `first` by 
substituting `String|Integer` for the type parameter of
`List`. For the record, the result is the type 
`String|Integer|Null`. 

A type like `T` arises when we explicitly write down an 
intersection like `List<Queue>&List<Topic>`, or a union 
like `List<String>|List<Integer>`, but it also arises 
through the use of inheritance.

### Principal instantiation inheritance

In Java, a type can only inherit a single instantiation
of a supertype. A class can't inherit (either directly 
or indirectly) both `List<Queue>` _and_ `List<Topic>` 
in Java. We call this inheritance model _single 
instantiation inheritance_. Ceylon features a more 
flexible model called _principal instantiation 
inheritance_<sup>1</sup>, where this restriction does not 
apply. I'm allowed to write:

<!-- try: -->
    interface Queues satisfies List<Queue> { ... }
    interface Topics satisfies List<Topic> { ... }
    
    class Endpoints() satisfies Queues & Topics { ... }

In which case, `Endpoints` is a subtype of 
`List<Queue>&List<Topic>`. Then the typechecker uses
identity 3 above to _automatically_ infer that
`Endpoints` is a `List<Queue&Topic>`. Other languages
can't do this.

### Problem: invariant types

Now notice something about the identities above: they
don't say anything about _invariant_ types. Unfortunately, 
I simply can't form a principal instantiation of 
`MutableList` that is a supertype of 
`MutableList<Queue>&MutableList<Topic>`. Or at least I 
can't within Ceylon's type system as it exists today.

_Caveat: I'm not a fan of use-site variance. I've been
too burned by it in Java. However, if we do ever decide 
to introduce use-site variance in Ceylon, which does 
remain a real possibility, what I've just said will no 
longer apply, since this instantiation:_

<!-- try: -->
    MutableList<in Queue&Topic out Queue|Topic> 

_would be a principal supertype for 
`MutableList<Queue>&MutableList<Topic>`. But who the
hell wants to have to deal with nasty-looking types
like that?_

### Conclusion

The significance of this is that we should, where 
reasonable, be careful with how we use invariant types 
in Ceylon. To be sure, we still need invariant types, 
especially for concrete implementations like the class 
`Endpoints` above, but we should try to declare public 
APIs on covariant and contravariant types.

Consider the case of `MutableList`. What I'm saying is
that its interesting operations should all be inherited
from the covariant `List` and the contravariant 
`ListMutator`. It doesn't matter much whether we declare 
`MutableList` as a mixin interface like this:

<!-- try: -->
    shared interface MutableList<Element> 
            satisfies List<Element> & 
                      ListMutator<Element> { ... }

Or just as a type alias, like this:

<!-- try: -->
    shared alias MutableList<Element> 
            => List<Element> & ListMutator<Element>;

In either case, the following code<sup>2</sup> is accepted
by the typechecker, assuming the interesting operations 
`first` and `add()` are defined on `List` and `ListMutator`
respectively:

<!-- try: -->
    void doSomeStuff(MutableList<Topic>|MutableList<Queue> list) {
        Topic|Queue|Null topicOrQueue = list.first;
        if (!topicOrQueue exists) {
            Topic&Queue topicAndQueue = .... ;
            list.add(topicAndQueue);
        }
        ...
    }

Here we're calling both "producer" and "consumer" operations 
of the invariant type `MutableList` on an intersection of 
distinct instantiations of `MutableList`. The typechecker 
determined that the principal instantiation of the covariant 
supertype is `List<Topic|Queue>` and that the principal 
instantiation of the contravariant supertype is 
`ListMutator<Topic&Queue>`, and that therefore the code is 
sound.

<sup>1</sup>The notion of principal instantiation inheritance 
is mainly based on Ross Tate's research.

<sup>2</sup>Thanks for Riener Zwitzerloot for this example and
for inspiring this post.

