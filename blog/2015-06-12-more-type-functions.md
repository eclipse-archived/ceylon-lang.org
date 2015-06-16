---
title: A little more about type functions
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

My previous post about 
[type functions](2015/06/03/generic-function-refs)
generated some interesting discussion, here, and 
[on reddit](http://www.reddit.com/r/programming/comments/38hsrb/programming_with_type_functions_in_ceylon/).

Therefore, I think it's worth tying up several loose ends
from the earlier post. So here's a collection of further 
observations about type functions.

_Warning: this post addresses some very technical details of
how we've incorporated type functions into Ceylon's type 
system. Don't even bother continuing any further until 
you've read the [earlier post](2015/06/03/generic-function-refs)._

### The "why" of this

The most well-known application of higher-order generics is
for representing high-levels abstractions of container types:
functors, monads, and friends. That's not what motivated me
to experiment with higher-order generics in Ceylon, and as a
practical matter I still have little interest in these 
abstractions, though they're fun to play with.

No, what bothered me was not that Ceylon's type system 
wasn't powerful enough to represent `Functor` or `Monad`, 
but rather that Ceylon's type system _wasn't powerful enough
to represent Ceylon_. I'll show you what I mean by that in
just a second. But first I want to argue that type functions
can be seen as a regularization of the language. 

From a _purely syntactic_ point of view, it's always seemed 
a little strange that every sort of type declaration in 
Ceylon can have a list of type parameters, _except for a 
type parameter itself_. Furthermore, it's noticeable that I 
can take a reference, or meta reference to any program 
element _unless it has a list of type parameters_. Now, such 
restrictions might seem reasonable if a parameterized type 
parameter or a reference to a generic declaration were not
meaningful notions at a fundamental level. But they clearly
_are_ meaningful, and even at least _somewhat_ useful.

Exactly _how_ useful is a different question&mdash;the 
jury's still out, at least in my mind. And so perhaps we'll 
ultimately conclude that this stuff isn't worth its weight.
The weight being, substantially, the time it takes for 
programmers new to Ceylon to understand this stuff.

In the original post, I showed how type functions were 
necessary to represent the type of a reference to a generic 
function. One place where this problem arises is with one of 
Ceylon's more unique features: its _typesafe metamodel_. 

### A use case for generic function reference types 

Usually, I can obtain a metamodel object that represents a 
class or function and captures its type signature. For 
example, the expression `` `String` `` evaluates to a 
metamodel object that captures the type and initializer
parameters of the class `String`:

<!-- try: -->
    Class<String,[{Character*}]> stringClass = `String`;

For a generic declaration, I can do a similar thing, as long 
as I'm prepared to nail down the type arguments. For example, 
I can write `` `Singleton<String>` `` to get a metamodel
object representing the class `Singleton` after applying the
type argument `String`: 

<!-- try: -->
    Class<Singleton<String>,[String]> stringSingletonClass
            = `Singleton<String>`

But in Ceylon as it exists today, I can't obtain a typed 
metamodel object that represents just `` `Singleton` ``, 
because to represent the type of that metamodel object I 
would necessarily need a type function.

Now, with the new experimental support for type functions, 
the type of the expression `` `Singleton` `` could be
`<T> => Class<Singleton<T>,[T]>()`, allowing code like this:

<!-- try: -->
    value singletonGenericClass = `Singleton`;
    ...
    Class<Singleton<String>,[String]> stringSingletonClass 
            = singletonGenericClass<String>();

That's just one example of how allowing references to 
generic functions makes Ceylon feel more "complete".

### Two use cases for anonymous type functions

I get the impression that the "scariest" bit of what I've
presented in the previous post is the notation for anonymous
type functions. That is, the following syntax:

<!-- try: -->
    <X> => X
    <X> => [X,X,X]
    <X,Y> => X|Y
    <T> given T satisfies Object => Category<T>(T*)

But I'm convinced that this notation is not really that
hard to understand. The reason I assert this is because if
I give each of these type functions a name, then most of
you guys have no problem understanding them:

<!-- try: -->
    alias Identity<X> => X;
    alias Triple<X> => [X,X,X];
    alias Union<X,Y> => X|Y;
    alias CategoryCreator<T> given T satisfies Object => Category<T>(T*);

_But_&mdash;one might reasonably enquire&mdash;_why do we 
even need them, if the named versions are easier to read_?

Well, we need them:

1. in order to be able to denote the type of a reference to
   a generic function&mdash;remember, we don't have 
   undenotable types in Ceylon&mdash;and
2. to make it easy to "curry" a named type function like 
   `Map`.

For example, we want to be able to write stuff like
`<T> => Map<String,T>` when working with higher-order 
generics, thus turning a type function of two type 
parameters into a type function of one type parameter.

### Are type functions "type types"?

One thing I should have made very clear, and forgot, is that
type functions don't represent an additional meta level. In
Ceylon's type system, type functions are types, in the very
same sense that function are values in Ceylon and other 
modern languages.

There simply is no additional meta-type system for types in 
Ceylon. The closest thing we have to a "type type" is a 
generic type constraint, but that's an extremely 
impoverished sort of type type, since Ceylon provides no 
facilities at all to abstract over type constraints&mdash;I 
can't even assign an alias to a type constraint and reuse it 
by name.

Ceylon reasons about type constraints and assignability of
types to type variables using hardcoded rules written
primitively into the language spec and type checker, not by 
abstraction over the types of types. 

### Type functions and subtyping

But if a type function is a type, what are its subtyping
relationships with other types and other type functions?

Well, first, recall that some type functions have instances: 
generic function references. We didn't want to introduce 
values into the language that aren't `Object`s, so we've 
declared that every type function is a subtype of `Object`. 
This preserves the useful property that our type system has 
a single root type `Anything`. 

Next, recall that an ordinary function type is _covariant_
in its return type, and _contravariant_ in its parameter 
types. For example, the function type:

<!-- try: -->
    String(Object, Object)

is a subtype of:

<!-- try: -->
    Object(String, String)

Since if a function accepts two `Object`s and returns a 
`String`, then it's clearly also a function that accepts two 
`String`s and returns an `Object`.

Given two function types with one parameter:

<!-- try: -->
    F(P)
    G(Q)

Then `F(P)` is a subtype of `G(Q)` iff `P` is a supertype of
`Q` and `F` is a subtype of `G`.

Similar rules apply to type functions. Consider two type 
functions of one type parameter:

<!-- try: -->
    alias A<X> given X satisfies U => F<X>
    alias B<Y> given Y satisfies V => G<Y>

Then `A` is a subtype of `B` iff:

- the upper bound `U` on `X` is a supertype of the upper 
  bound `V` on `Y`, and
- for any type `T`, `F<T>` is a subtype of `G<T>`.

That is to say, if `A<X>` accepts every type argument `T` 
that `B<Y>` accepts, and for each such `T`, the applied type
`A<T>` is a subtype of the applied type `B<T>`, then we can 
soundly replace `B` with `A` in well-typed code.

(Of course, these rules generalize to type functions with
multiple type parameters.) 

### Generic function types and subtyping

Now let's narrow our attention to consider only type 
functions that represent the types of generic functions. 
To make it easier, we'll consider generic functions of the 
following form, with just one type parameter and just one 
value parameter:

<!-- try: -->

    F<X> f<X>(P<X> p) given X satisfies U => ... ;

Here, `F<X>` is the return type, a type expression involving
the type parameter `X`, and `P<X>` is the parameter type,
which also involves `X`.

The type of this generic function&mdash;as we 
[saw](/blog/2015/06/03/generic-function-refs/#the_type_of_a_generic_function_is_a_type_function) 
in the previous post&mdash; is the type function:

<!-- try: -->
    <X> given X satisfies U => F<X>(P<X>)

So let's consider two type functions of the general form
we're considering:

<!-- try: -->
    alias A<X> given X satisfies U => F<X>(P<X>)
    alias B<Y> given Y satisfies V => G<Y>(Q<Y>)

Then we see quickly that `A` is a subtype of `B` iff:

- the upper bound `U` on `X` is a supertype of the upper 
  bound `V` on `Y`, and
- for any type `T`, the return type `F<T>` of `A` is a 
  subtype of the return type `G<T>` of `B`, and the 
  parameter type `P<T>` of `A` is a supertype of the
  parameter type `Q<T>` of `B`.

For example, this generic function type:

<!-- try: -->
    <X> => X&Object(X|Object)

is a subtype of this generic function type:

<!-- try: -->
    <X> given X satisfies Object => X(X)

Take a minute to convince yourself that this is correct
intuitively.

(Again, these rules generalize naturally to functions with
multiple type parameters and/or multiple value parameters.) 

### Type functions and type inference

When we call a first-order generic function in Ceylon, we 
don't usually need to explicitly specify type arguments. 
Instead, we can usually infer them from the value arguments 
of the invocation expression. For example, if we have this 
generic function:

<!-- try: -->
    List<Out> map<In,Out>(Out(In) fun, List<In> list) => ... ;

Then we can always safely infer `In` and `Out`, because 
there's a unique most-precise choice of type arguments:

<!-- try: -->
    value list = map(Integer.string, ArrayList { 10, 20, 30 });

In this example, we can safely infer that `In` is `Integer`,
and `Out` is `String`, without any loss of precision.

Unfortunately, once higher-order generics come into play,
inference of type functions is a much more ambiguous problem.
Consider this second-order generic function, which abstracts
the `map()` function away from the container type:

<!-- try: -->
    Box<Out> fmap<Box,In,Out>(Out(In) fun, Box<In> box) 
            given Box<Element> { ... }

And now consider the following invocation of this function:

<!-- try: -->
    fmap(Integer.string, ArrayList { 10, 20, 30 })

What type should we infer for `Element`, and what type 
function for `Box`? 

- `Integer` and `List`?
- `Integer` and `Iterable`? 
- `Integer` and `ArrayList`?
- `Integer` and `MutableList`?
- `Integer` and `ListMutator`?
- `Integer` and `Collection`? 
- `Object` and `Category`? 

In general, there might be several different reasonable 
choices, and no really good criteria for choosing between 
them. So in this case, we require that the type arguments be 
specified explicitly:

<!-- try: -->
    fmap<List,Integer,String>(Integer.string, ArrayList { 10, 20, 30 })

However, there is a pattern we can use to make type function
inference possible. In this case, we could define the 
following interface:

<!-- try: -->
    interface Functor<Box,Element> given Box<Value> { ... }

Now let's imagine that our `ArrayList` class inherits 
`Functor`, so that any `ArrayList<Element>` is a 
`Functor<List,Element>`.

And let's redefine `fmap()` like this:

<!-- try: -->
      Box<Out> fmap<Box,In,Out>(Out(In) fun, Functor<Box,In> box) 
            given Box<Element> { ... }

Then, finally, for the same instantiation expression we had 
before:

<!-- try: -->
    fmap(Integer.string, ArrayList { 10, 20, 30 })

we can now unambiguously infer that `Box` is `List` and
`In` is `Integer`, since those types are encoded as type 
arguments to `Functor` in the principal supertype 
instantiation of `Functor` for the expression
`ArrayList { 10, 20, 30 }`.

### Instances of type functions

In the original post, we noted that a type function that 
returns a function type is the type of a generic function.
For example, the type function:

<!-- try: -->
    <X> given X satisfies Object => X(X)

Is the type of this generic function:

<!-- try: -->
    X f<X>(X x) given X satisfies Object => x;

But then it's natural to enquire: if some type functions are 
the types of generic functions, what are the _other_ type 
functions the types of?

Well, if you reflect for a second on the relationship 
between types and values, I think you'll see that they must
be the types of _generic value declarations_. That is, this
type function:

<!-- try: -->
    <X> => List<X>

would be the type of this value, written in pseudo-Ceylon:

<!-- try: -->
    List<X> list<X> => ... ;

That is, when presented with a type `X`, `list<X>` evaluates
to a `List<X>`. 

Of course there are no actual generic values in Ceylon, the 
closest thing we have is a nullary generic function:

<!-- try: -->
    List<X> list<X>() => ... ;

whose type is actually:

<!-- try: -->
    <X> => List<X>()

There's no plan to ever introduce generic values into Ceylon, 
so types like `<X> => List<X>` have no instances. They're
useful only as type arguments to higher-order generic types.

### Type functions and principal typing

Finally, let's address a rather technical point.

A very important property of Ceylon's type system is the
ability to form a _principal instantiation_ of any union or
intersection of different instantiations of a generic type.

For, example, for the covariant type `List<T>`:

- `List<X> | List<Y>` has the principal instantiation
  `List<X|Y>`
- `List<X> & List<Y>` has the principal instantiation
  `List<X&Y>`

For the contravariant type `Comparable<T>`:

- `Comparable<X> | Comparable<Y>` has the principal 
  instantiation `Comparable<X&Y>`
- `Comparable<X> & Comparable<Y>` has the principal 
  instantiation `Comparable<X|Y>`

Naturally, it's important that we can do the same tricks for
intersections and unions of instantiations of higher-order
types. As at happens, this works out extremely naturally,
using the following identities

- `<<X> => F<X>> | <<Y> => G<Y>>` is just `<T> => F<T> | G<T>`, 
  and
- `<<X> => F<X>> & <<Y> => G<Y>>` is just `<T> => F<T> & G<T>`.

Thus, if we have the following covariant second-order type:

<!-- try: -->
    interface Functor<out Element, out Container>
            given Container<E> { ... }

Then we obtain the following principal instantiations:

- `Functor<E,A> | Functor<F,B>` has the principal 
  instantiation `Functor<E|F,<T> => A<T>|B<T>>`, and
- `Functor<E,A> & Functor<F,B>` has the principal 
  instantiation `Functor<E&F, <T> => A<T>&B<T>>`.

You don't need to know these identities when you're writing
code in Ceylon, but it's nice to know that type functions
don't undermine the basic algebraic properties which are the 
reason Ceylon's type system is so nice to work with. 
Everything fits together here, without weird holes and 
corner cases.
