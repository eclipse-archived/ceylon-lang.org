---
layout: reference13
title_md: 'Positional argument lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A positional argument list is not an expression itself, 
but is used in the formation of 
[invocation expressions](../invocation/) and [tuple](../tuple/) and 
[iterable](../iterable/) enumerations.

## Usage 

A *positional argument list* is simply a series of expressions, separated by 
commas. This example shows a positional invocation of a `put` function:

<!-- try: -->
    put(1, "one");

## Description

The position of each argument within the argument list identifies the
corresponding parameter in the 
[parameter list](../../structure/parameter-list) of the `Callable`
being invoked. This is in contrast to named argument lists, 
where the correspondence between argument and parameter is 
done using the parameter's name.

There are three kinds of argument that can appear in a 
positional argument list

* [listed arguments](#listed_arguments),
* [spread arguments](#spread_arguments),
* [comprehension arguments](#comprehension_arguments)

### Listed arguments

Listed arguments are simply expressions which 
are evaluated to give the argument to the corresponding parameter.

    print("hello world");
    HashSet(1, 2, 3);

If the last parameter is 
[variadic](../../structure/parameter-list#variadic_methods_and_varargs) 
then it can accept multiple 
listed arguments (for example, in the `HashSet` instantiation 
above).

### Spread arguments

A spread argument assigns the elements of an iterable or tuple object to 
*one or more* parameters. Spread arguments are distinguished from 
normal listed arguments by a preceeding star (`*`):

    HashSet(*elements);

Spread arguments are useful when you have an iterable or 
sequential reference which you want to pass as the argument to 
a [variadic parameter](../../structure/parameter-list#variadic_methods_and_varargs). 
Since you cannot use listed arguments
(because you don't know what the elements of the reference are)
you have to use a spread.

A spread [`Iterable`](#{site.urls.apidoc_1_3}/Iterable.type.html) 
can assigns a single `Iterable` argument to a variadic parameter:

<!-- try: -->
    void spreadIterable(String* names) {
        // note names is a variadic parameter
    }
    
    {String*} names = { "Tom", "Gavin" };
    
    // Invocation using listed arguments
    spreadIterable("Tom", "Gavin");

    // Invocation using a spread iterable argument
    spreadIterable(*names);

If the argument is not already assignable to `Sequential` it is converted 
to a `Sequential` before being passed to the function (because 
within a variadic function, the variadic parameter has 
`Sequential` or `Sequence` type, depending on the varidacity).

You can also spread a [`Tuple`](#{site.urls.apidoc_1_3}/Tuple.type.html) 
over *more than one* parameter. In other words a single argument can be used to 
provide the values of more than one parameter:

Unlike `Iterable` arguments, Spreading `Tuple` arguments is not just 
limited to invocations with variadic parameters:

    print(*["hello world"]);

It works with [variadic parameters](../../structure/parameter-list#variadic_methods_and_varargs) 
too, of course:

<!-- try: -->
    void spreadTuple(String name, Integer* numbers) {
        // note numbers is a variadic parameter
    }
    
    [String, Integer] tup = ["Tom", 1234];
    
    // A spread tuple
    spreadTuple(*tup);
    
    // Variations
    spreadTuple(*["Dick"]);
    spreadTuple(*["Harry", 123, 466]);
    spreadTuple(*["Alice"]);
    spreadTuple("Eve", *[123, 466]);


### Comprehension arguments

A comprehension is a shorthand way of creating an 
[`Iterable`](#{site.urls.apidoc_1_3}/Iterable.type.html) 
to be passed as an argument. 

    Integer sum({Integer*} values) {
        // ...
    }
    
    value sumOfEvens = sum(for (x in 0..50) 2*x);

The values produced by the iterable are constructed using 
`for` and `if` clauses and an expression:

* A `for` clause introduces an iteration variable and a 
  source iterable.
* An `if` clause specifies a condition used to filter 
  values from the resulting `Iterable`.
* The expression transforms the iteration variable(s)

So in the example above:

    value sumOfEvens = sum(
        for (x in 0..50) // the source iterable is 0..50
            2*x); // the expression doubles the iteration variable

We could produce the same stream of even numbers like this:

    value sumOfEvens = sum(
        for (x in 0..100) // the source iterable is 0..100
            if (x%2 == 0) // we select only the even numbers
                x); // and the expression is the number we selected

Comprehensions with multiple `for` and `if` clauses are permitted:

    sum(
        for (x in 0..100)
            for (y in 0..x)
                x*y);

The `Iterable`s created by comprehension arguments are *lazy*, 
so each element is only evaluated when required.

It is common to use a comprehension argument in an 
[iterable enumeration](../iterable):

    value names = {for (person in people) person.name};

Comprehensions support [destructuring](../../statement/destructure):

    value distances = {for ([x, y] in points) sqrt(x^2+y^2)};

Since Ceylon 1.2.2 `for` comprehensions support iteration over Java `java.lang::Iterable`s
and array types.

## See also

* The reference on [invocation](../invocation)
* The reference on [named argument lists](../named-argument-list/)
