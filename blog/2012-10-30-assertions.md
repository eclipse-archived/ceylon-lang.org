---
title: Assertions in Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

A distinguishing characteristic of Ceylon is that exceptions aren't used 
to represent programming errors. Well, that statement is a little vague 
or even over-broad, so let me make it more concrete with several 
examples of exceptions that I think always indicate a programming error 
in Java:

- `NullPointerException`
- `ClassCastException`
- `IndexOutOfBoundsException`

The big problem with these exceptions is that they undermine the static
type system.

Sure, all exceptions work around the type system—that's basically
what we have exceptions _for_. And when you're talking about exceptions 
that represent transient conditions that can legitimately occur in a 
production system, and you're using the exception to transmit information 
from one part of the system (that can fail) to a completely different 
part of the system (that knows what to do in the case of failure) without 
forcing awareness of the failure onto every bit of intermediate code that 
occurs between these two bits of the system, then I think that's very 
reasonable.

But that's not the role of the exceptions above. These exceptions:

- should _never_ occur at runtime in a production system
- represent problems that must be fixed by the programmer editing code
- tend to hide the "corner" condition they represent from someone reading 
  the code
- are much too low-level to carry any useful information about the
  real problem

Instead, Ceylon tries to encode these "corner" conditions into the type
system. The compiler won't let you write:

    print(process.arguments[1].uppercased);

This code isn't well-typed because `process.arguments[1]` is of type
`String?`, reflecting the fact that there might not be a second element
in the list `process.arguments`.

Instead you're forced to at least take into account the possibility that
there are less than two arguments:

    if (exists arg = process.arguments[1]) {
        print(arg.uppercased);
    }
    else {
        throw Exception("missing second argument");
    }

I know some of you reading this are itching to condemn Ceylon for making
you write three lines of code instead of one. But, as I find myself
repeating over and over, we spend _much_ more time reading other people's
code than we spend writing our own code, and the second code example 
makes it much clearer to the reader that there is another case that 
needs to be taken into account. Furthermore the exception carries much 
more information about what went wrong than an `IndexOutOfBoundsException`
would.

But _what if_, ask my doubters, I already _know_ that there is more than
one argument? What if my code looks like this:

    if (process.arguments.size>=3) {
        if (exists arg = process.arguments[1]) {
            print(arg.uppercased);
        }
        else {
            throw Exception("missing second argument");
        }
    }

In this case, it's clear that the exception can _never_ occur. I'm
forced to write code that simply _never_ executes at runtime, under any 
scenario!

Well, that's a great point, and it's exactly why we've introduced the
`assert` statement in M4. An assertion failure, unlike an exception,
always represents a programming error—in production code, an 
assertion should never fail. 

Now, sure, assertion failures _are_ represented by a kind of exception, 
but unlike `NullPointerException` or `IndexOutOfBoundsException`, this
exception is _much_ more likely to carry useful information about the 
cause of the failure. And the assertion helps document the assumptions 
made by the code, for the benefit of people coming along and reading it 
later. 

We can rewrite the example above like this:

    if (process.arguments.size>=3) {
        assert(exists arg = process.arguments[1]);
        print(arg.uppercased);
    }

Or even like this:

    value arg = process.arguments[1];
    if (process.arguments.size>=3) {
        assert(exists arg);
        print(arg.uppercased);
    }

You can `assert` an `exists`, `nonempty`, `is`, or boolean condition,
all the same options you have with `if` or `while`.

    Object person = ... ;
    assert (is Person person);
    print(person.name);

Note that this is a _lot_ like a traditional Java-style typecast, but 
the syntax reflects a much more disciplined approach to the problem.

You're encouraged to add some extra information to document the
assertion:

    value arg = process.arguments[1];
    if (process.arguments.size>=3) {
        doc "second argument must be provided"
        assert(exists arg);
        print(arg.uppercased);
    }

The documentation appears in the assertion failure message.

This documentation becomes especially useful if start using Extract 
Function to refactor this code:

    
    void printSecondArg(String? arg) {
        doc "second argument must be provided"
        assert(exists arg);
        print(arg);
    }
    
    value arg = process.arguments[1];
    if (process.arguments.size>=3) {
        printSecondArg(arg);
    }

In future, the Ceylon documentation tool will automatically include 
assertions like this about method parameter values in a list of method 
preconditions.

A single `assert` statement may assert multiple conditions, for 
example:

    value first = process.arguments[0];
    value second = process.arguments[1];
    if (process.arguments.size>=3) {
        assert(exists first, exists second);
        print(first + ", " + second);
    }

For the record, by popular demand, Ceylon M4 even lets us include multiple 
conditions in an `if` or `while` statement:

    if (exists first = process.arguments[0],
        exists second = process.arguments[1]) {
        print(first + ", " + second);
    }
