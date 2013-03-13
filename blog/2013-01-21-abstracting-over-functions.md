---
title: Abstracting over functions
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

Last week, I was finally able to write the functions `compose()` and `curry()`
in Ceylon and compile them with the Ceylon compiler. These functions are
general purpose higher order functions that operate on other functions at a
very high level of abstraction. In most programming languages, it's very easy
to define a `compose()` function that works for functions with just one
parameter. For example, in Ceylon:

<!-- try: -->
    X compose<X,Y,Z>(X(Y) f, Y(Z) g)(Z z) => f(g(z));

In this function signature, `f()` and `g()` are functions with one parameter where
the return type of `g()` is the same as the parameter type of `f()`. The resulting
function is also a function with one parameter, and has the same return type 
as `f()` and the same parameter type as `g()`.

<!-- try: -->
    String format(Float|Integer number) { .... }
    value printf = compose(print,format);
    printf(1.0); //prints 1.0

Now, things get trickier when `g()` has more than one parameter. Imagine the
following definition of `format()`:

<!-- try: -->
    String format(String pattern, Float|Integer number) { .... }

This function has the type `String(String,Float|Integer)`, which can't be a 
`Y(Z)`, no matter what argument types we choose or infer for `Y` and `Z`. To 
see this more clearly, and to see how we can come up with a more powerful
definition of `compose()`, we're going to have to understand how Ceylon really 
represents function types. But first we're going to need to understand tuples.

Tuples
------
Ceylon recently grew tuples. I've heard all sorts of arguments for including
tuples in the language, but what finally convinced me was realizing that they 
were a simpler way to represent function types.

So a major goal of adding tuples to the language was to add zero additional 
complexity to the type system. So tuples are instances of an ordinary class,
`Tuple`, which you can see defined 
[here](https://raw.github.com/ceylon/ceylon.language/master/src/ceylon/language/Tuple.ceylon).

A tuple is a linked list where each link in the list encodes the static type
of the element. Without syntax sugar, we can write:

<!-- try: -->
    value point = Tuple(0.0, Tuple(0.0, Tuple("origin")));

I bet you're wondering what type `point` has. Well, if you really _have_ to 
know, it's:

<!-- try: -->
    Tuple<Float|String,Float,Tuple<Float|String,Float,Tuple<String,String,Empty>>> 

Phew! Fortunately we never see this type, because Ceylon lets us abbreviate it 
to `[Float,Float,String]`, and the IDE always shows us the abbreviated form. 
We can also use the square brackets to instantiate tuples, letting us write:

<!-- try: -->
    [Float,Float,String] point = [0.0, 0.0, "origin"];

(Yep, tuples are square in Ceylon. Don't worry, you'll quickly get used to 
that.)

A tuple is a sequence (`Tuple` is a subclass of `Sequence`), so the following 
is well-typed:

<!-- try: -->
    <Float|String>[] seq = point;
    Null|Float|String first = seq[0];

Now, what makes a tuple special is that we can access its elements without 
losing their static type information. We can write:

<!-- try: -->
    Float x = point.first;
    Float y = point.rest.first;
    String label = point.rest.rest.first;

I should emphasize that we're not seeing any magic here. You could write your 
own `MyTuple` class and reproduce the exact same behavior! 

I bet you're wondering what happens if I type `point.rest.rest.rest.first`. 
Well, take a closer look at the verbose type of `point` again. The chain of 
"links" is terminated by `Empty`, Ceylon's empty sequence type. And the type 
of `first` on `Empty` is `Null`. So we have:

<!-- try: -->
    Null zippo = point.rest.rest.rest.first;

That is, the expression is provably `null`. Provable within the type system,
that is.

Of course, we don't want to make you write out suff like `point.rest.rest.first`
whenever you need to get something out of a tuple. A tuple is a sequence, so 
you can access its elements using the index operator, for example:

<!-- try: -->
    Integer i = ... ;
    Null|Float|String ith = point[i];

But, as a special convenience, when the index is a literal integer, the compiler
will treat it as if it were a chain of calls to `rest` and `first`:

<!-- try: -->
    Float x = point[0];
    Float y = point[1];
    String label = point[2];
    Null zippo = point[3];

A chain of `Tuple` instances doesn't need to be terminated by an `Empty`. It may,
alternatively, be terminated by a nonempty sequence, any instance of `Sequence`.
We can write the following:

<!-- try: -->
    String[] labels = ["origin", "center"];
    [Float, Float, String*] point = [0.0, 0.0, *labels];

The type `[Float, Float, String*]` is an abbreviation for:

<!-- try: -->
    Tuple<Float|String,Float,Tuple<Float|String,Float,String[]>> 

It represents a sequence of two `Float`s, followed by an unknown number of 
`String`s. So the following is well-typed:

<!-- try: -->
    [Float, Float, String*] point0 = [0.0, 0.0];
    [Float, Float, String*] point1 = [0.0, 0.0, "origin"];
    [Float, Float, String*] point2 = [0.0, 0.0, "origin", "center"];

We'll now see how all this is useful for abstracting over function parameter 
types.  

Function types
--------------
An instance of the interface `Callable` is a function.

<!-- try: -->
    shared interface Callable<out Return, in Arguments> 
            given Arguments satisfies Anything[] {}

Going back to our function `format()` above, its type is:

<!-- try: -->
    Callable<String,[String,Float|Integer]>

You can see that we've represented the parameter types of the function using a
tuple type. That is to say, Ceylon views a function as accepting a tuple of
arguments, and producing a single value. Indeed, Ceylon even lets use write
that explicitly:

<!-- try: -->
    [String,Float] args = ["%5.2f", 1.0];
    print(format(*args));

Here we "spread" the elements of the tuple `args` across the parameters of the
function `format()`, just like you can do in some dynamically typed languages!

Now consider a function with a variadic argument:

<!-- try: -->
     String format(String pattern, Float|Integer* numbers) { .... }

This function accepts a `String`, followed by any number of `Float`s and 
`Integer`s. We can represent its type as follows:

<!-- try: -->
     Callable<String,[String,Float|Integer*]>

We usually abbreviate function types, writing `String(String,Float|Integer)` 
or `String(String,Float|Integer*)` for the function types above.

Ceylon also has defaulted parameters. The function type `String(String,String=)`
means `Callable<String,[String]|[String,String]>` and represents a function whose
second parameter has a default value.

Notice how, given the definitions we've just seen, assignability between function
types works out correctly:

- a `String(Object)` is an instance of `Object(String)`,
- a `String(String=)` is an instance of `String()` and of `String(String)`, and
- a `String(String*)` is an instance of `String()`, of `String(String)`, and of 
  `String(String,String)`.

Function composition and currying
---------------------------------
Finally we have the machinery we need to define `compose()` and `curry()`.

The signature of `compose()` is:

<!-- try: -->
    shared Callable<X,Args> compose<X,Y,Args>(X(Y) x, Callable<Y,Args> y) 
            given Args satisfies Anything[]

Notice how the type parameter `Args` abstracts over all possible parameter lists,
just as it does in the definition of `Callable`. To actually implement `compose()`,
I'm going to need to resort to two `native` functions that I can't yet implement
within the language. I can write down their signatures, however, so this isn't
a limitation of the type system itself:

<!-- try: -->
    shared native Callable<Return,Args> flatten<Return,Args>
                (Return tupleFunction(Args tuple))
            given Args satisfies Anything[];

    shared native Return unflatten<Return,Args>
                (Callable<Return,Args> flatFunction)(Args args)
            given Args satisfies Anything[];

If you're not _extremely_ interested, you can skip over these declarations, and
just look at an example of what they do:

<!-- try: -->
    String([String,Float|Integer]) unflatFormat = unflatten(format);
    String(String,Float|Integer) flatFormat = flatten(unflatFormat);

That is, `unflatten()` takes any function with any parameter list, and returns a 
function that accepts a single tuple of the same length as the original parameter
list. On the other hand, `flatten()` does the opposite. It takes a function that 
accepts a single tuple, and returns a function with a parameter list of the same 
length as the tuple.

OK, now we can implement `compose()`:

<!-- try: -->
    shared Callable<X,Args> compose<X,Y,Args>(X(Y) f, Callable<Y,Args> g) 
            given Args satisfies Anything[]
                   => flatten((Args args) => f(unflatten(g)(args)));

Perhaps I should unpack this slightly for readability:

<!-- try: -->
    shared Callable<X,Args> compose<X,Y,Args>(X(Y) f, Callable<Y,Args> g) 
            given Args satisfies Anything[] {
        X composed(Args args) {
            Y y = unflatten(g)(args);
            return f(y);
        }
        return flatten(composed);
    }

The definition of `curry()` is similarly dense:

<!-- try: -->
    shared Callable<Return,Rest> curry<Return,Argument,First,Rest>
                (Callable<Return,Tuple<Argument,First,Rest>> f)
                (First first)
            given First satisfies Argument 
            given Rest satisfies Argument[] 
                    => flatten((Rest args) => unflatten(f)(Tuple(first, args)));

This function accepts a function with at least one parameter and returns a function
with two parameter lists, the first parameter list has the first parameter of the
original function, and the second parameter list has the rest of the parameters.

Great! Now we can write:

<!-- try: -->
    value printf = compose(print,format);
    printf("%5.2f", 1.0); //prints 1.00
    value printFloat = curry(printf)("%5.2f");
    printFloat(2.5); //prints 2.50

A final word
------------
This post has been long and quite involved. I hope some of you made it this far. 
This isn't typical Ceylon code we're looking at here. We're starting to move into 
the field of metaprogramming, which is _just_ becoming possible in Ceylon. What 
I'm really trying to demonstrate here is how Ceylon layers sophisticated constructs 
as pure syntax sugar over a relatively simple type system. I'm trying to show that 
you can have things like tuple and function types without defining them primitively
as part of the type system, or resorting to inelegant hacks like `F1`, `F2`, `F3`, 
`Tuple1`, `Tuple2`, `Tuple3`, etc. And indeed it works out _better_ this way, I 
believe.
