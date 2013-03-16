---
layout: tour
title: Tour of Ceylon&#58; Functions
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the eleventh part of the Tour of Ceylon. In the [previous leg](../modules) 
we looked at packages and modules. This leg covers first class and higher-order 
functions.


## First class and higher order functions

Ceylon isn't a functional language: it has variable attributes and so methods 
can have *side effects*. But one thing Ceylon has in common with functional
programming languages is that it lets you treat functions as values, which in 
some people's eyes makes the language a kind of hybrid. In truth, there's 
nothing remotely new about having functions-as-values in an object oriented 
language — for example, Smalltalk, one of the first and still one of the 
cleanest object oriented languages, was built around this idea. Anyway, Ceylon, 
like Smalltalk and a number of other object oriented languages, lets you treat 
a function as an object and pass it around the system.

In this installment, we're going to discuss Ceylon's support for first class 
and higher order functions. A little bit of PL jargon:

- _First class function_ support means the ability to treat a function as a 
   value, assigning it to variables, and passing it as an argument. 
- A _higher order function_ is a function that accepts other functions as 
  arguments, or returns another function.
  
It's clear that these two ideas go hand-in-hand, so we'll just use the term 
"higher order functions" from now on.


## Representing the type of a function

Ceylon is a (very) statically typed language. So if we're going to treat a 
function as a value, the very first question that arises is: What is the 
type of the function? We need a way to encode the return type and parameter 
types of a function into the type system. Remember that Ceylon doesn't have 
"primitive" types. A strong design principle is that every type should be 
representable within the type system as a class or interface declaration.

In Ceylon, a single type 
[`Callable`](#{site.urls.apidoc_current}/interface_Callable.html) 
abstracts *all* functions. Its declaration is the following:

<!-- check:none -->
    shared interface Callable<out Return, in Arguments> 
            given Arguments satisfies Anything[] {}

The type parameter `Return` represents the return type of the function. The 
sequenced type parameter `Arguments`, which must be a sequence type, 
represents the parameter types of the function. We can encode any parameter
list as a tuple type. For example, the parameter list `(String s, Float x)`
is encoded as the tuple type `[String,Float]`.

So, take the following function:

<!-- try-post:

    print(sum(4, 2));
-->
    function sum(Integer x, Integer y) => x+y;

The type of `sum()` is:

<!-- try: -->
<!-- check:none -->
    Callable<Integer,[Integer,Integer]>

What about `void` functions? Well, the return type of a `void` function is 
considered to be `Anything`. So the type of a function like `print()` is:

<!-- try: -->
<!-- check:none -->
    Callable<Anything,[Anything]>

Folks who have a background in languages like ML might have expected that
`void` would be identified with some "unit" type, for example, `Null`, or
perhaps `[]`. But this approach would mean that a non-`void` method would
not be able to refine a `void` method, and that a non-`void` function would
not be able to be assigned to a `void` functional parameter. Therefore,
perfectly reasonable code would be rejected by the compiler.  

Note that a `void` function with a concrete implementation implicitly returns 
the value `null`. This is different to a function declared to return the type 
`Anything`, which may return any value at all, but must do it explicitly, via 
a `return` statement. The following functions have the same type, `Anything()`, 
but don't do exactly the same thing:

    Anything hello() { 
        print("hello");
        return "hello";
    }

    void hello() { 
        print("hello");
        //implicitly returns null
    }

You shouldn't rely upon a function that is declared `void` returning `null`,
because it might be a method that is refined by a non-`void` method, or a
reference to a non-`void` function.

We can abbreviate `Callable` types with a little syntax sugar:

- `Integer(Integer,Integer)` means `Callable<Integer,[Integer,Integer]>`, 
   and, likewise,
- `Anything(String)` means `Callable<Anything,[String]>`.

<!--
## Representing the type of a method

Here we've been discussing first class functions. But in Ceylon all named 
declarations are "first class". That is to say, they all have a reified 
metamodel representable within the type system. For example, we could represent 
the type of a method like this:
-->
<!-- check:none --><!--
    shared interface Method<out Result, in Instance, Argument...>
        satisfies Callable<Callable<Result,Argument...>, Instance> {}

Where `Instance` is the type that declares the method. So the type of the 
method` iterator()` of `Iterable<String>` would be:
-->
<!-- check:none --><!--
    Method<Iterator<String>, Iterable<String>>

And the type of the method `compare()` of `Comparable<Integer>` would be:
-->
<!-- check:none --><!--
    Method<Comparison,Comparable<Integer>,Integer>

Notice that we've declared a method to be a function that accepts a 
receiver object and returns a function. As a consequence of this, an 
alternative method invocation protocol is the following:
-->
<!-- check:none:direct invocation of Callable objects not yet supported -->
<!-- cat: 
    void m() {
    String[] strings = {};
    Integer num = 0; --><!--
    Iterable<String>.iterator(strings)();
    Comparable<Integer>.compare(0)(num);-->
<!-- cat: } -->
<!--
Don't worry if you can't make sense of that right now. A few details 
are being glossed over here, that's not quite *exactly* how `Method` is 
defined. But we'll come back to this in a future installment. Let's get 
back to the current topic.
-->

## Defining higher order functions

We now have enough machinery to be able to write higher order functions. 
For example, we could create a `repeat()` function that repeatedly executes 
a function.

<!-- try: -->
<!-- check:none:BROKEN -->
    void repeat(Integer times, 
            Anything(Integer) perform) {
        for (i in 1..times) {
            perform(i);
        }
    }

Let's try it:

<!-- try-pre:
    void repeat(Integer times, 
            Anything(Integer) perform) {
        for (i in 1..times) {
            perform(i);
        }
    }
-->
    void printNum(Integer n) => print(n);
    repeat(10, printNum);

Which would print the numbers 1 to 10 to the console.

There's one problem with this. In Ceylon, as we'll see later, we often call 
functions using named arguments, but the Callable type does not encode the 
names of the function parameters. So Ceylon has an alternative, more elegant, 
syntax for declaring a parameter of type `Callable`:

<!-- try-post:

    void printNum(Integer n) => print(n);
    repeat(10, printNum);
-->
<!-- id:repeat -->
    void repeat(Integer times, 
            void perform(Integer n)) {
        for (i in 1..times) {
            perform { n=i; };
        }
    }

This version is also slightly more readable, so it's the preferred syntax.


## Function references

When a name of a function appears without any arguments, like `printNum` does 
above, it's called a *function reference*. A function reference is the thing 
that really has the type `Callable`. In this case, `printNum` has the type 
`Callable<Anything,Integer>`.

Now, remember how we said that `Anything` is both the return type of a `void` 
function, and also the logical root of the type hierarchy? Well that's useful 
here, since it means that we can assign a function with any return type to any 
parameter which expects a `void` function, as long as the parameter lists 
match:

<!-- try: -->
<!-- id:attemptPrint -->
    Boolean attemptPrint(Integer n) {
        try {
            print(n);
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }
    
And call it like this

<!-- try-pre:
    void repeat(Integer times, 
            void perform(Integer n)) {
        for (i in 1..times) {
            perform { n=i; };
        }
    }
    Boolean attemptPrint(Integer n) {
        try {
            print(n);
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }

-->
<!-- cat-id:repeat -->
<!-- cat-id:attemptPrint -->
<!-- cat: void m() { -->
    repeat(10, attemptPrint);
<!-- cat: } -->

Another way we can produce a function reference is by partially applying a 
method to a receiver expression. For example, we could write the following:

<!-- try: -->
<!-- id:Hello -->
    class Hello(String name) {
        shared void say(Integer n) {
            print("Hello, ``name``, for the ``n``th time!");
        }
    }

And call it like this:

<!-- try-pre:
    void repeat(Integer times, 
            void perform(Integer n)) {
        for (i in 1..times) {
            perform { n=i; };
        }
    }

    class Hello(String name) {
        shared void say(Integer n) {
            print("Hello, ``name``, for the ``n``th time!");
        }
    }
-->
<!-- cat-id:repeat -->
<!-- cat-id:Hello -->
<!-- cat: void m() { -->
    repeat(10, Hello("Gavin").say);
<!-- cat: } -->

Here the expression `Hello("Gavin").say` has the same type as `print` above. 
It is of type `Anything(Integer)`.


## Curried functions

A method or function may be declared in _curried_ form, allowing the method or
function to be partially applied to its arguments. A curried function has
multiple lists of parameters:

<!-- try-post:

    print(adder(4.0)(2.0));
-->
    Float adder(Float x)(Float y) => x+y;

The `adder()` function has type `Float(Float)(Float)`. We can invoke it with
a single argument to get a reference to a function of type `Float(Float)`,
and store this reference as a function, like this:

<!-- try-pre:
    Float adder(Float x)(Float y) => x+y;

-->
<!-- try-post:

    print(addOne(4.0));
-->
    Float addOne(Float y);
    addOne = adder(1.0);

Or as a value, like this:

<!-- try-pre:
    Float adder(Float x)(Float y) => x+y;

-->
<!-- try-post:

    print(addOne(4.0));
-->
    Float(Float) addOne = adder(1.0);

(There only real difference between these two approaches is that in the 
first case we get to assign a name to the parameter of `addOne()`.)

When we subsequently invoke `addOne()`, the actual body of `adder()` is 
finally executed, producing a `Float`:

<!-- try-pre:
    Float adder(Float x)(Float y) => x+y;
    Float addOne(Float y);
    addOne = adder(1.0);

-->
<!-- try-post:

    print(three);
-->
    Float three = addOne(2.0);


## Anonymous functions

The most famous higher-order functions are a trio of functions for tranforming,
filtering, and summarizing sequences of values. In Ceylon, these three functions,
`map()`, `filter()`, and `fold()` are methods of the interface 
[`Iterable`](#{site.urls.apidoc_current}/interface_Iterable.html).
(They even have a fourth, slightly less glamorous friend called `find()`, also a 
method of `Iterable`.)

As you've probably noticed, all the functions we've defined so far have been 
declared with a name, using a traditional C-like syntax. There's nothing wrong
with passing a named function to `map()` or `filter()`, and indeed that is often
useful: 

<!-- try-pre:
    value measurements = { 3.4, 8.7, 1.7, 13.1, 7.7, 1.2 };

-->
<!-- try-post:

    print(max);
-->
    Float max = measurements.fold(0.0, largest<Float>);

However, quite commonly, it's inconvenient to have to declare a whole named 
function just to pass it to `map()`, `filter()`, `fold()` or `find()`. Instead, 
we can declare an *anonymous function* inline, as part of the argument list:

<!-- try-pre:
    value measurements = { 3.4, 8.7, 1.7, 13.1, 7.7, 1.2 };

-->
<!-- try-post:

    print(max);
-->
    Float max = measurements.fold(0.0, 
            (Float max, Float num) => 
                    num>max then num else max);

An anonymous function has:

- optionally, the keyword `function` or `void`, and then
- a parameter list, enclosed in parentheses, followed by
- a fat arrow, `=>`, with an expression, or
- a block.

So we could rewrite the above using a block

<!-- try-pre:
    value measurements = { 3.4, 8.7, 1.7, 13.1, 7.7, 1.2 };

-->
<!-- try-post:

    print(max);
-->
    Float max = measurements.fold(0.0, 
            (Float max, Float num) {
                return num>max then num else max;
            });

Note that it's quite difficult to come up with a good way to format anonymous
functions with blocks, so it's usually better to just give the function a 
name and use it by reference.

## More about higher-order functions

Let's see a more practical example, which mixes both ways of representing a 
function type. 

Suppose we have some kind of user interface component which can be observed by 
other objects in the system. We could use something like Java's 
`Observer`/`Observable` pattern:

<!-- try-pre:
    interface Event { }
-->
<!-- check:parse:Requires OpenList -->
<!-- cat: class Event() { } -->
    interface Observer {
        shared formal void observe(Event event);
    }
    abstract class Component() {
         
        variable {Observer*} observers = {};
         
        shared void addObserver(Observer observer) {
            observers = {observer, *observers};
        }
         
        shared void fire(Event event) {
            for (o in observers) {
                o.observe(event);
            }
        }
    }

But now all event observers have to implement the interface `Observer`, which 
has just one method. Why don't we cut out the interface, and let event 
observers just register a function object as their event listener? In the 
following code, we define the `addObserver()` method to accept a function as 
a parameter.

<!-- try-pre:
    interface Event { }
-->
<!-- check:parse:Requires OpenList -->
    abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared void addObserver(void observe(Event event)) {
            observers = {observe, *observers};
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
    }

Here we see the difference between the two ways of specifying a function type:

* `void observe(Event event)` is more readable in parameter lists, where 
  `observe` is the name of the parameter, but
* `Anything(Event)` is useful in container types such as iterables.

Now, any event observer can just pass a reference to one of its own methods to 
`addObserver()`:

<!-- try-pre:
    interface Event { }
    abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared void addObserver(void observe(Event event)) {
            observers = {observe, *observers};
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
    }

-->
<!-- check:parse:Depends on Component, above, which requires OpenList -->
    class Listener(Component component) {
     
        void onEvent(Event e) {
            // respond to the event
            // ...
        }
         
        component.addObserver(onEvent);
         
        // ...
     
    }

When the name of a method appears in an expression without a list of arguments 
after it, it is a reference to the method, not an invocation of the method. 
Here, the expression `onEvent` is an expression of type `Anything(Event)` that 
refers to the method `onEvent()`.

If `onEvent()` were `shared`, we could even wire together the `Component` and 
`Listener` from some other code, to eliminate the dependency of `Listener` 
on `Component`:

<!-- try-pre:
    interface Event { }
    abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared void addObserver(void observe(Event event)) {
            observers = {observe, *observers};
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
    }

-->
<!-- check:parse:Depends on Component, above, which requires OpenList -->
    class Listener() {
     
        shared void onEvent(Event e) {
            // respond to the event
            // ...
        }
         
        // ...
     
    }
    void listen(Component component, Listener listener) {
        component.addObserver(listener.onEvent);
    }

Here, the syntax `listener.onEvent` is a kind of partial application of the 
method `onEvent()`. It doesn't cause the `onEvent()` method to be 
executed (because we haven't supplied all the parameters yet). Rather, it 
results in a function that packages together the method reference `onEvent` 
and the method receiver `listener`.

It's also possible to declare a method that returns a function. Let's 
consider adding the ability to remove observers from a `Component`. We could 
use a `Subscription` interface:

<!-- try:
    interface Event { }
    interface Subscription {
         shared formal void cancel();
    }
    shared abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared Subscription addObserver(void observe(Event event)) {
            observers = {observe, *observers};
            object subscription satisfies Subscription {
                cancel() => observers.remove(observe);
            }
            return subscription;
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
     
    }
-->
<!-- check:parse:Depends on OpenList -->
    shared interface Subscription {
        shared void cancel();
    }
    shared abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared Subscription addObserver(void observe(Event event)) {
            observers = {observe, *observers};
            object subscription satisfies Subscription {
                cancel() => observers.remove(observe);
            }
            return subscription;
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
     
    }

But a simpler solution might be to just eliminate the interface and return the 
`cancel()` method directly:

<!-- try:
    interface Event { }
    shared abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared Void() addObserver(void observe(Event event)) {
            observers = {observe, *observers};
            return () => observers.remove(observe);
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
     
    }
-->
<!-- check:parse:Depends on OpenList -->
    shared abstract class Component() {
         
        variable {Anything(Event)*} observers = {};
         
        shared Anything() addObserver(void observe(Event event)) {
            observers = {observe, *observers};
            return void () => observers.remove(observe);
        }
         
        shared void fire(Event event) {
            for (observe in observers) {
                observe(event);
            }
        }
     
    }

Here, we define an anonymous function inside the body of the `addObserver()` 
method, and return a reference to this function from the outer method. The 
reference to the anonymous function returned by `addObserver()` can be called 
by any code that obtains the reference.

In case you're wondering, the type of the function `addObserver()` is 
`Anything()(Anything(Event))`.

Notice that the anonymous function is able to use the parameter `observe` of 
`addObserver()`. We say that the inner method receives a *closure* of the 
non-`variable` locals and parameters of the outer method — just like a method 
of a class receives a closure of the class initialization parameters and locals 
of the class initializer. In general, any inner class, method, or attribute 
declaration always receives the closure of the members of the class, method, or 
attribute declaration in which it is enclosed. This is an example of how regular 
the language is.

We could invoke our method like this:

<!-- try: -->
<!-- check:none -->
    addObserver(onEvent)();

But if we were planning to use the method in this way, there would be no good 
reason for giving it two parameter lists. It's much more likely that we're 
planning to store or pass the reference to the inner method somewhere before 
invoking it.

<!-- try: -->
<!-- check:none -->
    Anything() cancel = addObserver(onEvent);
    // ...
    cancel();

The first line demonstrates how a function reference can be stored. The second 
line of code simply invokes the returned reference to `cancel()`.

<!--
We've already seen how an attribute can be defined using a block of code. Now 
we see that a method can be defined using a specifier. So, if you like, you 
can start thinking of a method as an attribute of type `Callable` — an 
attribute with parameters. Or if you prefer, you can think of an attribute as 
a member with zero parameter lists, and of a method as a member with one or 
more parameter lists. Either kind of member can be defined by reference, using 
`=`, or directly, by specifying a block of code to be executed.

Cool, huh? That's more regularity.
-->

## Composition and curry

The function `compose()` performs _function composition_. For example, given
the functions `print()` and `plus()` in `ceylon.language`, with the following
signatures:

<!-- try: -->
    shared void print(Anything line) { ... }
    
    shared shared Value plus<Value>(Value x, Value y)
        given Value satisfies Summable<Value> { ... }

We can see that the type of the function reference `print` is `Anything(Anything)`,
and that the type of the function reference `plus<Float>` is `Float(Float,Float)`.
Then we can write the following:

    Anything(Float,Float) printSum = compose(print,plus<Float>);
    printSum(2.0,2.0); //prints 4.0

The function `curry()` produces a function with multiple parameter lists, given
a function with multiple parameters:

<!-- try-pre:
    Anything(Float,Float) printSum = compose(print,plus<Float>);
-->
    Anything(Float)(Float) printSumCurried = curry(printSum);
    Anything(Float) printPlus2 = printSumCurried(2.0);
    printPlus2(2.0); //prints 4.0

The function `uncurry()` does the opposite, giving us back our original uncurried
signature:

<!-- try-pre:
    Anything(Float,Float) printSum = compose(print,plus<Float>);
    Anything(Float)(Float) printSumCurried = curry(printSum);
-->
<!-- try-post:
    printSumUncurried(2.0,2.0);
-->
    Anything(Float,Float) printSumUncurried = uncurry(printSumCurried);

Note that `compose()`, `curry()`, and `uncurry()` are ordinary functions, written 
in Ceylon.


## The spread operator

We've already seen a few examples of the spread operator. We've seen how to use
it to instantiate an iterable:

<!-- try: -->
    { "hello", *names }

Or a tuple:

<!-- try: -->
    [x, y, *labels]

We can also use it when calling a function. Consider the following function:

<!-- try: -->
    String formatDate(String format, 
                      Integer day, 
                      Integer|String month, 
                      Integer year) {
        ...
    }

And suppose we have a tuple representing a date:

<!-- try: -->
    value date = [15, "January", 2010];

Then we can pass the date to our function like this:

<!-- try: -->
    formatDate("dd MMMMM yyyy", *date)

Notice that the type of the tuple `["dd MMMMM yyyy", *date]` is:

<!-- try: -->
    [String,Integer,String,Integer] 

Now consider type of the function `formatDate`. It is:

<!-- try: -->
    String(String,Integer,Integer|String,Integer)
    
Or rather:

<!-- try: -->
    Callable<String,[String,Integer,Integer|String,Integer]>

Since the tuple type `[String,Integer,String,Integer]` is a subtype of 
`[String,Integer,Integer|String,Integer]`, the invocation is well-typed.
This demonstrates the relationship between tuples and function argument!
     


<!--
## Curry, uncurry and function composition

A method reference like `Float.times` is represented in "curried" form in Ceylon. 
I can write:

    Float twoTimes(Float x) = 2.0.times;

Here, the expression `2.times` is a typical first-class function reference 
produced by the partial application of the method 

[`times()`](#{site.urls.apidoc_current}/interface_Numeric.html#times) 
to the receiver expression `2.0`.

But I can also write:

    Float times(Float x)(Float y) = Float.times;

Actually, the expression `Float.times` is really a metamodel reference to a 
method declaration. The type `Method<Float,Float,Float>` is a subtype of 
`Callable<Callable<Float,Float>,Float>`, so we can treat it as a 
function reference.

Therefore, an alternative definition of `twoTimes()` is:

    Float twoTimes(Float x) = Float.times(2);

(We're partially applying `Float.times` by supplying one of its two 
argument lists.)

Unfortunately, the following isn't correctly typed:

    Float product(Float x, Float y) = Float.times;  //error: Float.times not a Callable<Float,Float,Float>

The problem is that `Float.times`, when considered as a function reference, 
is a higher-order function that accepts a 
[`Float`](#{site.urls.apidoc_current}/class_Float.html) 
and returns a function that accepts a `Float`, not a first-order function 
that accepts two `Float`s.

So how can we transform the method reference `Float.times` into an "uncurried" 
function with a single parameter list?

Well, one really simple way would be to fall back to writing:

    Float product(Float x, Float y) {
        return x.times(y);   //or even: x*y
    }

But there's another way. Instead, we're going to use a really cool higher-order 
function that will be part of the Ceylon language module. It's just two lines 
of code, so I'm sure you'll immediately understand it:

    R uncurry<R,T,P...>(R curried(T t)(P... p))(T receiver, P... args) {
        return curried(receiver)(args);
    }

Whoah! What's *that*?

Well, let's try to unwind this:

* First, it's a function with two parameter lists, so `uncurry()()` is a 
  function that returns a function.
* The first parameter list contains a single argument which also has two 
  parameter lists, so the argument `curried()()` is also a function that 
  returns a function.
* `curried()()` has an argument of form `P...`, a sequenced type parameter, 
  so we know that `curried()()` is somehow abstracted over functions with 
  arbitrary lists of parameters.
* The second parameter list contains two arguments, of the same types as the 
  parameters of the individual arguments of the parameter lists of 
  `curried()()`. These are the parameters of the function returned by 
  `uncurry()()`.

So what `uncurry()()` is doing is taking a function in curried form, where the 
second parameter list can have an arbitrary number of parameters, and 
producing a different function with just one parameter list, including all the 
original parameters of the argument function. It's "flattening" the parameter 
lists of `curried()()` into a single list of parameters. So we can write the 
following:

    Float product(Float x, Float y) = uncurry(Float.times);

Other kinds of operations on functions can be represented in a similar way. Consider:

    R curry<R,T,P...>(R uncurried(T t, P... p))(T receiver)(P... args) {
        return uncurried(receiver,args);
    }

This function does precisely the opposite of `uncurry()()`, it takes the 
first parameter of an argument function, and separates it out into its own 
parameter list, allowing the argument function to be partially applied:

    Float times(Float x)(Float y) = curry(product);
    Float double(Float y) = times(2.0);

Now consider:

    R compose<R,S,P...>(R f (S s), S g(P... p))(P... args) {
        return f(g(args));
    }

This function composes two functions:

    Float incrementThenDouble(Float x) = compose(2.0.times,1.0.plus);

Fortunately, you won't need to be writing functions like 
`curry()()`, `uncurry()()` and `compose()()` yourself. They're general 
purpose tools that are packaged as part of the 
[`ceylon.language`](#{site.urls.apidoc_current}/)
module. Nevertheless, it's nice to know that machinery like this is 
expressible within the type system of Ceylon. 
-->

## There's more...

You'll find a more detailed discussion of how Ceylon represents function 
types using tupes [here](/blog/2013/01/21/abstracting-over-functions/),
including an in-depth discussion of `compose()` and `curry()`.

Now we're  going to talk about Ceylon's syntax for [named argument 
lists](../named-arguments) and for defining user interfaces and 
structured data. 

