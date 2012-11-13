---
layout: tour
title: Tour of Ceylon&#58; Sequences
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the sixth leg of the Tour of Ceylon. In the 
[previous leg](../anonymous-member-classes) we covered anonymous classes and 
member classes. Now we're going to look at *sequences*.


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

<!-- try-post:
    printBounds({"aap", "noot", "mies"});
    printBounds({});
-->
    void printBounds(String[] strings) {
        if (nonempty strings) {
            //strings is a Sequence<String>
            print(strings.first + ".." + strings.last);
        }
        else {
            print("Empty");
        }
    }

Note how this is just a continuation of the 
[pattern established](../basics#dealing_with_objects_that_arent_there) for 
`null` value handling. In fact, both these constructs are just syntactic
abbreviations for type narrowing:

- `if (nonempty strings)` is an abbreviation for `if (is Sequence<String> strings)`,
  just like 
- `if (exists name)` is an abbreviation for `if (is Object name)`.


## Sequence syntax sugar

There's lots more syntactic sugar for sequences. We can use a bunch of 
familiar Java-like syntax:

<!-- try-post:
    print(multiplicative);
-->
    String[] operators = { "+", "-", "*", "/" };
    String? plus = operators[0];
    String[] multiplicative = operators[2..3];

Oh, and the expression `{}` evaluates to an instance of `Empty`.

However, unlike Java, all these syntactic constructs are pure abbreviations. 
The code above is exactly equivalent to the following de-sugared code:

<!-- try: -->
<!-- check:none:pedagogial -->
    Empty|Sequence<String> operators = ArraySequence { "+", "-", "*", "/" };
    Nothing|String plus = operators.item(0);
    Empty|Sequence<String> multiplicative = operators.range(2,3);

(Except that, since the class `ArraySequence` is not declared `shared` by the 
Ceylon language module, the above code will not actually compile!)

A [`Range`](#{site.urls.apidoc_current}/ceylon/language/class_Range.html) 
is also a subtype of `Sequence`. The following:

<!-- try:
    Character[] uppercaseLetters = `A`..`Z`;
    Integer[] countDown =  10..0 ;
    print(uppercaseLetters);
    print(countDown);
-->
    Character[] uppercaseLetters = `A`..`Z`;
    Integer[] countDown = 10..0;

Is just sugar for:

<!-- try:
    Empty|Sequence<Character> uppercaseLetters = Range(`A`,`Z`);
    Empty|Sequence<Integer> countDown = Range(10,0);
    print(uppercaseLetters);
    print(countDown);
-->
    Empty|Sequence<Character> uppercaseLetters = Range(`A`,`Z`);
    Empty|Sequence<Integer> countDown = Range(10,0);

In fact, this is just a sneak preview of the fact that almost all operators 
in Ceylon are just sugar for method calls upon a type. We'll come back to this 
later, when we talk about [operator polymorphism](../language-module#operator_polymorphism).


## Iterating sequences

The `Sequence` interface extends 
[`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html), 
so we can iterate a `Sequence` using a `for` loop:

<!-- try-pre:
    String[] operators = { "+", "-", "*", "/" };
-->
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
iterating [`Entry`s](#{site.urls.apidoc_current}/ceylon/language/class_Entry.html):

<!-- try-pre:
    String[] operators = { "+", "-", "*", "/" };
-->
<!-- cat: void m(String operators) { -->
    for (i -> op in entries(operators...)) {
        print("" i ": " op "");
    }
<!-- cat: } -->

The 
[`entries()`](#{site.urls.apidoc_current}/ceylon/language/#entries) 
function returns an instance of `Entry<Integer,String>[]` containing the 
indexed elements of the sequence. The `->` is syntax sugar for the class 
`Entry`.

It's often useful to be able to iterate two sequences at once. The 
[`zip()`](#{site.urls.apidoc_current}/ceylon/language/#zip) 
function comes in handy here:

<!-- try-pre:
    String[] names = { "mies", "wim", "jet" };
    String[] places = { "hoogezand", "sappemeer", "kalkwijk" };
-->
<!-- cat: void m(String[] names, String[] places) { -->
    for (name -> place in zip(names,places)) {
        print(name + " @ " + place);
    }
<!-- cat: } -->

## Sequence and its supertypes

It's probably a good time to see some more advanced Ceylon code. What better 
place to find some than in the language module itself?

You can find the API documentation and source code of 
[`Sequence`](#{site.urls.apidoc_current}/ceylon/language/interface_Sequence.html)
online, or you can go to `Navigate > Open Ceylon Declaration...` to view the 
declaration of `Sequence` directly inside Ceylon IDE.

The most important operations of `Sequence` are inherited from 
[`Correspondence`](#{site.urls.apidoc_current}/ceylon/language/interface_Correspondence.html), 
and [`Iterable`](#{site.urls.apidoc_current}/ceylon/language/interface_Iterable.html).

- `Correspondence` provides the capability to access elements of the sequence
  by index, and
- `Iterable` provides the ability to iterate the elements of the sequence. 

## Empty sequences and the Bottom type

Now check out the definition of 
[`Empty`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html).
Notice that `Empty` is declared to be a subtype of `List<Bottom>`. This special 
type `Bottom` represents:

* the empty set, or equivalently
* the intersection of all types.

Since the empty set is a subset of all other sets, `Bottom` is assignable to 
all other types. Why is this useful here? Well, 
`Correspondence<Integer,Element>` and `Iterable<Element>` are both covariant 
in the type parameter `Element`. So `Empty` is assignable to 
`Correspondence<Integer,T>` and `Iterable<T>` for any type `T`. That's why 
`Empty` doesn't need a type parameter. The following code is well-typed:

<!-- try-post:
    printAll({"aap", "noot", "mies"});
-->
    void printAll(String[] strings) {
        Iterator<String> i = strings.iterator;
        while (is String s = i.next()) {
            print(s);
        }
    }

Since both `Empty` and `Sequence<String>` are subtypes of `Iterable<String>`, 
the union type `String[]` is also a subtype of `Iterable<String>`.

Since there are no actual instances of `Bottom`, if you ever see an attribute 
or method of type `Bottom`, you know for certain that it can't possibly ever 
return a value. There is only one possible way that such an operation can
terminate: by throwing an exception.

Another cool thing to notice here is the return type of the 
[`first`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html#first) and 
[`item()`](#{site.urls.apidoc_current}/ceylon/language/interface_Empty.html#item)
operations of `Empty`. You might have been expecting to see `Bottom?` 
here, since they override supertype members of type `T?`. But as we saw in 
the [first part](../basics) of the Tour, `Bottom?` is just an abbreviation for 
`Nothing|Bottom`. And `Bottom` is the empty set, so the union `Bottom|T` of 
`Bottom` with any other type `T` is just `T` itself.

The Ceylon compiler is able to do all this reasoning automatically. So when 
it sees an `Iterable<Bottom>`, it knows that the operation `first` is of type 
`Nothing`, i.e. it is the value `null`.

Cool, huh?


## Sequence gotchas for Java developers

Superficially, a sequence type looks a lot like a Java array, but really it's 
very, very different! First, of course, a sequence type `Sequence<String>` is 
an immutable interface, it's not a mutable concrete type like an array. We 
can't set the value of an element:

<!-- try:
    String[] operators = { "+", "-", "*", "/" };
    operators[0] := "**"; //compile error
-->
<!-- check:none:Demoing error -->
    String[] operators = .... ;
    operators[0] := "**"; //compile error

Furthermore, the index operation `operators[i]` returns an optional type 
`String?`, which results in quite different code idioms. To begin with, we 
don't iterate sequences by index like in C or Java. The following code does 
not compile:

<!-- try-pre:
    String[] operators = { "+", "-", "*", "/" };
-->
<!-- check:none:Demoing error -->
    for (i in 0..operators.size-1) {
        String op = operators[i]; //compile error
        // ...
    }

Here, `operators[i]` is a `String?`, which is not directly assignable to 
`String`.

Instead, if we need access to the index, we use the special form of `for` 
shown above.

<!-- try:
    String[] operators = { "+", "-", "*", "/" };
    for (i -> op in entries(operators...)) {
        print("" i.string ": " op "");
    }
-->
<!-- cat: void m(String operators) { -->
    for (i -> op in entries(operators...)) {
        // ...
    }
<!-- cat: } -->

Likewise, we don't usually do an upfront check of an index against the 
sequence length:

<!-- try: -->
<!-- check:none:demoing error -->
    if (i>operators.size-1) {
        throw IndexOutOfBoundException();
    }
    else {
        return operators[i]; //compile error
    }

Instead, we do the check *after* accessing the sequence element:

<!-- try: -->
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

<!-- try: -->
<!-- check:none:demoing error -->
    if (i>operators.size-1) {
        return "";
    }
    else {
        return operators[i]; //compile error
    }

This is much cleaner:

<!-- try: -->
<!-- cat: String m(String[] operators, Integer i) { -->
    return operators[i] else "";
<!-- cat: } -->

All this may take a little getting used to. But what's nice is that all the 
exact same idioms also apply to other kinds of `Correspondence`, including 
[`Map`s](#{site.urls.apidoc_current}/ceylon/language/interface_Map.html) .


## There's more...

Next we'll explore some more details of the type system, starting with
[union types, intersection types, algebraic data types, type switching, 
and type inference](../types). Then, after that, we'll be ready to discuss 
[generic types](../generics). 

