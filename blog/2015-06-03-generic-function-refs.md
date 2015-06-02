---
title: Programming with type functions in Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

I've recently been working on some experimental new features
of Ceylon's already extremely powerful type system. What I'm
going to explain in this post is known, technically, as:

- **higher order generic types** (or _type constructor 
  polymorphism_, or _higher kinds_), and
- **higher rank generic types** (or _rank-N polymoprhism_).

Please don't worry about this jargon salad. (And please don't
try to google any of those terms, because the explanations
you'll find will only make these pretty straightforward
notions seem confusing.) Stick with me, and I'll do my best 
to explain the concepts in intuitive terms, without needing 
any of the above terminology.

But first, let's start with pair of examples that illustrate
a motivating problem. 

This function simply returns its argument:

<!-- try: -->
    Object pipeObject(Object something) => something;

This function adds `Float`s:

<!-- try: -->
    Float addFloats(Float x, Float y) => x+y;

Modern programming language let us treat either of these 
functions as a value and pass it around the system. For 
example, I can write:

<!-- try: -->
    Object(Object) pipeObjectFun = pipeObject;

Or:

<!-- try: -->
    Float(Float,Float) addFloatsFun = addFloats;

Where `Object(Object)` and `Float(Float,Float)` represent 
the _types_ of the functions, and `pipeObject` and 
`addFloats` are a _references_ to the functions. So far so 
good.

But sometimes it's useful to have a function that abstracts 
away from the concrete data type using generics. We 
introduce a type variable, to represent the "unknown" type 
of thing we're dealing with:

<!-- try: -->
    Any pipe<Any>(Any anything) => anything;

And:

<!-- try: -->
    Number add<Number>(Number x, Number y)
                given Number satisfies Summable<Number>
            => x+y;

Sometimes, as in `add()`, the unknown type is constrained
in some way. We express this using a type constraint:

<!-- try: -->
    given Number satisfies Summable<Number>

This is Ceylon's way of denoting that `Number` may only be a 
type which is a subtype of the upper bound `Summable<Number>`, 
i.e. that it is a type to which we can apply the addition
operator `+`.

Now, what if I want to pass around a reference to this 
function. Well, one thing I can typically do is nail down
the unknown type to a concrete value:

<!-- try: -->
    Object pipeObjectFun = pipe<Object>;

Or:

<!-- try: -->
    Float(Float,Float) addFloatsFun = add<Float>;

But that's a bit disappointing&mdash;we've lost the fact
that `add()` was generic. Now, in object-oriented languages
it's possible to define the generic function as a member of
a class, and pass an instance of the class around the system. 
This is called the _strategy pattern_. But it's inconvenient
to have to write a whole class just to encapsulate a function 
reference.

It would be nicer to be able to write:
    
<!-- try: -->
    TypeOfPipe pipeFun = pipe;

And:

<!-- try: -->
    TypeOfAdd addFun = add; 

Where `TypeOfPipe` and `TypeOfAdd` are the types of the 
generic functions. The problem is that there's no way to 
represent these types within the type system of most 
languages. Let's see how we can do that in Ceylon 1.2.

### Introducing type functions

I promised to avoid jargon, and avoid jargon I will. The 
only bit of terminology we'll need is the idea of a _type 
function_. A type function, as its name implies, is a 
function that accepts zero or more types, and produces a
type. Type functions might seem exotic and abstract at 
first, but there's one thing that will help you understand 
them:

> You already know almost everything you need to know about
> type functions, because almost everything you know about
> ordinary (value) functions is also true of type functions. 

If you stay grounded in the analogy to ordinary functions,
you'll have no problems with the rest of this post, I
_promise_.

So, we all know what an ordinary function looks like:

<!-- try: -->
    Float addFloats(Float x, Float y) => x+y;

Let's break that down, we have:

- the function name, and list of parameters, to the left
  of a fat arrow, and
- an expression on the right of the fat arrow.

A type function doesn't look very different. It has a name
and (type) parameters on the left of a fat arrow, and a 
(type) expression on the right. It looks like this:

<!-- try: -->
    alias Pair<Value> => [Value,Value];

Aha! This is something we've already seen! So a type 
function is nothing more than a generic type alias! This 
particular type function accepts a type, and produces a 
tuple type, a pair, whose elements are of the given type.

Actually not every type function is a type alias. A generic
class or interface is a type function. For example:

<!-- try: -->
    interface List<Element> { ... }

This interface declaration accepts a type `Element`, and
produces a type `List<Element>`, so it's a type function.

I can call a function by providing values as arguments:

<!-- try: -->
    pipe("hello")
    add(1.0, 2.0)

These expressions produce the values `"hello"` and `3.0`.

I can _apply_ a type function by providing types as 
arguments:

<!-- try: -->
    Pair<Float>
    
This _type_ expression produces the _type_ `[Float,Float]`, 
by applying the type function `Pair` to the type argument 
`Float`. 

Similarly, I can apply the type function `List`:

<!-- try: -->
    List<String>

This type expression just literally produces the type
`List<String>`, by applying the type function `List` to
the type argument `String`.

On the other hand, I can take a reference to a value
function by just writing its name, without any arguments,
for example, `pipe`, or `add`. I can do the same with type
functions, writing `Pair` or `List`.

Back in the quotidian world of ordinary values, I can write 
down an _anonymous function_:

<!-- try: -->
    (Float x, Float y) => x+y

In the platonic world of types, I can do that too:

<!-- try: -->
    <Value> => [Value,Value]

Finally, an ordinary value function can constrain its 
arguments using a type annotation like `Float x`. A type
function can do the same thing, albeit with a more 
cumbersome syntax:

<!-- try: -->
    interface List<Element> 
            given Element satisfies Object 
    {
        //define the type list
        ...
    }

Even an anonymous type function may have constraints:

<!-- try: -->
    <Value> given Value satisfies Object 
            => [Value,Value]

**Jargon watch:** most people, including me, use the term 
_type constructor_ instead of "type function".

### Type functions are types

Now we're going to make a key conceptual leap. Recall that 
in modern languages, functions are treated as values. I can

1. take a function, and assign it to a variable, and then 
2. call that variable within the body of the function.

For example:

<!-- try: -->
    void secondOrder(Float(Float,Float) fun) {
        print(fun(1.0, 2.0));
    }
    
    //apply to a function reference
    secondOrder(addFloats);
    
    //apply to an anonymous function
    secondOrder((Float x, Float y) => x+y);

We call functions which accept functions _higher order
functions_.

Similarly, we're going to declare that _type functions are
types_. That is, I can:

1. take a type function and assign it to a type variable,
   and then
2. apply that type variable in the body of the declaration 
   it parameterizes.

For example:

<!-- try: -->
    interface SecondOrder<Box> given Box<Value> {
        shared formal Box<Float> createBox(Float float);
    }
    
    //apply to a generic type alias
    SecondOrder<Pair> something;
    
    //apply to a generic interface
    SecondOrder<List> somethingElse;
    
    //apply to an anonymous type function
    SecondOrder<<Value> => [Value,Value]> somethingScaryLookin;

The type constraint `given Box<Value>` indicates that the 
type variable `Box` accepts type functions with one type 
argument.

Now, there's one thing to take note of here. At this point,
the notion that type functions are types is a purely formal
statement. An axiom that defines what kinds of types I can 
write down and expect the typechecker of my programming
language to be able to reason about. I have 
not&mdash;yet&mdash;said that there are any actual _values_
of these types!

**Jargon watch:** the ability to treat a type function as a 
type is called _higher order generics_.
 
### The type of a generic function is a type function

Let's come back to our motivating examples:

<!-- try: -->
    Any pipe<Any>(Any anything) => anything;

    Number add<Number>(Number x, Number y)
                given Number satisfies Summable<Number>
            => x+y;

If you squint, you'll see that these are actually functions
with _two_ parameter lists. The first parameter lists are:

<!-- try: -->
    <Any>

And:

<!-- try: -->
    <Number> given Number satisfies Summable<Number>

Which both accept a type. The second parameter lists are:

<!-- try: -->
    (Any anything)
    
And:

<!-- try: -->
    (Number x, Number y)

Therefore, we can view each generic function as a function
that accepts a type and produces an ordinary value function. 
The resulting functions are of type `Any(Any)` and 
`Value(Value,Value)` respectively.

Thus, we could write down the type of our first generic 
function `pipe()` like this:

<!-- try: -->
    <Any> => Any(Any)

And the type of `add()` is:

<!-- try: -->
    <Number> given Number satisfies Summable<Number>
            => Number(Number,Number)

Phew. That looks a bit scary. But mainly because of the type 
constraint. Because generic function types like this are 
pretty verbose, we can assign them aliases:

<!-- try: -->
    alias AdditionLikeOperation
            => <Number> given Number satisfies Summable<Number>
                    => Number(Number,Number);

That was the hard part&mdash;we're almost done.

### References to generic functions

Now we can use these types as the types of references to
generic functions:

<!-- try: -->
    <Any> => Any(Any) pipeFun = pipe;
    
    AdditionLikeOperation addFun = add;

And we can apply these function references by providing type 
arguments:

<!-- try: -->
    String(String) pipeString = pipeFun<String>;
    Object(Object) pipeObject = pipeFun<Object>;
    
    Float(Float,Float) addFloats = addFun<Float>;
    Integer(Integer,Integer) addInts = addFun<Integer>;

Or, alternatively, we can just immediately apply the generic 
function references to _value_ arguments, and let Ceylon 
infer the type arguments, just as it usually does when you
call a function directly:

<!-- try: -->
    String hi = pipeFun("hello");
    Integer zero = pipeFun(0);
    
    Float three = addFun(1.0, 2.0);
    String helloWorld = addFun("Hello", "World");

And now we've solved the problem posed at the beginning!

Now for the kicker: the types `<Any> => Any(Any)` and
`AdditionLikeOperation` are both type functions. Indeed, the 
type of _any_ generic function is a type function of this 
general form:

<!-- try: -->
    <TypeParameters> => ReturnType(ParameterTypes)

Similarly, every type function of this general form is the
type of some generic function.

So we've now shown that some type functions are not only
types, they're the types of values&mdash;the values are
references to generic functions like `pipe` and
`add`.

**Jargon watch:** the ability to treat a generic function as 
a value is called _higher rank generics_.

### Abstraction over generic functions

Finally, we can use all this for something useful. Let's
consider a scanner library that is abstracted away from 
all of:

- the character type,
- the token type,
- the kind of container that tokens occur in. 

Then we might have a `scan()` function with this sort
of signature:

<!-- try: -->
    "Tokenize a stream of characters, producing
     a stream of tokens."
    Stream<Token> scan<Char,Token,Stream>
            (grammar, characterStream, newToken, newStream)
                given Stream<Element> satisfies {Element*} {
        
        //parameters:
        
        "The token grammar."
        Grammar grammar;
        
        "The character stream to tokenize."
        Stream<Char> characterStream;
        
        "Constructor for tokens, accepting a
         substream of characters."
        Token newToken(Stream<Char> chars);
        
        "Generic function to construct a stream
         of characters or tokens."
         Stream<Elem> newStream<Elem>({Elem*} elements);
        
        //implementation:
        
        Stream<Token> tokenStream;
        
        //do all the hard work
        ...
        
        return tokenStream;
    }

Here:

- `Char` is the unknown character type, 
- `Token` is the unknown token type,
- `Stream` is a type function representing an unknown 
  container type that can contain either characters or 
  tokens,
- `newToken` is a function that accepts a substream of 
  characters and creates a `Token`, 
- `characterStream` is a stream of characters, and, most 
  significantly, 
- `newStream` is a generic function that constructs streams
  of any element type, used internally to create streams of
  characters as well as tokens.

We could use this function like this:

<!-- try: -->
    //input a stream of characters
    {Character*} input = ... ; 
    
    //get back a stream of Strings
    {String*} tokens =
            scan<Character,String,Iterable>
                (input, String, <Elem>({Elem*} elems) => elems);

Or like this:

<!-- try: -->
    //define our own token type
    class BasicToken(LinkedList<Character> charList) {
        string => String(charList);
    }
    
    //input a linked list of characters
    LinkedList<Character> input = ... ;
    
    //get back a linked list of BasicTokens
    LinkedList<BasicToken> tokens =
            scan<Character,BasicToken,LinkedList>
                (input, BasicToken, LinkedList);
    
As you can see, our parsing algorithm is now almost 
completely abstracted away from the concrete types we want
to use!

### Compiling this code

In Ceylon 1.2, programming with type functions is an 
experimental feature that only works in conjunction with 
the JavaScript backend. So you can run code that uses type
functions on a JavaScript virtual machine, but not on the
JVM. This is something we're inviting you to play with to 
see if the whole community agrees it is useful. But right
now it's not covered in the language specification, and it's 
not supported by the Java backend.

The typechecker itself supports _extremely_ sophisticated 
reasoning about higher order and higher rank types. Type
functions are fully integrated with Ceylon's powerful
system of subtype polymorphism, including with union
and intersection types, and with type inference and type
argument inference. There's even limited support for type
function inference! And there's no arbitrary upper limits 
here; not only rank 2 but arbitrary rank types are supported.  
If there's enough interest, I'll cover that material in a 
future post.
