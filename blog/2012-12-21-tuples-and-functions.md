---
title: Tuples and function types
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [design]
---

# Tuples

Ceylon is getting _tuples_ in the next version. For those who don´t know what a tuple is,
it´s a bit like a `struct` in C: a finite sequence of heterogeneous typed elements values,
with no methods (unlike a class) and no names (unlike C structures). But let´s start with
an example.

In Ceylon, `[1, 2.0, "Hello"]` is a tuple value of size 3 with type `[Integer, Float, String]`.
Now let´s see a more useful example:

<!-- try: -->
    // convert a sequence of strings into a sequence of tuples with size, string
    // and number of uppercase letters
    value results = ["Merry Christmas", "Happy Cheesy Holidays"]
      .map((String s) [s.size, s, s.count((Character c) c.uppercase)]);
    for(result in results){
        Integer size = result[0];
        String s = result[1];
        Integer uppercaseLetters = result[2];
        print("Size: " size ", for: '" s "', uppercase letters: " uppercaseLetters "");
    }

As you can see, you can access each tuple element using the `Correspondence.item` syntax sugar `result[i]`,
and that's because our `Tuple` type _satisfies_ `Sequence`, underneath.

You may ask, but then what is the sequence type of a `[Integer, String, Integer]` tuple, then? Easy: it´s
`Sequencial<Integer|String>`.

Then how do we possibly know that `result[2]` is an `Integer` and not an `Integer|String`? Well, that´s
again syntactic sugar.

You see, our Tuple type is defined like this:

<!-- try: -->
    shared class Tuple<out Element, out First, out Rest>(first, rest)
            extends Object()
            satisfies Sequence<Element>
            given First satisfies Element
            given Rest satisfies Element[] {
            
        shared actual First first;
        shared actual Rest rest;
    
        // ...
    }

So a tuple is just a sort of elaborate `cons`-list and `result[2]` is syntactic sugar for `result.rest.rest.first`,
which has type `Integer`.

Similarly, the `[Integer, String, Integer]` type literal is syntactic sugar for:

<!-- try: -->
    Tuple<Integer|String, Integer, Tuple<Integer|String, String, Tuple<Integer, Integer, Empty>>>

And last, the `[0, "foo", 2]` value literal is syntactic sugar for:

<!-- try: -->
    Tuple(0, Tuple("foo", Tuple(2, empty)))

As you can see, our type inference rules are smart enough to infer the `Integer|String` sequential types by itself.

# Function types

So tuples are nice, for example to return multiple values from a method, but that´s not all you can do with them.

Here´s how our `Callable` type (the type of Ceylon functions and methods) is defined:

<!-- try: -->
    shared interface Callable<out Return, in Arguments> 
        given Arguments satisfies Void[] {}

As you can see, its `Arguments` type parameter accepts a sequence of anything (`Void` is the top of the object
hierarchy in Ceylon, above `Object` and the type of `null`), which means we can use tuple types to describe
the parameter lists:

<!-- try: -->
    void threeParameters(Integer a, String b, Float c){
    }
    
    Callable<Void, [Integer, String, Float]> threeParametersReference = threeParameters;

So, `Callable<Void, [Integer, String, Float]>` describes the type of a function which returns `Void` and takes
three parameters of types `Integer`, `String` and `Float`.

But you may ask what the type of a function with defaulted parameters is? Defaulted parameters are optional
parameters, that get a default value if you don´t specify them:

<!-- try: -->
    void oneOrTwo(Integer a, Integer b = 2){
        print("a = " a ", b = " b ".");
    }
    oneOrTwo(1);
    oneOrTwo(1, 1);

That would print:

<!-- lang: none -->
    a = 1, b = 2.
    a = 1, b = 1.

So let´s see what the type of `oneOrTwo` is:

<!-- try: -->
    Callable<Void, [Integer, Integer=]> oneOrTwoReference = oneOrTwo;
    // magic: we can still invoke it with one or two arguments!
    oneOrTwoReference(1);
    oneOrTwoReference(1, 1);

So its type is `Callable<Void, [Integer, Integer=]>`, which means that it takes one or two parameters. We´re not
sure yet about the `=` sign in `Integer=` to denote that it is optional, so that may change. This is syntactic
sugar for `Callable<Void, [Integer] | [Integer, Integer]>`, meaning: a function that takes one or two parameters.

Similarly, variadic functions also have a denotable type:

<!-- try: -->
    void zeroOrPlenty(Integer... args){
        for(i in args){
            print(i);
        }
    }
    Callable<Void, [Integer...]> zeroOrPlentyReference = zeroOrPlenty;
    // magic: we can still invoke it with zero or more arguments!
    zeroOrPlentyReference();
    zeroOrPlentyReference(1);
    zeroOrPlentyReference(5, 6);

Here, `[Integer...]` means that it accepts a sequence of zero or more `Integer` elements.

Now if you´re not impressed yet, here´s the thing that´s really cool: thanks to our subtyping rules (nothing
special here, just our normal subtyping rules related to union types), we´re able
to figure out that a function that takes one or two parameters is a supertype of both functions that take one parameter
and functions that take two parameters:

<!-- try: -->
    Callable<Void, [Integer, Integer=]> oneOrTwoReference = oneOrTwo;
    
    // we can all it with one parameter
    Callable<Void, [Integer]> one = oneOrTwoReference;
    // or two
    Callable<Void, [Integer, Integer]> two = oneOrTwoReference;

And similarly for variadic functions, they are supertypes of functions that take any number of parameters:

<!-- try: -->
    Callable<Void, [Integer...]> zeroOrPlentyReference = zeroOrPlenty;

    // we can call it with no parameters
    Callable<Void, []> zero = zeroOrPlentyReference;
    // or one
    Callable<Void, [Integer]> oneAgain = zeroOrPlentyReference;
    // or two
    Callable<Void, [Integer, Integer]> twoAgain = zeroOrPlentyReference;
    // and even one OR two parameters!
    Callable<Void, [Integer, Integer=]> oneOrTwoAgain = zeroOrPlentyReference;

Although this is something that dynamic languages have been able to do for decades, this is pretty impressive in a
statically typed language, and allows flexibility in how you use, declare and pass functions around that follows the
rules of logic (and checked!) and don´t make you fight the type system.

# By the way

I´ve shown here that we support method references in Ceylon, but the same is true with constructors, because after all
a constructor is nothing more than a function that takes parameters and returns a new instance:

<!-- try: -->
    class Foo(Integer x){
        shared actual String string = "Foo " x "";
    }
    print(Foo(2));
    
    Callable<Foo, [Integer]> makeFoo = Foo;
    print(makeFoo(3));

Will print:

<!-- lang: none -->
    Foo 2
    Foo 3
