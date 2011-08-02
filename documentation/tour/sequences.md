---
layout: tour
title: Tour of Ceylon&#58; Sequences
tab: documentation
author: Gavin King
---

# #{page.title}

## Sequences

Some kind of array or list construct is a universal feature of all programming 
languages. The Ceylon language module defines support for sequence types. 
A sequence type is usually written `X[]` for some element type `X`. But this 
is really just an abbreviation for the union type `Empty|Sequence<X>`.

The interface `Sequence` represents a sequence with at least one element. The 
type `Empty` represents an empty sequence with no elements. Some operations 
of the type `Sequence` aren't defined by `Empty`, so you can't call them if 
all you have is `X[]`. Therefore, we need the `if (nonempty ... )` construct 
to gain access to these operations.

<pre class="brush: ceylon">
    void printBounds(String[] strings) {
        if (nonempty strings) {
            //strings is a Sequence&lt;String>
            writeLine(strings.first + ".." + strings.last);
        }
        else {
            writeLine("Empty");
        }
    }
</pre>

Note how this is just a continuation of the pattern established for `null`
value handling.

## Sequence syntax sugar

There's lots more syntactic sugar for sequences. We can use a bunch of 
familiar Java-like syntax:

<pre class="brush: ceylon">
    String[] operators = { "+", "-", "*", "/" };
    String? plus = operators[0];
    String[] multiplicative = operators[2..3];
</pre>

Oh, and the expression `{}` returns a value of type `Empty`.

However, unlike Java, all these syntactic constructs are pure abbreviations. 
The code above is exactly equivalent to the following de-sugared code:

<pre class="brush: ceylon">
    Empty|Sequence&lt;String> operators = Array("+", "-", "*", "/");
    Nothing|String plus = operators.value(0);
    Empty|Sequence&lt;String> multiplicative = operators.range(2,3);
</pre>

A `Range` is also a subtype of `Sequence`. The following:

<pre class="brush: ceylon">
    Character[] uppercaseLetters = 'A'..'Z';
    Natural[] countDown = 10..0;
</pre>

Is just sugar for:

<pre class="brush: ceylon">
    Empty|Sequence&lt;Character> uppercaseLetters = Range('A','Z');
    Empty|Sequence&lt;Natural> countDown = Range(10,0);
</pre>

In fact, this is just a sneak preview of the fact that almost all operators 
in Ceylon are just sugar for method calls upon a type. We'll come back to this 
later, when we talk about operator polymorphism.


## Iterating sequences

The `Sequence` interface extends `Iterable`, so we can iterate a `Sequence` 
using a `for` loop:

<pre class="brush: ceylon">
    for (String op in operators) {
        writeLine(op);
    }
</pre>

Ceylon doesn't need C-style `for` loops. Instead, combine `for` with the 
range operator `..`.

<pre class="brush: ceylon">
    variable Natural fac:=1;
    for (Natural n in 1..100) {
        fac*=n;
        writeLine("Factorial " n "! = " fac "");
    }
</pre>

If, for any reason, we need to use the index of each element of a sequence 
we can use a special variation of the `for` loop that is designed for 
iterating instances of `Entries`:

<pre class="brush: ceylon">
    for (Natural i -> String op in entries(operators)) {
        writeLine($i + ": " + op);
    }
</pre>

The `entries()` function returns an instance of `Entries<Natural,String>` 
containing the indexed elements of the sequence.

## Sequence and its supertypes

It's probably a good time to see some more advanced Ceylon code. What better 
place to find some than in the language module itself?

Here's how the language module defines the type `Sequence`:

<pre class="brush: ceylon">
    shared interface Sequence&lt;out Element>
            satisfies Correspondence&lt;Natural, Element> &
                      Iterable&lt;Element> & Sized {
         
        doc "The index of the last element of the sequence."
        shared formal Natural lastIndex;
         
        doc "The first element of the sequence."
        shared actual formal Element first;
         
        doc "The rest of the sequence, without the first
             element."
        shared formal Element[] rest;
     
        shared actual Boolean empty {
            return false;
        }
             
        shared actual default Natural size {
            return lastIndex+1;
        }
         
        doc "The last element of the sequence."
        shared default Element last {
            if (exists Element x = value(lastIndex)) {
                return x;
            }
            else {
                //actually never occurs if
                //the subtype is well-behaved
                return first;
            }
        }
     
        shared actual default Iterator&lt;Element> iterator() {
            class SequenceIterator(Natural from)
                    satisfies Iterator&lt;Element> {
                shared actual Element? head {
                    return value(from);
                }
                shared actual Iterator&lt;Element> tail {
                    return SequenceIterator(from+1);
                }
            }
            return SequenceIterator(0);
        }
    }
</pre>

The most interesting operations are inherited from `Correspondence`, 
`Iterable` and `Sized`:

<pre class="brush: ceylon">
    shared interface Correspondence&lt;in Key, out Value>
            given Key satisfies Equality {
         
        doc "Return the value defined for the
             given key."
        shared formal Value? value(Key key);
             
    }
    shared interface Iterable&lt;out Element>
            satisfies Container {
         
        doc "An iterator of values belonging
             to the container."
        shared formal Iterator&lt;Element> iterator();
         
        shared actual default Boolean empty {
            return !(first exists);
        }
         
        doc "The first object."
        shared default Element? first {
            return iterator().head;
        }
     
    }
    shared interface Sized
            satisfies Container {
             
        doc "The number of values or entries
             belonging to the container."
        shared formal Natural size;
         
        shared actual default Boolean empty {
            return size==0;
        }
         
    }
    shared interface Container {
             
        shared formal Boolean empty;
         
    }
</pre>

## Empty sequences and the Bottom type

Now let's see the definition of Empty:

<pre class="brush: ceylon">
    object emptyIterator satisfies Iterator&lt;Bottom> {
         
        shared actual Nothing head {
            return null;
        }
        shared actual Iterator&lt;Bottom> tail {
            return this;
        }
         
    }
     
    shared interface Empty
               satisfies Correspondence&lt;Natural, Bottom> &
                         Iterable&lt;Bottom> & Sized {
         
        shared actual Natural size {
            return 0;
        }
        shared actual Boolean empty {
            return true;
        }
        shared actual Iterator&lt;Bottom> iterator() {
            return emptyIterator;
        }
        shared actual Nothing value(Natural key) {
            return null;
        }
        shared actual Nothing first {
            return null;
        }
         
    }
</pre>

The special type `Bottom` represents:

* the empty set, or equivalently
* the intersection of all types.

Since the empty set is a subset of all other sets, `Bottom` is assignable to 
all other types. Why is this useful here? Well, 
`Correspondence<Natural,Element>` and `Iterable<Element>` are both covariant 
in the type parameter `Element`. So `Empty` is assignable to 
`Correspondence<Natural,T>` and `Iterable<T>` for any type `T`. That's why 
`Empty` doesn't need a type parameter. The following code is well-typed:

<pre class="brush: ceylon">
    void printAll(String[] strings) {
        variable Iterator&lt;String> i := strings.iterator();
        while (exists String s = i.head) {
            writeLine(s);
            i := i.tail;
        }
    }
</pre>

Since both `Empty` and `Sequence<String>` are subtypes of `Iterable<String>`, 
the union type `String[]` is also a subtype of `Iterable<String>`.

Another cool thing to notice here is the return type of the `first` and 
`value()` operations of `Empty`. You might have been expecting to see `Bottom?` 
here, since they override supertype members of type `T?`. But as we saw in 
Part 1, `Bottom?` is just an abbreviation for `Nothing|Bottom`. And `Bottom` is 
the empty set, so the union `Bottom|T` of `Bottom` with any other type `T` 
is just `T` itself.

The Ceylon compiler is able to do all this reasoning automatically. So when 
it sees an `Iterable<Bottom>`, it knows that the operation first is of type 
`Nothing`, i.e. it is the value `null`.

Cool, huh?

## Sequence gotchas for Java developers

Superficially, a sequence type looks a lot like a Java array, but really it's 
very, very different! First, of course, a sequence type 
`Sequence<String>` is an immutable interface, it's not a mutable concrete 
type like an array. We can't set the value of an element:

<pre class="brush: ceylon">
String[] operators = .... ;
operators[0] := "**"; //compile error
</pre>

Furthermore, the index operation `operators[i]` returns an optional type 
`String?`, which results in quite different code idioms. To begin with, 
we don't iterate sequences by index like in C or Java. The following code 
does not compile:

<pre class="brush: ceylon">
    for (Natural i in 0..operators.size-1) {
        String op = operators[i]; //compile error
        ...
    }
</pre>

Here, `operators[i]` is a `String?`, which is not directly assignable to 
`String`.

Instead, if we need access to the index, we use the special form of for shown 
above.

<pre class="brush: ceylon">
    for (Natural i -> String op in entries(operators)) {
        ...
    }
</pre>

Likewise, we don't usually do an upfront check of an index against the sequence length:

<pre class="brush: ceylon">
    if (i>operators.size-1) {
        throw IndexOutOfBoundException();
    }
    else {
        return operators[i]; //compile error
    }
</pre>

Instead, we do the check *after* accessing the sequence element:

<pre class="brush: ceylon">
    if (exists String op = operators[i]) {
        return op;
    }
    else {
        throw IndexOutOfBoundException();
    }
</pre>

We especially don't ever need to write the following:

<pre class="brush: ceylon">
    if (i>operators.size-1) {
        return "";
    }
    else {
        return operators[i]; //compile error
    }
</pre>

This is much cleaner:

<pre class="brush: ceylon">
    return operators[i] ? "";
</pre>

All this may take a little getting used to. But what's nice is that all the 
exact same idioms also apply to other kinds of `Correspondence`, including 
`Entries` and `Maps`.


## There's more...

Next we'll talk about [types](../types), specifically union types and
algebraic data types, type switching, and type inference. 

