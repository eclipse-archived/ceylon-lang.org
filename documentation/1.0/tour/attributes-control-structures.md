---
layout: tour
title: Tour of Ceylon&#58; Attributes and Variables, Control Structures
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the third part of the Tour of Ceylon. In the [previous leg](../classes)
we learned about classes and [met the concept of an attribute](../classes/#abstracting_state_using_attributes). 
What really makes a class special is that is can hold state&mdash;references 
to other objects. So it's time to learn more about [attributes](#attributes_and_locals) 
and [variables](#variables). 
 
Then we're going to skim over some material about 
[control structures](#control_structures) 
  ([`if`](#ok_so_here_are_the...), 
  [`switch`](#the_switchcase_statement_eliminates_cs...),
  [`for`](#the_for_loop_has_an...),
  [`while`](#the_while_loop_is_traditional) and 
  [`try`](#the_trycatchfinally_statement_works_like...)).


## Attributes and locals

In Java, a field of a class is quite easily distinguished from a local 
constant or variable of a method or constructor. Ceylon doesn't really make 
this distinction very strongly. An attribute is really just a local that 
happens to be captured by some `shared` declaration.

Here, `count` is a local variable of the initializer of `Counter`:

    class Counter() {
        variable Integer count := 0;
    }

But in the following two examples, `count` is an attribute:

    class Counter() {
        shared variable Integer count := 0;
    }

<!-- break up the two examples so we don't see a duped decl-->

    class Counter() {
        variable Integer count := 0;
        shared Integer inc() {
            return ++count;
        }
    }

This might seem a bit strange at first, but it's really just how the principle 
of closure works. The same behavior applies to locals inside a method. Methods 
can't declare `shared` members, but they can return an `object` that captures 
a local variable:

    interface Counter {
        shared formal Integer inc();
    }
    
    Counter createCounter() {
        variable Integer count := 0;
        object counter satisfies Counter {
            shared actual Integer inc() {
                return ++count;
            }
        }
        return counter;
    }

Or, as we'll see [later](../functions), a method can return a nested function 
that captures the local variable:

    Integer() counter() {
        variable Integer count := 0;
        Integer inc() {
            return ++count;
        }
        return inc;
    }

(Don't worry too much about the syntax here&mdash;for now all we're interested
in is that `counter()` returns a reference to a function `inc()` that captures 
the variable `count`.)

So even though we'll continue to use the words "local" and "attribute" throughout
this tutorial, keep in mind that there's no really strong distinction between the 
terms. Any named value might be captured by some other declaration in the same 
containing scope. A local is just an attribute that happens to not be captured
by anything.


## Variables

Ceylon encourages you to use *immutable* attributes as much as possible. An 
immutable attribute has its value specified when the object is initialized, 
and is never reassigned.

    class Reference<Value>(Value x) {
        shared Value val = x;
    }

If we want to be able to assign a value to a simple attribute or local 
we need to annotate it `variable`:

    class Reference<Value>(Value x) {
        shared variable Value val := x;
    }

Notice the use of `:=` instead of `=` here. This is important! In Ceylon, 
specification of an immutable value is done using `=`. Assignment to a 
`variable` attribute or local is considered a different kind of thing, 
always performed using the `:=` operator.

The `=` specifier is not an operator, and can never appear inside an 
expression. It's just a punctuation character. The following code is not 
only wrong, but even fails to parse:

<!-- check:none:demoing error -->
    Boolean x = ... ;
    if (x=true) {   //compile error
        ...
    }

On the other hand, `:=` is an operator, and the following code is well-typed,
though perhaps not correct!

    variable Boolean x := ... ;
    if (x:=true) {   //ok
        ...
    }

## Setters

If we want to make an attribute with a getter mutable, we need to define a 
matching setter. Usually this is only useful if you have some other internal 
attribute you're trying to set the value of indirectly.

Suppose our class has the following simple attributes, intended for internal 
consumption only, so un-`shared`:

<!-- id:attrs -->
    variable String? firstName := null;
    variable String? lastName := null;

(Remember, Ceylon never automatically initializes attributes to null.)

Then we can abstract the simple attributes using a third attribute defined 
as a getter/setter pair:

<!-- cat-id:attrs -->
    shared String fullName {
        return " ".join(coalesce({firstName,lastName})...);
    }
     
    assign fullName {
        value tokens = fullName.split().iterator;
        if (is String first = tokens.next()) {
            firstName := first;
        }
        if (is String last = tokens.next()) {
            lastName := last;
        }
    }

A setter is identified by the keyword `assign` in place of a type declaration. 
(The type of the matching getter determines the type of the attribute.)
Within the body of the setter, the attribute name evaluates to the value
being set.

Yes, this is a lot like a Java get/set method pair, though the syntax is 
significantly streamlined. But since Ceylon attributes are polymorphic, and 
since you can redefine a simple attribute as a getter or getter/setter pair 
without affecting clients that call the attribute, you don't need to write 
getters and setters unless you're doing something special with the value 
you're getting or setting.

Don't ever write code like this in Ceylon:

    variable String _name;
    shared String name { return _name; }
    assign name { _name:=name; }

It's not necessary, and there's never any benefit to it. 

## Control structures

Ceylon has five built-in control structures. There's nothing much new here 
for Java or C# developers, so a few quick examples without much additional 
commentary should suffice. However, one thing to be aware of is that Ceylon 
doesn't allow you to omit the braces in a control structure. The following 
doesn't even parse:

<!-- check:none:Demoing error -->
    if (x>100) bigNumber();

You are required to write:

<!-- cat: void m(Integer x) { -->
    if (x>100) { print("big"); }
<!-- cat: } -->

OK, so here are the examples. 

### Conditionals

The `if/else` statement is totally traditional:

<!-- cat: void m(Integer x) { -->
    if (x>100) {
        print("big");
    }
    else if (x>1000) {
        print("really big");
    }
    else {
        print("small");
    }
<!-- cat: } -->

We often use [the operators `then` and `else`](../basics/#you_can_chain_an_else...)
instead of `if`. 

The `switch/case` statement eliminates C's much-criticized "fall through" 
behavior and irregular syntax:

<!-- cat: void m(Integer x) { -->
    switch (x<=>100)
    case (smaller) { print("smaller"); }
    case (equal) { print("one hundred"); }
    case (larger) { print("larger"); }
<!-- cat: } -->

The type of the `switch`ed expression _must_ be an enumerated type. You
can't `switch` on a `String` or `Integer`. (Use `if` instead.)

### Loops

The `for` loop has an optional `else` block, which is executed when the 
loop completes normally, rather than via a `return` or `break` statement. 

<!-- cat: class Person() {shared Integer age = 0;} -->
<!-- cat: void m(Person[] people) { -->
    variable Boolean minors;
    for (p in people) {
        if (p.age<18) {
            minors := true;
            break;
        }
    }
    else {
        minors := false;
    }
<!-- cat: } -->

There is no C-style `for`. Instead, you can use the range operator to
produce a sequence of `Integer`s:

    for (i in min..max) { ... }

We often use [comprehensions](../comprehensions) or even 
[higher order functions](../functions/#anonymous_functions) instead of
`for`.

The `while` loop is traditional.

<!-- cat: void m(String[] names) { -->
    value it = names.iterator;
    while (is String next = it.next) {
        print(next);
    }
<!-- cat: } -->

There is no `do/while` statement.

### Exception handling

The `try/catch/finally` statement works like Java's:

<!-- implicit-id:tx: 
    shared interface Message { 
        shared formal void send(); 
    } 
    shared interface Transaction { 
        shared formal void setRollbackOnly(); 
    }
    shared class ConnectionException() extends Exception(null, null) {
    }
    shared class MessageException() extends Exception(null, null) {
    }
-->

<!-- cat-id:tx -->
<!-- cat: void m(Message message, Transaction tx) { -->
    try {
        message.send();
    }
    catch (ConnectionException|MessageException e) {
        tx.setRollbackOnly();
    }
<!-- cat: } -->

And `try` will support a "resource" expression similar to Java 7.

<!-- cat-id:tx -->
<!-- check:parse:Requires try-with-resources -->
    try (Transaction()) {
        try (s = Session()) {
            s.persist(person);
        }
    }

There are no Java-style checked exceptions in Ceylon.

### implementation note <!-- m3 -->

Resource expressions in `try` are not yet supported in M3.

## There's more...

Now that we know enough about classes and their members, we're ready to 
explore [inheritance and refinement (overriding)](../inheritance).

