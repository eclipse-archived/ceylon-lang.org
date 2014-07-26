---
title: Why I distrust wildcards and why we need them anyway
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

In any programming language that combines subtype polymorphism
(object orientation) with parametric polymorphism (generics),
the question of _variance_ arises. Suppose I have a list of
strings, type `List<String>`. Can I pass that to a function
which accepts `List<Object>`? Let's start with this definition:

<!-- try: -->
    interface List<T> {
        void add(T element);
        Iterator<T> iterator();
        ...
    }

## Broken covariance

Intuitively, we might at first think that this should be 
allowed. This looks OK:

<!-- try: -->
    void iterate(List<Object> list) {
        Iterator<Object> it = list.iterator();
        ...
    }
    iterate(ArrayList<String>());

Indeed, certain languages, including Eiffel and Dart do 
accept this code. Sadly, it's unsound, as can be seen in the 
following example:

<!-- try: -->
    //Eiffel/Dart-like language with 
    //broken covariance:
    void put(List<Object> list) {
        list.add(10);
    }
    put(ArrayList<String>());

Here we pass a `List<String>` to a function accepting 
`List<Object>`, which attempts to add an `Integer` to the
list.

Java makes this same mistake with arrays. The following code
compiles:

<!-- try: -->
    //Java:
    void put(Object[] list) {
        list[0]=10;
    }
    put(new Object[1]);

It fails at runtime with an `ArrayStoreException`.

## Use-site variance

Java takes a different approach, however, for generic class 
and interface types. By default, a class or interface type
is _invariant_, which is to say, that:

- `L<U>` is assignable to `L<V>` if and only if `U` is 
  exactly the same type as `V`.

Since this is _extremely_ inconvenient much of the time, 
Java supports something called _use-site variance_, where:

- `L<U>` is assignable to `L<? extends V>` if `U` is a 
  subtype of `V`, and
- `L<U>` is assignable to `L<? super V>` if `U` is a 
  supertype of `V`.

The ugly syntax `? extends V` or `? super V` is called a 
_wildcard_. We also say that:

- `L<? extends V>` is _covariant_ in `V`, and that
- `L<? super V>` is _contravariant_ in `V`.

Since Java's wildcard notation is so ugly, we're not going
to use it anymore in this discussion. Instead, we'll write
wildcards using the keywords `in` and `out` for
contravariance and covariance respectively. Thus:

- `L<out V>` is _covariant_ in `V`, and that
- `L<in V>` is _contravariant_ in `V`.

In theory, we could have a wildcard with both an upper and
lower bound, for example, `L<out X in Y>`. 

You'll often see people refer to wildcarded types as 
_existential types_. What they mean by this is that if I 
know that `list` is of type `List<out Object>`:

<!-- try: -->
    List<out Object> list;

Then I know that there exists an unknown type `T`, a subtype 
of `Object`, such that `list` is of type `List<T>`.

Alternatively, we can take a more Ceylonic point of view,
and say that `List<out Object>` is the union of all types
`List<T>` where `T` is a subtype of `Object`.

In a system with usesite variance, the following code does
not compile:

<!-- try: -->
    void iterate(List<Object> list) {
        Iterator<Object> it = list.iterator();
        ...
    }
    iterate(ArrayList<String>()); //error: List<String> not a List<Object>

But this code does:

<!-- try: -->
    void iterate(List<out Object> list) {
        Iterator<out Object> it = list.iterator();
        ...
    }
    iterate(ArrayList<String>());

Correctly, this code does not compile:

<!-- try: -->
    void put(List<out Object> list) {
        list.add(10); //error: Integer is not a Nothing
    }
    put(ArrayList<String>());

Now we're at the entrance to the rabbit hole. In order to 
integrate wildcarded types into the type system, while 
rejecting unsound code like the above example, we need a 
much more complicated algorithm for type argument 
substitution.

## Member typing in use-site variance

That is, when we have a generic type like `List<T>`, with a 
method `void add(T element)`, instead of just 
straightforwardly substituting `Object` for `T`, like we do 
with ordinary invariant types, we need to consider the
_variance_ of the location in which the type parameter 
occurs. In this case, `T` occurs in a _contravariant location_
of the type `List`, namely, as the type of a method parameter.
The complicated algorithm, which I won't write down here,
tells us that we should substitute `Nothing`, the bottom type,
in this location.

Now imagine that our `List` interface has a `partition()` 
method with this signature:

<!-- try: -->
    interface List<T> {
        List<List<T>> partition(Integer length);
        ...
    }
 
 What is the return type of `partition()` for a
 `List<out Y>`? Well, without losing precision, it is:
 
<!-- try: -->
     List<in List<in Y out Nothing> out List<in Nothing out Y>>

Ouch.

Since nobody in their right mind wants to have to think 
about types like this, a sensible language would throw away
some of those bounds, leaving something like this:

<!-- try: -->
    List<out List<out Y>>

Which is vaguely acceptable. Sadly, even in this very simple 
case, we're already well beyond the point where the programmer 
can easily follow along with what the typechecker is doing.
 
So here's the essence of why I distrust use-site variance:

- A strong principle in the design of Ceylon is that the
  programmer should always be able to reproduce the 
  reasoning of the compiler. It is _very_ difficult to
  reason about some of the complex types that arise with
  use-site variance.
- It has a viral effect: once those wildcard types get a 
  foothold in the code, they start to propagate, and it's 
  quite hard to get back to my ordinary invariant types.

## Declaration-site variance

A much saner alternative to use-site variance is 
_declaration-site variance_, where we specify the variance 
of a generic type when we declare it. Under this system, we 
need to split `List` into three interfaces:

<!-- try: -->
    interface List<out T> {
         Iterator<T> iterator();
         List<List<T>> partition(Integer length);
         ...
    }

    interface ListMutator<in T> {
        void add(T element);
    }

    interface ListMutator<T>
        satisfies List<T>&ListMutator<T> {}

`List` is declared to be a covariant type, `ListMutator` a
contravariant type, and `ListMutator` an invariant subtype
of both.

It might seem that the requirement for multiple interfaces 
is big disadvantage of declaration-site variance, but it 
often turns out to be useful to separate mutation from
read operations, and:

- mutating operations are very often invariant, whereas
- read operations are very often covariant.

Now we can write our functions like this:

<!-- try: -->
    void iterate(List<Object> list) {
        Iterator<Object> it = list.iterator();
        ...
    }
    iterate(ArrayList<String>());

    void put(ListMutator<Integer> list) {
        list.add(10);
    }
    iterate(ArrayList<String>()); //error: List<String> is not a ListMutator<Integer>

You can read more about declaration-site variance 
[here](http://ceylon-lang.org/documentation/1.0/tour/generics/).

## Why we need use-site variance in Ceylon

Sadly, Java doesn't have declaration-site variance, and 
clean interoperation with Java is something that is very
important to us. I don't like adding a major feature to the
typesystem of our language purely for the purposes of 
interoperation with Java, and so I've resisted adding 
wildcards to Ceylon for years. In the end, reality and 
practicality won, and my stubborness lost. So Ceylon 1.1 
now features use-site variance with single-bounded wildcards.

I've tried to keep this feature as tightly constrained as
possible, with just the minimum required for decent Java
interop. That means that, like in Java:

- there are no double-bounded wildcards, of form 
  `List<in X out Y>`, and
- a wildcarded type can not occur in the `extends` or
  `satisfies` clause of a class or interface definition.

Furthermore, unlike Java:

- there are no implicitly-bounded wildcards, upper bounds
  must always be written in explicitly, and
- there is no support for _wildcard capture_.

Wildcard capture is a very clever feature of Java, which 
makes use of the "existential" interpretation of a wildcard
type. Given a generic function like this one:

<!-- try: -->
    List<T> unmodifiableList<T>(List<T> list) => ... :

Java would let me call `unmodifiableList()`, passing a 
wildcarded type like `List<out Object>`, returning another 
wildcarded `List<out Object>`, reasoning that there is some 
unknown `X`, a subtype of `Object` for which the invocation 
would be well-typed. That is, this code is considered 
well-typed, even though the type `List<out Object>` is not
assignable to `List<T>` for any `T`:

<!-- try: -->
    List<out Object> objects = .... ;
    List<out Object> unmodifiable = unmodifiableList(objects);

In Java, typing errors involving wildcard capture 
are almost impossible to understand, since they involve the
unknown, and undenoteable, type. I have no plans to add 
support for wildcard capture to Ceylon. 

## Try it out

Use-site variance is already implemented and already works
in Ceylon 1.1, which you can get from github, if you're 
super-motivated.