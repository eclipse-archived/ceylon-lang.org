---
layout: tour
title: Tour of Ceylon&#58; Iterables, sequences, and tuples 
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the sixth leg of the Tour of Ceylon. In the 
[previous leg](../anonymous-member-classes) we covered anonymous classes and 
member classes. Now we're going to look at *iterable objects*, *sequences*, 
and *tuples*. These are examples of generic _container objects_. Don't worry,
we'll come back to talk more about generics [later](../generics).


## Iterables

An _iterable_ object is an object that produces a stream of values. Iterable
objects satisfy the interface 
[`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html).

Ceylon provides some syntax sugar for working with iterable objects:

- the type `Iterable<X,Null>` represents an iterable object that might not 
  produce any values when it is iterated, and may be abbreviated `{X*}`, and
- the type `Iterable<X,Nothing>` represents an iterable object that always 
  produces at least one value when it is iterated, and is usually abbreviated
  `{X+}`.

We may construct an instance of `Iterable` using braces:

    {String+} words = { "hello", "world" };
    {String+} moreWords = { "hola", "mundo", *words };

The prefix `*` is called the _spread operator_. It "spreads" the values of an 
iterable object. So `moreWords` produces the values `"hola", "mundo", "hello", 
"world"` when iterated.

As we'll see [later](../comprehensions), the braces may even contain a
_comprehension_, making them much more powerful than what you see here.

`Iterable` is a subtype of the interface 
[`Category`](#{site.urls.apidoc_current}/interface_Category.html),
so we can use the `in` operator to test if a value is produced by the 
`Iterable`.

<!-- try: -->
    if (exists char = text[i],
        char in {',', '.', '!', '?', ';', ':'}) {
        //...
    }

<br/>

<!-- try: -->
    "index must be between 1 and 100"
    assert (index in 1..100);

The `in` operator is just syntactic sugar for the method `contains()` of
`Category`.


## Iterating using `for`

To iterate an instance of `Iterable`, we can use a 
[`for` loop](../attributes-control-structures/#for):

<!-- try-pre:
    {String+} words = { "hello", "world" };
    {String+} moreWords = { "hola", "mundo", *words };
-->
    for (word in moreWords) {
        print(word);
    }

If, for any reason, we need an index for each element produced by an iterable 
object, we can use a special variation of the `for` loop that is designed for 
iterating [`Entry`s](#{site.urls.apidoc_current}/class_Entry.html):

<!-- try-pre:
    {String+} words = { "hello", "world" };
    {String+} moreWords = { "hola", "mundo", *words };
-->
    for (i -> word in entries(moreWords)) {
        print("``i``: ``op``");
    }

The [`entries()`](#{site.urls.apidoc_current}/#entries) 
function returns an instance of `Entry<Integer,String>[]` containing the 
indexed elements of the sequence. (The `->` is syntax sugar for the class 
`Entry`.)

It's often useful to be able to iterate two sequences at once. The 
[`zip()`](#{site.urls.apidoc_current}/#zip) 
function comes in handy here:

<!-- try-pre:
    String[] names = ["mies", "wim", "jet"];
    String[] places = ["hoogezand", "sappemeer", "kalkwijk"];
-->
<!-- cat: void m(String[] names, String[] places) { -->
    for (name -> place in zip(names,places)) {
        print(name + " @ " + place);
    }
<!-- cat: } -->


## Sequences

Some kind of array or list construct is a universal feature of all programming 
languages. The Ceylon language module defines support for *sequence types* via
the interfaces [`Sequential`](#{site.urls.apidoc_current}/interface_Sequential.html),
[`Sequence`](#{site.urls.apidoc_current}/interface_Sequence.html),
and [`Empty`](#{site.urls.apidoc_current}/interface_Empty.html). 

Again, there is some syntax sugar associated with sequences:

- the type `Sequential<X>` represents a sequence that may be empty, and may be 
  abbreviated `[X*]` or `X[]`,
- the type `Sequence<X>` represents a nonempty sequence, and may be abbreviated 
  `[X+]`, and
- the type `Empty` represents an empty sequence and is abbreviated `[]`.

Some operations of the type `Sequence` aren't defined by `Sequential`, so you 
can't call them if all you have is `X[]`. Therefore, we need the
 `if (nonempty ... )` construct to gain access to these operations.

<!-- try-post:
    printBounds(["aap", "noot", "mies"]);
    printBounds([]);
-->
    void printBounds(String[] strings) {
        if (nonempty strings) {
            //strings is of type [String+] here
            print(strings.first + ".." + strings.last);
        }
        else {
            print("Empty");
        }
    }

Notice how this is just a continuation of the 
[pattern established](../basics#dealing_with_objects_that_arent_there) for 
`null` value handling. In fact, both these constructs are just syntactic
abbreviations for type narrowing:

- `if (nonempty strings)` is an abbreviation for `if (is [String+] strings)`,
  just like 
- `if (exists name)` is an abbreviation for `if (is Object name)`.


## Sequence syntax sugar

There's lots more syntactic sugar for sequences. We can use a bunch of 
familiar Java-like syntax:

<!-- try-post:
    print(multiplicative);
-->
    String[] operators = [ "+", "-", "*", "/" ];
    String? plus = operators[0];
    String[] multiplicative = operators[2..3];

Oh, and the expression `[]` evaluates to an instance of `Empty`.

<!-- try-post:
    print(none);
-->
    [] none = [];

However, unlike Java, all these syntactic constructs are pure abbreviations. 
The code above is exactly equivalent to the following de-sugared code:

<!-- try: -->
<!-- check:none:pedagogial -->
    Sequential<String> operators = ... ;
    Null|String plus = operators.get(0);
    Sequential<String> multiplicative = operators.span(2,3);

(We'll come back to what the list of values in brackets means in a minute!)

The `Sequence` interface extends 
[`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html), 
so we can iterate a `Sequence` using a `for` loop:

<!-- try-pre:
    String[] operators = ["+", "-", "*", "/"];
-->
<!-- cat: void m(String[] operators) { -->
    for (op in operators) {
        print(op);
    }
<!-- cat: } -->


## Ranges

A [`Range`](#{site.urls.apidoc_current}/class_Range.html)
is a kind of `Sequence`. The following:

<!-- try:
    Character[] uppercaseLetters = 'A'..'Z';
    Integer[] countDown =  10..0 ;
    print(uppercaseLetters);
    print(countDown);
-->
    Character[] uppercaseLetters = 'A'..'Z';
    Integer[] countDown = 10..0;

Is just sugar for:

<!-- try:
    Sequential<Character> uppercaseLetters = Range('A','Z');
    Sequential<Integer> countDown = Range(10,0);
    print(uppercaseLetters);
    print(countDown);
-->
    Sequential<Character> uppercaseLetters = Range('A','Z');
    Sequential<Integer> countDown = Range(10,0);

In fact, this is just a sneak preview of the fact that almost all operators 
in Ceylon are just sugar for method calls upon a type. We'll come back to this 
later, when we talk about [operator polymorphism](../language-module#operator_polymorphism).

Ceylon doesn't need C-style `for` loops. Instead, combine `for` with the 
range operator:

<!-- cat: void m() { -->
    variable Integer fac=1;
    for (n in 1..100) {
        fac*=n;
        print("Factorial ``n``! = ``fac``");
    }
<!-- cat: } -->

## Sequence and its supertypes

It's probably a good time to see some more advanced Ceylon code. What better 
place to find some than in the language module itself?

You can find the API documentation and source code of 
[`Sequence`](#{site.urls.apidoc_current}/interface_Sequence.html)
online, or you can go to `Navigate > Open Ceylon Declaration...` to view the 
declaration of `Sequential` directly inside Ceylon IDE.

The most important operations of `Sequential` are inherited from 
[`Correspondence`](#{site.urls.apidoc_current}/interface_Correspondence.html), 
and [`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html).

- `Correspondence` provides the capability to access elements of the sequence
  by index, and
- `Iterable` provides the ability to iterate the elements of the sequence. 

Now open the class [`Range`](#{site.urls.apidoc_current}/class_Range.html)
in the IDE, to see a concrete implementation of the `Sequence` interface.

## Empty sequences and the bottom type

Finally, check out the definition of 
[`Empty`](#{site.urls.apidoc_current}/interface_Empty.html).
Notice that `Empty` is declared to be a subtype of `List<Nothing>`. This special 
type `Nothing`, often called the _bottom type_, represents:

* the empty set, or equivalently
* the intersection of all types.

Since the empty set is a subset of all other sets, `Nothing` is assignable to 
all other types. Why is this useful here? Well, `Correspondence<Integer,Element>` 
and `Iterable<Element>` are both covariant in the type parameter `Element`. So 
`Empty` is assignable to `Correspondence<Integer,T>` and `Iterable<T>` for any 
type `T`. That's why `Empty` doesn't need a type parameter.

Since there are no actual instances of `Nothing`, if you ever see an attribute 
or method of type `Nothing`, you know for certain that it can't possibly ever 
return a value. There is only one possible way that such an operation can
terminate: by throwing an exception.

Another cool thing to notice here is the return type of the 
[`first`](#{site.urls.apidoc_current}/interface_Empty.html#first) and 
[`item()`](#{site.urls.apidoc_current}/interface_Empty.html#item)
operations of `Empty`. You might have been expecting to see `Nothing?` 
here, since they override supertype members of type `T?`. But as we saw in 
the [first part](../basics) of the Tour, `Nothing?` is just an abbreviation for 
`Null|Nothing`. And `Nothing` is the empty set, so the union `Nothing|T` of 
`Bottom` with any other type `T` is just `T` itself.

The Ceylon compiler is able to do all this reasoning automatically. So when 
it sees an `Iterable<Nothing>`, it knows that the operation `first` is of type 
`Null`, i.e. that its value is `null`.

Cool, huh?


## Sequence gotchas for Java developers

Superficially, a sequence type looks a lot like a Java array, but really it's 
very, very different! First, of course, a sequence type `Sequential<String>` is 
an immutable interface, it's not a mutable concrete type like an array. We 
can't set the value of an element:

<!-- try:
    String[] operators = ["+", "-", "*", "/"];
    operators[0] = "^"; //compile error
-->
<!-- check:none:Demoing error -->
    String[] operators = .... ;
    operators[0] = "^"; //compile error

Furthermore, the index operation `operators[i]` returns an optional type 
`String?`, which results in quite different code idioms. To begin with, we 
don't iterate sequences by index like in C or Java. The following code does 
not compile:

<!-- try-pre:
    String[] operators = ["+", "-", "*", "/"];
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
    String[] operators = [ "+", "-", "*", "/" ];
    for (i -> op in entries(operators)) {
        // ...
    }
-->
<!-- cat: void m(String operators) { -->
    for (i -> op in entries(operators)) {
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

Indeed, this is a common use for `assert`:

<!-- try: -->
<!-- cat: 
    class IndexOutOfBoundException() extends Exception(null, null) {} 
    String m(String[] operators, Integer i) { -->
    assert (exists op = operators[i]);
    return op;
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
[`Map`s](#{site.urls.apidoc_current}/interface_Map.html) .

## Tuples

A _tuple_ is a linked list which captures the static type of each individual 
element in the list. For example:

    [Float,Float,String] point = [0.0, 0.0, "origin"];

This tuple contains a two `Float`s followed by a `String`. That information
is captured in its static type, `[Float,Float,String]`.

Each link of the list is an instance of the class
[`Tuple`](#{site.urls.apidoc_current}/class_Tuple.html).
If you really _must know_, the code above is syntax sugar for the following:

    Tuple<Float|String,Float,Tuple<Float|String,Float,Tuple<String,String,Empty>>>
            point = Tuple(0.0, Tuple(0.0, Tuple("origin")));

Therefore, we _always_ use syntax sugar when working with tuples.

`Tuple` extends `Sequence`, so we can do all the usual kinds of sequency 
things to a tuple, iterate it, and so on. As with sequences, we can access
a tuple element by index. But in the case of a tuple, Ceylon is able to
determine the type of the element when the index is a literal integer: 

    Float x = point[0];
    Float y = point[1];
    String label = point[2];
    Null zippo = point[3];

A _unterminated_ tuple is a tuple where the last link in the list is
a sequence, not an `Empty`. For example:

    String[] labels = ... ;
    [Float,Float,String*] point = [0.0, 0.0, *labels];

This tuple contains two `Float`s followed by an unknown number of `String`s.

Now we can see that a sequence type like `[String*]` or `[String+]` can
be viewed as a degenerate tuple type!

## There's more...

If you're interested, you can find a more in-depth discussion of tuples 
[here](/blog/2013/01/21/abstracting-over-functions/).

Next up we'll explore some more details of the type system, starting with
[type aliases and type inference](../typeinference).

