---
layout: tour
title: Tour of Ceylon&#58; Functions
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the tenth part of the Tour of Ceylon. In the 
[previous leg](../modules) we looked at modules. This leg covers
first class and higher-order functions.


## First class and higher order functions

Ceylon isn't a functional language: it has variable attributes and so methods 
can have *side effects*. But Ceylon does let you use functions as values, 
which in some people's eyes makes the language a kind of hybrid. 
There's actually nothing at all new about having functions-as-values in an 
object oriented language — for example, Smalltalk, one of the first and 
still one of the cleanest object oriented languages, was built around this 
idea. (To some people, true "functional" programming is more about what 
you can't do — mutate values — than what you can do.) Anyway, Ceylon, like 
Smalltalk and a number of other object oriented languages, lets you treat a 
function as an object and pass it around the system.

In this installment, we're going to discuss Ceylon's support for first class 
and higher order functions. "First class" function support means the ability 
to treat a function as a value. A "higher order" function is a function that 
accepts other functions as arguments, or returns another function. It's clear 
that these two ideas go hand-in-hand, so the term 'higher order 
function support' will be used from now on.

## Representing the type of a function

Ceylon is a (very) statically typed language. So if we're going to treat a 
function as a value, the very first question that arises is: What is the 
type of the function? We need a way to encode the return type and parameter 
types of a function into the type system. Remember that Ceylon doesn't have 
"primitive" types. A strong design principle is that every type should be 
representable within the type system as a class or interface declaration.

In Ceylon, a single type `Callable` abstracts *all* functions. It's 
declaration is the following:

<!-- check:none -->
    shared interface Callable<out Result, Argument...> {}

The syntax `P...` is called a *sequenced type parameter*. By analogy with a 
sequenced parameter, which accepts zero or more values as arguments, 
a sequenced type parameter accepts zero or more types as arguments. The type 
parameter `Result` represents the return type of the function. The sequenced 
type parameter `Argument...` represents the parameter types of the function.

So the type of sum in Ceylon is:

<!-- check:none -->
    Callable<Integer, Integer, Integer>

What about `void` functions? Well, remember that way back in 
[the first part of the tour](../basics) we said 
that the return type of a void function is `Void`. So the type of a function 
like `print()` is:

<!-- check:none -->
    Callable<Void,String>


## Representing the type of a method

Here we've been discussing first class functions. But in Ceylon all named 
declarations are "first class". That is to say, they all have a reified 
metamodel representable within the type system. For example, we could represent 
the type of a method like this:

<!-- check:none -->
    shared interface Method<out Result, in Instance, Argument...>
        satisfies Callable<Callable<Result,Argument...>, Instance> {}

Where `Instance` is the type that declares the method. So the type of the 
method` iterator()` of `Iterable<String>` would be:

<!-- check:none -->
    Method<Iterator<String>, Iterable<String>>

And the type of the method `compare()` of `Comparable<Integer>` would be:

<!-- check:none -->
    Method<Comparison,Comparable<Integer>,Integer>

Notice that we've declared a method to be a function that accepts a 
receiver object and returns a function. As a consequence of this, an 
alternative method invocation protocol is the following:

<!-- check:none:direct invocation of Callable objects not yet supported -->
<!-- cat: 
    void m() {
    String[] strings = {};
    Integer num = 0; -->
    Iterable<String>.iterator(strings)();
    Comparable<Integer>.compare(0)(num);
<!-- cat: } -->

Don't worry if you can't make sense of that right now. A few details 
are being glossed over here, that's not quite *exactly* how Method is 
defined. But we'll come back to this in a future installment. Let's get back 
to the current topic.


## Defining higher order functions

We now have enough machinery to be able to write higher order functions. 
For example, we could create a `repeat()` function that repeatedly executes a 
function.

<!-- check:none:BROKEN -->
    void repeat(Integer times, Callable<Void,Integer> perform) {
        for (i in 1..times) {
            perform(i);
        }
    }

    void printNum(Integer n) { print(n); }
    repeat(10, printNum);

Which would print the numbers 1 to 10 to the console.

There's one problem with this. In Ceylon, as we'll see later, we often call 
functions using named arguments, but the Callable type does not encode the 
names of the function parameters. So Ceylon has an alternative, more elegant, 
syntax for declaring a parameter of type `Callable`:

<!-- id:repeat -->
    void repeat(Integer times, void perform(Integer n)) {
        for (i in 1..times) {
            perform(i);
        }
    }

Many people find this version also slightly more readable and more regular. 
This is the preferred syntax for defining higher-order functions.


## Function references

When a name of a function appears without any arguments, like `printNum` does 
above, it's called a *function reference*. A function reference is the 
thing that really has the type `Callable`. In this case, `printNum` has the type 
`Callable<Void,Integer>`.

Now, remember how we said that `Void` is both the return type of a 
void method, and also the logical root of the type hierarchy? Well that's 
useful here, since it means that we can assign a function with a non-`Void` 
return type to any parameter which expects a void method:

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

<!-- cat-id:repeat -->
<!-- cat-id:attemptPrint -->
<!-- cat: void m() { -->
    repeat(10, attemptPrint);
<!-- cat: } -->


Another way we can produce a function reference is by partially applying a 
method to a receiver expression. For example, we could write the following:

<!-- id:Hello -->
    class Hello(String name) {
        shared void say(Integer n) {
            print("Hello, " name ", for the " n "th time!");
        }
    }

And call it like this:

<!-- cat-id:repeat -->
<!-- cat-id:Hello -->
<!-- cat: void m() { -->
    repeat(10, Hello("Gavin").say);
<!-- cat: } -->

Here the expression `Hello("Gavin").say` has the same type as `print` above. 
It is a `Callable<Void,Integer>`.


## More about higher-order functions

Let's see a more practical example, which mixes both ways of representing a 
function type. Suppose we have some kind of user interface component which 
can be observed by other objects in the system. We could use something like 
Java's `Observer`/`Observable` pattern:

<!-- check:parse:Requires OpenList -->
<!-- cat: shared class Event() { } -->
    shared interface Observer {
        shared formal void observe(Event event);
    }
    shared abstract class Component() {
         
        OpenList<Observer> observers = OpenList<Observer>();
         
        shared void addObserver(Observer o) {
            observers.append(o);
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

<!-- check:parse:Requires OpenList -->
    shared abstract class Component() {
         
        OpenList<Callable<Void,Event>> observers = OpenList<Callable<Void,Event>>();
         
        shared void addObserver(void observe(Event event)) {
            observers.append(observe);
        }
         
        shared void fire(Event event) {
            for (void observe(Event event) in observers) {
                observe(event);
            }
        }
    }

Here we see the difference between the two ways of specifying a function type:

* `void observe(Event event)` is more readable in parameter lists, where 
  observe is the name of the parameter, but
* `Callable<Void,Event>` is useful as a generic type argument.

Now, any event observer can just pass a reference to one of its own methods to 
`addObserver()`:

<!-- check:parse:Depends on Component, above, which requires OpenList -->
    shared class Listener(Component component) {
     
        void onEvent(Event e) {
            // respond to the event
            // ...
        }
         
        component.addObserver(onEvent);
         
        ...
     
    }

When the name of a method appears in an expression without a list of 
arguments after it, it is a reference to the method, not an invocation of the 
method. Here, the expression `onEvent` is an expression of type 
`Callable<Void,Event>` that refers to the method `onEvent()`.

If `onEvent()` were `shared`, we could even wire together the `Component` and 
`Listener` from some other code, to eliminate the dependency of `Listener` 
on `Component`:

<!-- check:parse:Depends on Component, above, which requires OpenList -->
    shared class Listener() {
     
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

It's also possible to declare a method that returns a function. A method that 
returns a function has multiple parameter lists. Let's consider adding the 
ability to remove observers from a `Component`. We could use a `Subscription` 
interface:

<!-- check:parse:Depends on OpenList -->
    shared interface Subscription {
        shared void cancel();
    }
    shared abstract class Component() {
         
        // ...
         
        shared Subscription addObserver(void observe(Event event)) {
            observers.append(observe);
            object subscription satisfies Subscription {
                shared actual void cancel() {
                    observers.remove(observe);
                }
            }
            return subscription;
        }
         
        // ...
     
    }

But a simpler solution might be to just eliminate the interface and return the 
`cancel()` method directly:

<!-- check:parse:Depends on OpenList -->
    shared abstract class Component() {
         
        // ...
         
        shared void addObserver(void observe(Event event))() {
            observers.append(observe);
            void cancel() {
                observers.remove(observe);
            }
            return cancel;
        }
         
        // ...
     
    }

Note the second parameter list of `addObserver()`.

Here, we define a method `cancel()` inside the body of the `addObserver()` 
method, and return a reference to the inner method from the outer method. The 
inner method `cancel()` can't be called directly from outside the body of the 
`addObserver()` method, since it is a block local declaration. But the 
reference to `cancel()` returned by `addObserver()` can be called by any 
code that obtains the reference.

In case you're wondering, the type of the method `addObserver()` is 
`Callable<Callable<Void>,Component,Callable<Void,Event>>`.

Notice that `cancel()` is able to use the parameter `observe` of 
`addObserver()`. We say that the inner method receives a *closure* of the 
non-`variable` locals and parameters of the outer method — just like a method 
of a class receives a closure of the class initialization parameters and 
locals of the class initializer. In general, any inner class, method, or 
attribute declaration always receives the closure of the members of the class, 
method, or attribute declaration in which it is enclosed. This is an example of 
how regular the language is.

We could invoke our method like this:

<!-- check:none -->
    addObserver(onEvent)();

But if we were planning to use the method in this way, there would be no good 
reason for giving it two parameter lists. It's much more likely that we're 
planning to store or pass the reference to the inner method somewhere before 
invoking it.

<!-- check:none -->
    void cancel() = addObserver(onEvent);
    // ...
    cancel();

The first line demonstrates how a method can be defined using a `=` 
specification statement, just like a simple attribute definition. The 
second line of code simply invokes the returned reference to `cancel()`.

We've already seen how an attribute can be defined using a block of code. 
Now we see that a method can be defined using a specifier. So, if you like, 
you can start thinking of a method as an attribute of type `Callable` — an 
attribute with parameters. Or if you prefer, you can think of an attribute as 
member with zero parameter lists, and of a method as a member with one or more 
parameter lists. Either kind of member can be defined by reference, using `=`, 
or directly, by specifying a block of code to be executed.

Cool, huh? That's more regularity.


## Anonymous Functions

As you've probably noticed, all the functions we've defined so far have been 
declared with a name, using a traditional C-like syntax. Ceylon will also
feature *anonymous functions* (sometimes called "lambdas"). The syntax for 
this is not yet finalized. 

We've already discussed Ceylon's support for defining higher order functions, 
in particular the two different ways to represent the type of a parameter 
which accepts a reference to a function. The following declarations are 
essentially equivalent:

<!-- check:none -->
    X[] filter<X>(X[] sequence, Callable<Boolean,X> by) { ... }
    X[] filter<X>(X[] sequence, Boolean by(X x)) { ... }

We've even seen how we can pass a reference to a method to such a higher-order 
function:

<!-- check:parse:Requires filter -->
    Boolean stringNonempty(String string) {
        return !string.empty;
    }
    String[] nonemptyStrings = filter(strings, stringNonempty);

Of course, some of the convenience of general-purpose higher order functions 
like `filter()` is lost if we have to declare a whole method every time we 
want to use the higher order function. Indeed, much of the appeal of higher 
order functions is the ability to eliminate verbosity by having more 
specialized versions of traditional control structures like `for`.

Most languages with higher order functions support anonymous functions, where 
a function may be defined inline as part of the expression. My favored syntax 
for this in a C-like language would be the following:

<!-- check:none:Requires anonymous functions -->
    function (String string) { return !string.empty; }

This is an ordinary method declaration with the name eliminated. Then we could 
call `filter()` as follows:

<!-- check:parse:Requires filter -->
    String[] nonemptyStrings = filter( strings, function (String string) { return !string.empty; } );

Since it's extremely common for anonymous functions to consist of a single 
expression, and since the `function` keyword is a little noisy, I favor 
allowing the following abbreviation:

<!-- check:none:Requires anonymous functions -->
    (String string) !string.empty

The expression is understood to be the return value of the method. Then the 
invocation of `filter()` is a bit less noisy:

<!-- check:none:Requires anonymous functions -->
    String[] nonemptyStrings = filter(strings, (String string) !string.empty);

This works, and we could support this syntax in the Ceylon language.

Let's look at some more examples of how we would use anonymous functions:

* Assertion:

<!-- check:none:Requires anonymous functions -->
        assert ("x must be positive", () x>0.0)
    
* Conditionals:
     
<!-- check:none:Requires anonymous functions -->
        when (x>100.0, () 100.0, () x)
* Repetition:
     
<!-- check:none:Requires anonymous functions -->
        repeat(n, () { print("Hello"); })
    
* Tabulation:
     
<!-- check:none:Requires anonymous functions -->
        tabulateList(20, (Integer i) i**3)
    
* Comprehension:
     
<!-- check:none:Requires anonymous functions -->
        from (people, (Person p) p.name, (Person p) p.age>18)
    
* Quantification:
     
<!-- check:none:Requires anonymous functions -->
        forAll (people, (Person p) p.age>18)
    
* Accumulation (folds):
     
<!-- check:none:Requires anonymous functions -->
        accumulate (items, 0.0, (Float sum, Item item) sum+item.quantity*item.product.price)


<!--
The problem is that I don't find these code snippets especially readable. 
Too much nested punctuation. They certainly fall short of the readability of 
built-in control structures like `for` and `if`. And the problem gets 
worse for multi-line anonymous functions. Consider:

    repeat (n, () {
        String greeting;
        if (exists name) {
            greeting = "Hello, " name "!";
        }
        else {
            greeting = "Hello, World!";
        }
        print(greeting);
    });

Definitely much uglier than a for loop!

One language where anonymous functions really work is Smalltalk - to the 
extent that Smalltalk doesn't need *any* built-in control structures at all. 
What is unique about Smalltalk is its funny method invocation protocol.
Method arguments are listed positionally, like in C or Java, but they must be 
preceded by the parameter name, and aren't delimited by parentheses. Let's 
transliterate this idea to Ceylon.

    String[] nonemptyStrings = filter(strings) by (String string) (!string.empty);

Note that we have not changed the syntax of the anonymous function here, we've 
just moved it outside the parentheses. If we were to adopt this syntax, we 
could make empty parameter lists optional, without introducing any syntactic 
ambiguity, allowing the following:

    repeat (n)
    perform {
        String greeting;
        if (exists name) {
            greeting = "Hello, " name "!";
        }
        else {
            greeting = "Hello, World!";
        }
        print(greeting);
    };

This looks much more like a built-in control structure. Now let's see some of 
our other examples:

* Assertion: 

      assert ("x must be positive") that (x>0.0)

* Conditionals: 

      when (x>100.0) then (100.0) otherwise (x)

* Repetition: 

      repeat(n) perform { print("Hello"); }

* Tabulation: 

      tabulateList(20) containing (Integer i) (i**3)

* Comprehension: 

      from (people) select (Person p) (p.name) where (Person p) (p.age>18)

* Quantification: 

      forAll (people) every (Person p) (p.age>18)

* Accumulation (folds): 

      accumulate (items, 0.0) using (Float sum, Item item) (sum+item.quantity*item.product.price)

Well, I'm not sure about you, but I find all these examples more readable 
than what we had before. In fact, I like them so much better, that it makes 
me not want to support the more traditional "lambda expression" style.

On the other hand, this syntax is pretty "exotic", and I'm sure lots of people 
will find it difficult to read at first.

Now, in theory, there's no reason why we can't support both variations, except 
that we've worked really hard to create a language with a consistent style, 
where there is usually one obvious way to write something (obviously the 
choice between named and positional arguments is a big exception to this, but 
we have Good Reasons in that case). The trouble is that supporting many 
"harmless" syntactic variations has the potential to make a language overall 
harder to read, and results in annoying things like:

* coding standards
* arguments over coding standards
* shitty tooling to enforce coding standards
* arguments over which shitty tooling to use to enforce coding standards
* empowerment of people who are more interesting in arguing over coding 
  standards and shitty tools that enforce coding standards over people who 
  want to get work done

So this is definitely an issue we need lots of feedback on. Should we support:

* traditional anonymous functions?
* anonymous functions only as Smalltalk-style arguments?
* both?

The answer just isn't crystal clear to us.
-->


## Curry, uncurry and function composition

A method reference like `Float.times` is represented in "curried" form in 
Ceylon. I can write:

    Float twoTimes(Float x) = 2.0.times;

Here, the expression `2.times` is a typical first-class function reference 
produced by the partial application of the method `times()` to the 
receiver expression `2.0`.

But I can also write:

<!-- check:parse:Requires multiple parameter lists -->
    Float times(Float x)(Float y) = Float.times;

Actually, the expression `Float.times` is really a metamodel reference to a 
method declaration. The type `Method<Float,Float,Float>` is a subtype of 
`Callable<Callable<Float,Float>,Float>`, so we can treat it as a 
function reference.

Therefore, an alternative definition of `twoTimes()` is:

<!-- check:parse:???-->
    Float twoTimes(Float x) = Float.times(2);

(We're partially applying `Float.times` by supplying one of its two 
argument lists.)

Unfortunately, the following isn't correctly typed:

<!-- check:none:Demoing error -->
    Float product(Float x, Float y) = Float.times;  //error: Float.times not a Callable<Float,Float,Float>

The problem is that `Float.times`, when considered as a function reference, 
is a higher-order function that accepts a `Float` and returns a function that 
accepts a `Float`, not a first-order function that accepts two `Float`s.

So how can we transform the method reference `Float.times` into an "uncurried" 
function with a single parameter list?

Well, one really simple way would be to fall back to writing:

    Float product(Float x, Float y) {
        return x.times(y);   //or even: x*y
    }

But there's another way. Instead, we're going to use a really cool higher-order 
function that will be part of the Ceylon language module. It's just two lines 
of code, so I'm sure you'll immediately understand it:

<!-- check:none:Not supported yet -->
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

<!-- check:none:Requires uncurry -->
    Float product(Float x, Float y) = uncurry(Float.times);

Other kinds of operations on functions can be represented in a similar way. Consider:

<!-- check:none:Requires uncurry -->
    R curry<R,T,P...>(R uncurried(T t, P... p))(T receiver)(P... args) {
        return uncurried(receiver,args);
    }

This function does precisely the opposite of `uncurry()()`, it takes the 
first parameter of an argument function, and separates it out into its own 
parameter list, allowing the argument function to be partially applied:

<!-- check:none:Requires curry -->
    Float times(Float x)(Float y) = curry(product);
    Float double(Float y) = times(2.0);

Now consider:

<!-- check:none:Required MPL -->
    R compose<R,S,P...>(R f (S s), S g(P... p))(P... args) {
        return f(g(args));
    }

This function composes two functions:

<!-- check:none:Requires compose -->
    Float incrementThenDouble(Float x) = compose(2.0.times,1.0.plus);

Fortunately, you won't need to be writing functions like 
`curry()()`, `uncurry()()` and `compose()()` yourself. They're general 
purpose tools that are packaged as part of the `ceylon.language` module. 
Nevertheless, it's nice to know that machinery like this is expressible 
within the type system of Ceylon. 


## There's more...

Now we're  going to talk about Ceylon's syntax for [named
argument lists](../named-arguments) and for defining user interfaces and 
structured data. 

