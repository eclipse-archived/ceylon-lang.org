---
layout: tour
title: Tour of Ceylon&#58; Missing Pieces
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the eighth part of the Tour of Ceylon. If you found the 
[previous part](../generics) on generic types a little overwhelming, don't 
worry; this part is going to cover a some details which should be more 
familiar including [variables](#variables), 
[control structures](#control_structures) 
  ([`if`](#ok_so_here_are_the...), 
  [`switch`](#the_switchcase_statement_eliminates_cs...),
  [`for`](#the_for_loop_has_an...),
  [`while`](#the_while_loop_is_traditional) and 
  [`try`](#the_trycatchfinally_statement_works_like...))
and [packages](#packages_and_imports)


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

This might seem a bit strange at first, but it's really just how closure works. 
The same behavior applies to locals inside a method. Methods can't declare 
`shared` members, but they can return an `object` that captures a local:

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

Even though we'll continue to use the words "local" and "attribute", keep in 
mind that there's no really strong distinction between the terms. Any named 
value might be captured by some other declaration in the same containing 
scope.


## Variables

Ceylon encourages you to use *immutable* attributes as much as possible. 
An immutable attribute has its value specified when the object is 
initialized, and is never reassigned.

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
    if (x=true) {   //compile error
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

Then we can abstract the simple attribute using a second attribute defined as a getter/setter pair:

<!-- cat-id:attrs -->
    shared String fullName {
        return " ".join(coalesce({firstName,lastName})...);
    }
     
    assign fullName {
        value tokens = fullName.split().iterator;
        value first = tokens.next();
        if (is String first) {
            firstName := first;
        }
        value last = tokens.next();
        if (is String last) {
            lastName := last;
        }
    }

A setter is identified by the keyword `assign` in place of a type declaration. 
(The type of the matching getter determines the type of the attribute.)

Yes, this is a lot like a Java get/set method pair, though the syntax is 
significantly streamlined. But since Ceylon attributes are polymorphic, and 
since you can redefine a simple attribute as a getter or getter/setter pair 
without affecting clients that call the attribute, you don't need to write 
getters and setters unless you're doing something special with the value 
you're getting or setting.


## Control structures

Ceylon has five built-in control structures. There's nothing much new here for 
Java or C# developers, so a few quick examples without much 
additional commentary should suffice. However, one thing to be aware of is 
that Ceylon doesn't allow you to omit the braces in a control structure. 
The following doesn't parse:

<!-- check:none:Demoing error -->
    if (x>100) bigNumber();

You are required to write:

<!-- cat: void m(Integer x) { -->
    if (x>100) { print("big"); }
<!-- cat: } -->

OK, so here are the examples. The `if/else` statement is totally traditional:

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

The `switch/case` statement eliminates C's much-criticized "fall through" 
behavior and irregular syntax:

<!-- cat: void m(Integer x) { -->
    switch (x<=>100)
    case (smaller) { print("smaller"); }
    case (equal) { print("one hundred"); }
    case (larger) { print("larger"); }
<!-- cat: } -->

The `for` loop has an optional `else` block, which is executed when the 
loop completes normally, rather than via a `return` or `break` statement. 
There is no C-style `for`.

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

The `while` loop is traditional.

<!-- cat: void m(String[] names) { -->
    value it = names.iterator;
    while (true) {
        value next = it.next;
        if (next is Finished) {
            break;
        }
        print(next);
    }
<!-- cat: } -->

There is no `do/while` statement.

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

And `try` (by Milestone 5) will support a "resource" expression similar 
to Java 7.

<!-- cat-id:tx -->
<!-- check:parse:Requires try-with-resources -->
    try (Transaction()) {
        try (s = Session()) {
            s.persist(person);
        }
    }

## Sequenced parameters

A sequenced parameter of a method or class is declared using an ellipsis. 
There may be only one sequenced parameter for a method or class, and it must 
be the last parameter.

    void print(String... strings) { 
        // ... 
    }

Inside the method body, the parameter `strings` has type `String[]`.

    void print(String... strings) {
        for (string in strings) {
            process.writeLine(string);
        }
    }

A slightly more sophisticated example is the `coalesce()` method we saw [above](#then_we_can_abstract_the...). 
`coalesce()` accepts `X?[]` and eliminates nulls, returning `X[]`, for any 
type `X`. Its signature is:

<!-- check:none:pedagogical -->
    shared Value[] coalesce<Value>(Value?... sequence) { 
        // ... 
    }

Sequenced parameters turn out to be especially interesting when used in 
[named argument lists](../named-arguments) for defining user interfaces or structured data.


## Packages and imports

There's no special `package` statement in Ceylon. The compiler determines the 
package and module to which a toplevel program element belongs by the 
location of the source file in which it is declared. A class named `Hello` in 
the package `org.jboss.hello` must be defined in the file 
`org/jboss/hello/Hello.ceylon`.

When a source file in one package refers to a toplevel program element in 
another package, it must explicitly import that program element. Ceylon, 
unlike Java, does not support the use of qualified names within the source 
file. We can't write `org.jboss.hello.Hello` in Ceylon.

The syntax of the `import` statement is slightly different to Java. 
To import a program element, we write:

<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar }

To import several program elements from the same package, we write:

<!-- check:none:pedagogical -->
    import com.redhat.polar.core { Polar, pi }

To import all toplevel program elements of a package, we write:

<!-- check:none:pedagogical -->
    import com.redhat.polar.core { ... }

To resolve a name conflict, we can rename an imported declaration:

<!-- check:none:pedagogical -->
    import com.redhat.polar.core { PolarCoord=Polar }

We think renaming is a much cleaner solution than the use of qualified names.


## There's more...

Now that we've mopped up a few "missing" topics, we're ready to look at 
[modules](../modules).

