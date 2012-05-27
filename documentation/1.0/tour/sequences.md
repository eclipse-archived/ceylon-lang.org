---
layout: tour
title: Tour of Ceylon&#58; Sequences
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the fifth leg of the Tour of Ceylon. In the 
[previous leg](../introduction) we covered introduction and member classes. 
Now we're going to look at *sequences*.


## Sequences

Some kind of array or list construct is a universal feature of all programming 
languages. The Ceylon language module defines support for *sequence types*. 
A sequence type is usually written `X[]` for some element type `X`. But this 
is really just an abbreviation for the union type `Empty|Sequence<X>`.

The interface 
[`Sequence`](#{site.urls.apidoc_current}/ceylon/language/interface_Sequence.html) 
represents a sequence *with at least one element*. The 
type 
[`Empty`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html) 
represents an empty sequence with no elements. Some operations 
of the type `Sequence` aren't defined by `Empty`, so you can't call them if 
all you have is `X[]`. Therefore, we need the `if (nonempty ... )` construct 
to gain access to these operations.

    void printBounds(String[] strings) {
        if (nonempty strings) {
            //strings is a Sequence<String>
            print(strings.first + ".." + strings.last);
        }
        else {
            print("Empty");
        }
    }

Note how this is just a continuation of the [pattern established](../basics#dealing_with_objects_that_arent_there) for `null` value handling.


## Sequence syntax sugar

There's lots more syntactic sugar for sequences. We can use a bunch of 
familiar Java-like syntax:

    String[] operators = { "+", "-", "*", "/" };
    String? plus = operators[0];
    String[] multiplicative = operators[2..3];

Oh, and the expression `{}` returns a value of type `Empty`.

However, unlike Java, all these syntactic constructs are pure abbreviations. 
The code above is exactly equivalent to the following de-sugared code:

<!-- check:none:pedagogial -->
    Empty|Sequence<String> operators = ArraySequence("+", "-", "*", "/");
    Nothing|String plus = operators.item(0);
    Empty|Sequence<String> multiplicative = operators.range(2,3);

Though really `ArraySequence` is a hidden type in the Ceylon runtime library.

A [`Range`](#{site.urls.apidoc_current}/ceylon/language/class_Range.html) 
is also a subtype of `Sequence`. The following:

    Character[] uppercaseLetters = `A`..`Z`;
    Integer[] countDown = 10..0;

Is just sugar for:

    Empty|Sequence<Character> uppercaseLetters = Range(`A`,`Z`);
    Empty|Sequence<Integer> countDown = Range(10,0);

In fact, this is just a sneak preview of the fact that almost all operators 
in Ceylon are just sugar for method calls upon a type. We'll come back to this 
later, when we talk about [operator polymorphism](../language-module#operator_polymorphism).


## Iterating sequences

The `Sequence` interface extends 
[`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html), 
so we can iterate a `Sequence` using a `for` loop:

<!-- cat: void m(String[] operators) { -->
    for (op in operators) {
        print(op);
    }
<!-- cat: } -->

Ceylon doesn't need C-style `for` loops. Instead, combine `for` with the 
range operator `..`.

<!-- cat: void m() { -->
    variable Integer fac:=1;
    for (n in 1..100) {
        fac*=n;
        print("Factorial " n "! = " fac "");
    }
<!-- cat: } -->

If, for any reason, we need to use the index of each element of a sequence 
we can use a special variation of the `for` loop that is designed for 
iterating instances of 
[`Entries`](#{site.urls.apidoc_current}/ceylon/language/class_Entry.html):

<!-- cat: void m(String operators) { -->
    for (i -> op in entries(operators)) {
        print(i.string + ": " + op);
    }
<!-- cat: } -->

The 
[`entries()`](#{site.urls.apidoc_current}/ceylon/language/#entries) 
function returns an instance of `Entries<Integer,String>` 
containing the indexed elements of the sequence. The `->` is syntax sugar 
for `Entry`.

It's often useful to be able to iterate two sequences at once. The 
[`zip()`](#{site.urls.apidoc_current}/ceylon/language/#zip) 
function comes in handy here:

<!-- cat: void m(String[] names, String[] places) { -->
    for (name -> place in zip(names,places)) {
        print(name + " @ " + place);
    }
<!-- cat: } -->

## Sequence and its supertypes

It's probably a good time to see some more advanced Ceylon code. What better 
place to find some than in the language module itself?

Here's how the language module defines the type `Sequence`:

<!-- check:none:decl from ceylon.language -->
    shared interface Sequence<out Element> 
            satisfies List<Element> & Some<Element> &
                      Cloneable<Sequence<Element>> &
                      Ranged<Integer, Element[]> {
        
        doc "The index of the last element of the sequence."
        see (size)
        shared actual formal Integer lastIndex;
        
        doc "The first element of the sequence, that is, the
             element with index `0`."
        shared actual formal Element first;
        
        doc "The last element of the sequence, that is, the
             element with index `sequence.lastIndex`."
        shared default Element last {
            if (is Element last = this[lastIndex]) {
                return last;
            }
            else {
                throw; //never occurs for well-behaved implementations
            } 
        }
        
        doc "The rest of the sequence, without the first 
             element."
        shared actual formal Element[] rest;
            
        /*shared formal Sequence<Value> append<Value>(Value... elements)
                given Value abstracts Element;
        
        shared formal Sequence<Value> prepend<Value>(Value... elements)
                given Value abstracts Element;*/
        
    }

The most interesting operations are inherited from 
[`Correspondence`](#{site.urls.apidoc_current}/ceylon/language/interface_Correspondence.html), 
[`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html)  and 
[`Sized`](#{site.urls.apidoc_current}/ceylon/language/interface_Sized.html):

<!-- check:none:decl from ceylon.language -->
    shared interface Correspondence<in Key, out Item>
            given Key satisfies Object {
         
        doc "Return the value defined for the
             given key."
        shared formal Item? item(Key key);
             
    }

    shared interface Iterable<out Element>
            satisfies Container {
         
        doc "An iterator of values belonging
             to the container."
        shared formal Iterator<Element> iterator();
         
        doc "Determines if the iterable object is empty, that is
             to say, if `iterable.iterator` is `null`."
        shared actual default Boolean empty {
            return is Finished iterator.next();
        }
     
    }
    
    shared interface Sized
            satisfies Container {
             
        doc "The number of values or entries
             belonging to the container."
        shared formal Integer size;
         
        shared actual default Boolean empty {
            return size==0;
        }
         
    }
    
    shared interface Container {
             
        doc "Determine if the container is empty, that is, if
             it has no elements."
        shared formal Boolean empty;
         
    }

## Empty sequences and the Bottom type

Now let's see the definition of 
[`Empty`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html):

<!-- check:none:decl from ceylon.language -->
    object emptyIterator satisfies Iterator<Bottom> {
        shared actual Finished next() {
            return exhausted;
        }
    }
     
    shared interface Empty
               satisfies List<Bottom> & None<Bottom> &
                         Ranged<Integer,Empty> &
                         Cloneable<Empty> {
        
        shared actual Integer size { return 0; }
        
        shared actual Iterator<Bottom> iterator {
            return emptyIterator;
        }
        
        shared actual Nothing item(Integer key) {
            return null;
        }
        
        shared actual Empty segment(Integer from, Integer length) {
            return this;
        }
        
        shared actual Empty span(Integer from, Integer? to) {
            return this;
        }
        
        shared actual String string {
            return "{}";
        }
        shared actual Nothing lastIndex { return null; }
        
        shared actual Empty clone {
            return this;
        }
        
        shared actual Boolean contains(Object element) {
            return false;
        }
        
        shared actual Integer count(Object element) {
            return 0;
        }
        
        shared actual Boolean defines(Integer index) {
            return false;
        }
        
    }

In the definition of `Empty` above you may have noticed the special type `Bottom`,
which represents:

* the empty set, or equivalently
* the intersection of all types.

Since the empty set is a subset of all other sets, `Bottom` is assignable to 
all other types. Why is this useful here? Well, 
`Correspondence<Integer,Element>` and `Iterable<Element>` are both covariant 
in the type parameter `Element`. So `Empty` is assignable to 
`Correspondence<Integer,T>` and `Iterable<T>` for any type `T`. That's why 
`Empty` doesn't need a type parameter. The following code is well-typed:

    void printAll(String[] strings) {
        Iterator<String> i = strings.iterator;
        while (is String s = i.next()) {
            print(s);
        }
    }

Since both `Empty` and `Sequence<String>` are subtypes of `Iterable<String>`, 
the union type `String[]` is also a subtype of `Iterable<String>`.

Another cool thing to notice here is the return type of the `first` and 
`value()` operations of `Empty`. You might have been expecting to see `Bottom?` 
here, since they override supertype members of type `T?`. But as we saw in 
the [first part](../basics) of the Tour,
`Bottom?` is just an abbreviation for `Nothing|Bottom`. And `Bottom` is 
the empty set, so the union `Bottom|T` of `Bottom` with any other type `T` 
is just `T` itself.

The Ceylon compiler is able to do all this reasoning automatically. So when 
it sees an `Iterable<Bottom>`, it knows that the operation `first` is of type 
`Nothing`, i.e. it is the value `null`.

Cool, huh?


## Sequence gotchas for Java developers

Superficially, a sequence type looks a lot like a Java array, but really it's 
very, very different! First, of course, a sequence type 
`Sequence<String>` is an immutable interface, it's not a mutable concrete 
type like an array. We can't set the value of an element:

<!-- check:none:Demoing error -->
    String[] operators = .... ;
    operators[0] := "**"; //compile error

Furthermore, the index operation `operators[i]` returns an optional type 
`String?`, which results in quite different code idioms. To begin with, 
we don't iterate sequences by index like in C or Java. The following code 
does not compile:

<!-- check:none:Demoing error -->
    for (i in 0..operators.size-1) {
        String op = operators[i]; //compile error
        ...
    }

Here, `operators[i]` is a `String?`, which is not directly assignable to 
`String`.

Instead, if we need access to the index, we use the special form of `for` 
shown above.

<!-- cat: void m(String operators) { -->
    for (i -> op in entries(operators)) {
        // ...
    }
<!-- cat: } -->

Likewise, we don't usually do an upfront check of an index against the sequence length:

<!-- check:none:demoing error -->
    if (i>operators.size-1) {
        throw IndexOutOfBoundException();
    }
    else {
        return operators[i]; //compile error
    }

Instead, we do the check *after* accessing the sequence element:

<!-- cat: 
    class IndexOutOfBoundException() extends Exception(null, null) {} 
    String m(String[] operators, Integer i) { -->
    if (exists op = operators[i]) {
        return op;
    }
    else {
        throw IndexOutOfBoundException();
    }
<!-- cat: } -->

We especially don't ever need to write the following:

<!-- check:none:demoing error -->
    if (i>operators.size-1) {
        return "";
    }
    else {
        return operators[i]; //compile error
    }

This is much cleaner:

<!-- cat: String m(String[] operators, Integer i) { -->
    return operators[i] ? "";
<!-- cat: } -->

All this may take a little getting used to. But what's nice is that all the 
exact same idioms also apply to other kinds of `Correspondence`, including 
`Entries` and 
[`Maps`](#{site.urls.apidoc_current}/ceylon/language/interface_Map.html) .


## There's more...

Next we'll talk about [types](../types), specifically union types and
algebraic data types, type switching, and type inference. 

