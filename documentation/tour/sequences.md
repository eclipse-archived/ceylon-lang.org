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

<!-- lang: ceylon -->
    void printBounds(String[] strings) {
        if (nonempty strings) {
            //strings is a Sequence<String>
            writeLine(strings.first + ".." + strings.last);
        }
        else {
            writeLine("Empty");
        }
    }

Note how this is just a continuation of the pattern established for `null`
value handling.

## Sequence syntax sugar

There's lots more syntactic sugar for sequences. We can use a bunch of 
familiar Java-like syntax:

<!-- lang: ceylon -->
    String[] operators = { "+", "-", "*", "/" };
    String? plus = operators[0];
    String[] multiplicative = operators[2..3];

Oh, and the expression `{}` returns a value of type `Empty`.

However, unlike Java, all these syntactic constructs are pure abbreviations. 
The code above is exactly equivalent to the following de-sugared code:

<!-- lang: ceylon -->
    Empty|Sequence<String> operators = Array("+", "-", "*", "/");
    Nothing|String plus = operators.value(0);
    Empty|Sequence<String> multiplicative = operators.range(2,3);

A `Range` is also a subtype of `Sequence`. The following:

<!-- lang: ceylon -->
    Character[] uppercaseLetters = 'A'..'Z';
    Natural[] countDown = 10..0;

Is just sugar for:

<!-- lang: ceylon -->
    Empty|Sequence<Character> uppercaseLetters = Range('A','Z');
    Empty|Sequence<Natural> countDown = Range(10,0);

In fact, this is just a sneak preview of the fact that almost all operators 
in Ceylon are just sugar for method calls upon a type. We'll come back to this 
later, when we talk about operator polymorphism.


## Iterating sequences

The `Sequence` interface extends `Iterable`, so we can iterate a `Sequence` 
using a `for` loop:

<!-- lang: ceylon -->
    for (String op in operators) {
        writeLine(op);
    }

Ceylon doesn't need C-style `for` loops. Instead, combine `for` with the 
range operator `..`.

<!-- lang: ceylon -->
    variable Natural fac:=1;
    for (Natural n in 1..100) {
        fac*=n;
        writeLine("Factorial " n "! = " fac "");
    }

If, for any reason, we need to use the index of each element of a sequence 
we can use a special variation of the `for` loop that is designed for 
iterating instances of `Entries`:

<!-- lang: ceylon -->
    for (Natural i -> String op in entries(operators)) {
        writeLine($i + ": " + op);
    }

The `entries()` function returns an instance of `Entries<Natural,String>` 
containing the indexed elements of the sequence.

## Sequence and its supertypes

It's probably a good time to see some more advanced Ceylon code. What better 
place to find some than in the language module itself?

Here's how the language module defines the type `Sequence`:

<!-- lang: ceylon -->
    shared interface Sequence<out Element>
            satisfies Correspondence<Natural, Element> &
                      Iterable<Element> & Sized {
         
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
     
        shared actual default Iterator<Element> iterator() {
            class SequenceIterator(Natural from)
                    satisfies Iterator<Element> {
                shared actual Element? head {
                    return value(from);
                }
                shared actual Iterator<Element> tail {
                    return SequenceIterator(from+1);
                }
            }
            return SequenceIterator(0);
        }
    }

The most interesting operations are inherited from `Correspondence`, 
`Iterable` and `Sized`:

<!-- lang: ceylon -->
    shared interface Correspondence<in Key, out Value>
            given Key satisfies Equality {
         
        doc "Return the value defined for the
             given key."
        shared formal Value? value(Key key);
             
    }
    shared interface Iterable<out Element>
            satisfies Container {
         
        doc "An iterator of values belonging
             to the container."
        shared formal Iterator<Element> iterator();
         
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

## Empty sequences and the Bottom type

Now let's see the definition of Empty:

<!-- lang: ceylon -->
    object emptyIterator satisfies Iterator<Bottom> {
         
        shared actual Nothing head {
            return null;
        }
        shared actual Iterator<Bottom> tail {
            return this;
        }
         
    }
     
    shared interface Empty
               satisfies Correspondence<Natural, Bottom> &
                         Iterable<Bottom> & Sized {
         
        shared actual Natural size {
            return 0;
        }
        shared actual Boolean empty {
            return true;
        }
        shared actual Iterator<Bottom> iterator() {
            return emptyIterator;
        }
        shared actual Nothing value(Natural key) {
            return null;
        }
        shared actual Nothing first {
            return null;
        }
         
    }

The special type `Bottom` represents:

* the empty set, or equivalently
* the intersection of all types.

Since the empty set is a subset of all other sets, `Bottom` is assignable to 
all other types. Why is this useful here? Well, 
`Correspondence<Natural,Element>` and `Iterable<Element>` are both covariant 
in the type parameter `Element`. So `Empty` is assignable to 
`Correspondence<Natural,T>` and `Iterable<T>` for any type `T`. That's why 
`Empty` doesn't need a type parameter. The following code is well-typed:

<!-- lang: ceylon -->
    void printAll(String[] strings) {
        variable Iterator<String> i := strings.iterator();
        while (exists String s = i.head) {
            writeLine(s);
            i := i.tail;
        }
    }

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

<!-- lang: ceylon -->
    String[] operators = .... ;
    operators[0] := "**"; //compile error

Furthermore, the index operation `operators[i]` returns an optional type 
`String?`, which results in quite different code idioms. To begin with, 
we don't iterate sequences by index like in C or Java. The following code 
does not compile:

<!-- lang: ceylon -->
    for (Natural i in 0..operators.size-1) {
        String op = operators[i]; //compile error
        ...
    }

Here, `operators[i]` is a `String?`, which is not directly assignable to 
`String`.

Instead, if we need access to the index, we use the special form of for shown 
above.

<!-- lang: ceylon -->
    for (Natural i -> String op in entries(operators)) {
        ...
    }

Likewise, we don't usually do an upfront check of an index against the sequence length:

<!-- lang: ceylon -->
    if (i>operators.size-1) {
        throw IndexOutOfBoundException();
    }
    else {
        return operators[i]; //compile error
    }

Instead, we do the check *after* accessing the sequence element:

<!-- lang: ceylon -->
    if (exists String op = operators[i]) {
        return op;
    }
    else {
        throw IndexOutOfBoundException();
    }

We especially don't ever need to write the following:

<!-- lang: ceylon -->
    if (i>operators.size-1) {
        return "";
    }
    else {
        return operators[i]; //compile error
    }

This is much cleaner:

<!-- lang: ceylon -->
    return operators[i] ? "";

All this may take a little getting used to. But what's nice is that all the 
exact same idioms also apply to other kinds of `Correspondence`, including 
`Entries` and `Maps`.


## There's more...

Next we'll talk about [types](../types), specifically union types and
algebraic data types, type switching, and type inference. 

