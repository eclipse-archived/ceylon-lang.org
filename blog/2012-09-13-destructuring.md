---
title: Destructuring considered harmful 
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

A language is said to feature _destructuring_ if it provides a syntax 
for quickly declaring multiple local variables and assigning their 
values from the attributes of some complex object. For example, in
Ceylon, we let you write:

    for (k->v in map) { ... }

This is a simple kind of destructuring where the `key` and `item`
attributes of the map `Entry` are assigned to the locals `k` and
`v`.

Let's see a couple more examples of destructuring, written in a 
hypothetical Ceylon-like language, before we get to the main point
of this post.

A number of languages support a kind of parallel assignment syntax
for desctructuring tuples. In our hypothetical language, it might 
look like this:

    String name, Value val = namedValues[i];

Some languages support a kind of destructuring that is so powerful
that it's referred to as _pattern matching_. In our language we might
support pattern matching in `switch` statements, using a syntax
something like this:

    Person|Org identity = getIdentityFromSomewhere();
    switch (identity)
    case (Person(name, age, ...)) {
        print("Person");
        print("Name: " + name);
        print("Age: " + age);
    }
    case (Org(legalName, ...)) {
        print("Organization");
        print("Name: " + legalName);
    }

Now, I've always had a bit of a soft spot for destructuring&mdash;it's
a minor convenience, but there are certainly cases (like iterating
the entries of a map) where I think it improves the code. A future
version of Ceylon _might_ feature a lot more support for destructuring,
but there are several reasons why I'm not especially enthusiastic 
about the idea. I'm going to describe just one of them.

Let's start with the "pattern matching" example above. And let's
stipulate that I&mdash;perhaps more than most developers&mdash;rely
almost completely on my IDE to write my code for me. I use Extract 
Value, Extract Function, Assign To Local, Rename, ⌘1, etc, in Ceylon
IDE like it's a nervous tic. So of course the first thing I want to do 
when I see code like the above is to run
Extract Function on the two branches, resulting in:

    Person|Org identity = getIdentityFromSomewhere();
    switch (identity)
    case (Person(name, age, ...)) {
        printPerson(name, age);
    }
    case (Org(legalName, ...)) {
        printOrg(legalName);
    }
    
    ...
    
    void printPerson(String name, Integer age) {
        print("Person");
        print("Name: " + name);
        print("Age: " + age);
    }
    
    void printOrg(String legalName) {
        print("Organization");
        print("Name: " + legalName);
    }

Ooops. Immediately we have a problem. The schema of `Person` and 
`Org` is smeared out over the signatures of `printPerson()` and
`printOrg()`. This makes the code much more vulnerable to changes
to the schema of `Person` or `Org`, makes the code more vulnerable
to changes to the internal implementation of these methods (if we
want to also print the `Person`'s address, we need to add a
parameter), and it even makes the code less typesafe. The problem
gets worse and worse as I recursively run Extract Value and
Extract Function on the implementation of `printPerson()` and
`printOrg()`.

Now consider what we would get _without_ the use of destructuring,
as we would do in Ceylon _today_. We would have started with:

    Person|Org identity = getIdentityFromSomewhere();
    switch (identity)
    case (is Person) {
        print("Person");
        print("Name: " + identity.name);
        print("Age: " + identity.age);
    }
    case (is Org) {
        print("Organization");
        print("Name: " + identity.legalName);
    }

Whether this is better or worse than the code using of pattern 
matching is somewhat in the eye of the beholder, but clearly it's
not _much_ worse and is arguably even a little cleaner. Now
let's run Extract Function on it. We get:

    Person|Org identity = getIdentityFromSomewhere();
    switch (identity)
    case (is Person) {
        printPerson(identity);
    }
    case (is Org) {
        printOrg(identity);
    }
    
    ...
    
    void printPerson(Person identity) {
        print("Person");
        print("Name: " + identity.name);
        print("Age: " + identity.age);
    }
    
    void printOrg(Organization identity) {
        print("Organization");
        print("Name: " + identity.legalName);
    }

I think it's very clear that this a much better end result. And
I hope it's also clear that this is in no way a contrived example.
The arguments I'm making here scale to most uses of pattern
matching. The problem here is that introducing local variables
too "early" screws things up for refactoring tools.

Essentially the same argument applies to tuples: a tuple seems
like a convenient thing to use when you "just" have a quick helper
function that returns two values. But after a few iterations of
Extract Function/Extract Value, you wind up with five functions
with the tuple type `(String, Value)` smeared out all over the
place, resulting in code that is significantly more brittle 
than it would have been with a `NamedValue` class.

I've repeatedly heard the complain that "oh but sometimes it's
just not worth writing a whole class to represent the return
value of one function". I think this overlooks the effect of
code growing and evolving and being refactored. And it also
presupposes that writing a class is a pain, as it is in Java. 
But in Ceylon writing a class is easy&mdash;indeed, it looks just 
like a function! Instead of this:

    (String, Value) getNamedValue(String name) {
        return (name, findValueForName(name));
    }

we can just write this:

    class NamedValue(name) {
        shared String name;
        shared Value val = findValueForName(name);
    }

No constructor, no getters/setters, and if this is a member of 
another class, you can just annotate it `shared default`, and it's 
even _polymorphic_, meaning that there is not even a need to write 
a factory method. And this solution comes with the huge advantage 
that the schema of a `NamedValue` is localized in just one place, 
and won't start to "smear out" as your codebase grows and evolves.