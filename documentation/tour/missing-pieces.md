---
layout: tour
title: Tour of Ceylon&#58; Missing Pieces
tab: documentation
author: Gavin King
---

# #{page.title}

## Attributes and locals

In Java, a field of a class is quite easily distinguished from a local 
constant or variable of a method or constructor. Ceylon doesn't really make 
this distinction very strongly. An attribute is really just a `local` that 
happens to be captured by some `shared` declaration.

Here, `count` is a local variable of the initializer of `Counter`:

<pre class="brush: ceylon">
    class Counter() {
        variable Natural count := 0;
    }
</pre>

But in the following two examples, `count` is an attribute:

<pre class="brush: ceylon">
    class Counter() {
        shared variable Natural count := 0;
    }
</pre>

<pre class="brush: ceylon">
    class Counter() {
        variable Natural count := 0;
        shared Natural inc() {
            return ++count;
        }
    }
</pre>

This might seem a bit strange at first, but it's really just how closure works. 
The same behavior applies to locals inside a method. Methods can't declare 
`shared` members, but they can return an `object` that captures a local:

<pre class="brush: ceylon">
    interface Counter {
        shared formal Natural inc();
    }
    Counter createCounter() {
        variable Natural count := 0;
        object counter satisfies Counter {
            shared actual Natural inc() {
                return ++count;
            }
        }
        return counter;
    }
</pre>

Even though we'll continue to use the words "local" and "attribute", keep in 
mind that there's no really strong distinction between the terms. Any named 
value might be captured by some other declaration in the same containing 
scope. (I'm still searching for a really good word to collectively describe 
attributes and locals.)

## Variables

Ceylon encourages you to use immutable attributes as much as possible. 
An immutable attribute has its value specified when the object is 
initialized, and is never reassigned.

<pre class="brush: ceylon">
    class Reference&lt;Value>(Value x) {
        shared Value value = x;
    }
</pre>

If we want to be able to assign a value to a simple attribute or local 
we need to annotate it `variable`:

<pre class="brush: ceylon">
    class Reference&lt;Value>(Value x) {
        shared variable Value value := x;
    }
</pre>

Notice the use of `:=` instead of `=` here. This is important! In Ceylon, 
specification of an immutable value is done using `=`. Assignment to a 
`variable` attribute or local is considered a different kind of thing, 
always performed using the `:=` operator.

The `=` specifier is not an operator, and can never appear inside an 
expression. It's just a punctuation character. The following code is not 
only wrong, but even fails to parse:

<pre class="brush: ceylon">
    if (x=true) {   //compile error
        ...
    }
</pre>

## Setters

If we want to make an attribute with a getter mutable, we need to define a 
matching setter. Usually this is only useful if you have some other internal 
attribute you're trying to set the value of indirectly.

Suppose our class has the following simple attributes, intended for internal 
consumption only, so un-shared:

<pre class="brush: ceylon">
    variable String? firstName := null;
    variable String? lastName := null;
</pre>

(Remember, Ceylon never automatically initializes attributes to null.)

Then we can abstract the simple attribute using a second attribute defined as a getter/setter pair:

<pre class="brush: ceylon">
    shared String fullName {
        return " ".join(coalesce(firstName,lastName));
    }
     
    shared assign fullName {
        Iterator&lt;String> tokens = fullName.tokens();
        firstName := tokens.head;
        lastName := tokens.rest.head;
    }
</pre>

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
Java or C# developers, so I'll just give a few quick examples without much 
additional commentary. However, one thing to be aware of is that Ceylon doesn't 
allow you to omit the braces in a control structure. The following doesn't parse:

<pre class="brush: ceylon">
    if (x>100) bigNumber();
</pre>

You are required to write:

<pre class="brush: ceylon">
    if (x>100) { bigNumber(); }
</pre>

OK, so here's the examples. The `if/else` statement is totally traditional:

<pre class="brush: ceylon">
    if (x>100)) {
        bigNumber(x);
    }
    else if (x>1000) {
        reallyBigNumber(x);
    }
    else {
        littleNumber();
    }
</pre>

The `switch/case` statement eliminates C's much-criticized "fall through" 
behavior and irregular syntax:

<pre class="brush: ceylon">
    switch (x&lt;=>100)
    case (smaller) { littleNumber(); }
    case (equal) { oneHundred(); }
    case (larger) { bigNumber(); }
</pre>

The `for` loop has an optional `else` block, which is executed when the 
loop completes normally, rather than via a `return` or `break` statement. 
There is no C-style `for`.

<pre class="brush: ceylon">
    Boolean minors;
    for (Person p in people) {
        if (p.age&lt;18) {
            minors = true;
            break;
        }
    }
    else {
        minors = false;
    }
</pre>

The `while` loop is traditional.

<pre class="brush: ceylon">
    variable local it = names.iterator();
    while (exists String name = it.head) {
        writeLine(name);
        it:=it.tail;
    }
</pre>

There is no `do/while` statement.

The `try/catch/finally` statement works like Java's:

<pre class="brush: ceylon">
    try {
        message.send();
    }
    catch (ConnectionException|MessageException e) {
        tx.setRollbackOnly();
    }
</pre>

And `try` supports a "resource" expression similar to Java 7.

<pre class="brush: ceylon">
    try (Transaction()) {
        try (Session s = Session()) {
            s.persist(person);
        }
    }
</pre>

## Sequenced parameters

A sequenced parameter of a method or class is declared using an ellipsis. 
There may be only one sequenced parameter for a method or class, and it must 
be the last parameter.

<pre class="brush: ceylon">
    void print(String... strings) { ... }
</pre>

Inside the method body, the parameter strings has type `String[]`.

<pre class="brush: ceylon">
    void print(String... strings) {
        for (String string in strings) {
            write(string);
        }
        writeLine();
    }
</pre>

A slightly more sophisticated example is the `coalesce()` method we saw above. 
`coalesce()` accepts `X?[]` and eliminates nulls, returning `X[]`, for any 
type `X`. Its signature is:

<pre class="brush: ceylon">
    shared Value[] coalesce&lt;Value>(Value?... sequence) { ... }
</pre>

Sequenced parameters turn out to be especially interesting when used in 
named argument lists for defining user interfaces or structured data. XXX


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

<pre class="brush: ceylon">
    import org.jboss.hello { Hello }
</pre>

To import several program elements from the same package, we write:

<pre class="brush: ceylon">
    import org.jboss.hello { Hello, defaultHello, PersonalizedHello }
</pre>

To import all toplevel program elements of a package, we write:

<pre class="brush: ceylon">
    import org.jboss.hello { ... }
</pre>

To resolve a name conflict, we can rename an imported declaration:

<pre class="brush: ceylon">
    import org.jboss.hello { local Hi = Hello, ... }
</pre>

We think renaming is a much cleaner solution than the use of qualified names.


## There's more...

Now that we've mopped up a few "missing" topics, we're ready to look at 
[modules](../modules).

