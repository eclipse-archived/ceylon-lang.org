---
layout: tour
title: Attributes and variables, control structures
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
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


## Attributes and local values

In Java, a field of a class is quite easily distinguished from a local 
variable or parameter of a constructor. This distinction is much less
meaningful in Ceylon, and often irrelevant. An _attribute_ is really 
just a value declared in the parameter list or body of the class that 
happens to be captured by some `shared` declaration.

Here, `count` is a block-local variable of the initializer of `Counter`:

<!-- try-post:
    value c = Counter();
    print(c.count); // Compiler error! No access
-->
    class Counter() {
        variable Integer count=0;
    }

But in the following two examples, `count` is an attribute:

<!-- try-post:
    value c = Counter();
    print(c.count);
    c.count++;
    print(c.count);
-->
    class Counter() {
        shared variable Integer count=0;
    }

<!-- break up the two examples so we don't see a duped decl-->

<!-- try-post:
    value c = Counter();
    print(c.inc());
-->
    class Counter() {
        variable Integer count=0;
        shared Integer inc() => ++count;
    }

This might seem a bit strange at first, but it's really just how the principle 
of closure works. The same behavior applies to block-local values declared in
the body of a function. Functions can't declare `shared` members, of course, 
but they can return an `object` that captures a local variable:

<!-- try-post:
    value c = createCounter();
    print(c.inc());
-->
    interface Counter {
        shared formal Integer inc();
    }
    
    Counter createCounter() {
        variable Integer count=0;
        object counter satisfies Counter {
            shared actual Integer inc() => ++count;
        }
        return counter;
    }

Or, as we'll see [later](../functions), a function can return a nested function 
that captures the local variable:

<!-- try-post:
    print(counter()());
-->
    Integer() counter() {
        variable Integer count=0;
        Integer inc() => ++count;
        return inc;
    }

(Don't worry too much about the syntax here&mdash;for now all we're interested
in is that `counter()` returns a reference to a function `inc()` that captures 
the variable `count`.)

So even though we'll continue to use the terms "local value" and "attribute" 
throughout this tutorial, keep in mind that there's no really strong distinction 
between the terms. Any named value might be captured by some other declaration 
in the same containing scope. A local value is just an attribute that happens 
to not be captured by anything.


## Variables

Ceylon encourages you to use *immutable* attributes as much as possible. An 
immutable attribute has its value specified when the object is initialized, 
and is never reassigned.

    class Reference<Value>(val) {
        shared Value val;
    }
    
    value ref = Reference("foo");
    print(ref.val);
    ref.val = "bar";    //compile error: value is not variable
    

If we want to be able to assign a value to a 
[reference](../classes/#initializing_attributes), we need to annotate it 
`variable`:

    class Reference<Value>(val) {
        shared variable Value val;
    }
    
    value ref = Reference("foo");
    print(ref.val);
    ref.val = "bar";    //ok
    print(ref.val);

## Setters

We've already met the concept of a [getter](../classes/#abstracting_state_using_attributes).

If we want to make an attribute with a getter mutable, we need to define a 
matching setter. Usually this is only useful if you have some other internal 
attribute you're trying to set the value of indirectly.

Suppose our class has the following attributes, intended for internal 
consumption only, so un-`shared`:

<!-- try: -->
<!-- id:attrs -->
    variable String? firstName=null;
    variable String? lastName=null;

(Remember, Ceylon never automatically initializes attributes to null.)

Then we can abstract the attributes using a third attribute defined 
as a getter/setter pair:

<!-- try-pre:
class Test() {
    variable String? firstName=null;
    variable String? lastName=null;

-->
<!-- try-post:
}
value t = Test();
t.fullName="Pietje     Pluk";
print(t.fullName);
-->
<!-- cat-id:attrs -->
    shared String fullName =>
            " ".join(coalesce { firstName, lastName });
    
    assign fullName {
        value tokens = fullName.split().iterator();
        if (is String first = tokens.next()) {
            firstName=first;
        }
        if (is String last = tokens.next()) {
            lastName=last;
        }
    }

A setter is identified by the keyword `assign` in place of a type declaration. 
(The type of the matching getter determines the type of the attribute.)
Within the body of the setter, the attribute name evaluates to the value
being set.

Yes, this is a lot like a Java get/set method pair, though the syntax is 
significantly streamlined. But since Ceylon attributes are polymorphic, and 
since you can redefine a reference as a getter or getter/setter pair without 
affecting clients that call the attribute, you don't need to write getters 
and setters unless you're doing something special with the value you're 
getting or setting.

Don't ever write code like this in Ceylon:

<!-- try-pre:
class Test() {
-->
<!-- try-post:
}
-->
    variable String _name = "";
    shared String name => _name;  //pointless getter
    assign name => _name=name;    //pointless setter

It's not necessary, and there's never any benefit to it. 

## Control structures

Ceylon has six built-in control structures. There's nothing much new here 
for Java or C# developers, so a few quick examples without much additional 
commentary should suffice.

First, one "gotcha" for folks coming from other C-like languages: Ceylon 
doesn't allow you to omit the braces in a control structure. The following 
doesn't even parse:

<!-- try:
    Integer x = 200;
    if (x>100) print("big");  //error
-->
<!-- check:none:Demoing error -->
    if (x>100) print("big");  //error

You are required to write:

<!-- try-pre:
    Integer x = 200;
-->
<!-- cat: void m(Integer x) { -->
    if (x>100) { print("big"); }
<!-- cat: } -->

(The reason braces aren't optional in Ceylon is that an expression 
can begin with an opening brace, for example, `{"hello", "world"}`, 
so optional braces in control structures make the whole grammar 
ambiguous to the parser.)

OK, so here we go with the examples. 

<a name="conditionals"><!-- old id --></a>

### `if`

The `if/else` statement is totally traditional:

<!-- try-pre:
    Integer x = 2000;
-->
<!-- cat: void m(Integer x) { -->
    if (x>1000) {
        print("really big");
    }
    else if (x>100) {
        print("big");
    }
    else {
        print("small");
    }
<!-- cat: } -->

Later we will learn how `if` can [narrow the type](../types#narrowing_the_type_of_an_object_reference) 
of references in its block. We've already seen an example of that, 
back when we talked about [optional types](../basics/#dealing_with_objects_that_arent_there).

We often use [the operators `then` and `else`](../basics/#you_can_chain_an_else...)
instead of `if`. 

### `switch`

The `switch/case` statement eliminates C's much-criticized "fall through" 
behavior and irregular syntax:

<!-- try-pre:
    Integer x = 100;
-->
<!-- cat: void m(Integer x) { -->
    switch (x<=>100)
    case (smaller) { print("smaller"); }
    case (equal) { print("one hundred"); }
    case (larger) { print("larger"); }
<!-- cat: } -->

The type of the `switch`ed expression may be an enumerated type, `String`,
`Character`, or `Integer`.

We'll have much more to say about `switch` when we discuss 
[enumerated types](../types/#enumerated_types).


### `assert`

Ceylon also has an `assert` statement:

<!-- try-pre:
    value length = "hello world".size;
-->
    assert (length < 10);
    
Such assertions are good for making statements which you *know* have to be true, 
but are not apparent to other readers of the code (including the type checker!). 
Common uses of `assert` include things like preconditions, postconditions and 
class invariants.

If the condition is `false` at runtime an exception is thrown. The exception 
message helpfully includes details of the condition which was violated, which 
is extra important when the `assert` has more than one condition.

<!-- try-pre:
    value arg = process.arguments.first;
-->
    assert (exists arg, !arg.empty);

To customize the assertion message, add a `doc` annotation:

<!-- try-pre:
    value length = "hello world".size;
-->
    "length must be less than 10"
    assert (length < 10);

Where applicable, the typechecker uses `assert`ed type information when checking 
statements which follow the assertion, for example:

    Integer? x = parseInteger("1");
    assert (exists x);
    // after the assert, x has type Integer instead of Integer?
    value y = x+10;

This is really just the same behavior we saw 
[earlier](../basics#dealing_with_objects_that_arent_there), only this time 
it's happening in the middle of a block rather than at the start of an `if` block. 
(Don't worry, there's 
[more on this later](../types#narrowing_the_type_of_an_object_reference).)

Note that, unlike Java's `assert`, which can be disabled at runtime, Ceylon's 
assertions are always enabled. 

<a name="loops"><!-- old id --></a>

### `for`

The `for` loop has an optional `else` block, which is executed when the 
loop completes normally, rather than via a `return` or `break` statement. 

<!-- try:
    class Person(name, age) {
        shared String name;
        shared Integer age;
    }
    Boolean hasMinors(Person* people) {
        variable Boolean minors;
        for (p in people) {
            if (p.age<18) {
                minors=true;
                break;
            }
        }
        else {
            minors=false;
        }
        return minors;
    }
    print(hasMinors(Person("john", 34), Person("jake", 47)));
-->
<!-- cat: class Person() {shared Integer age = 0;} -->
<!-- cat: void m(Person[] people) { -->
    variable Boolean minors;
    for (p in people) {
        if (p.age<18) {
            minors=true;
            break;
        }
    }
    else {
        minors=false;
    }
<!-- cat: } -->

There is no C-style `for`. Instead, you can use the lengthwise range 
operator `:` to produce a sequence of `Integer`s given a starting point 
and a length:

<!-- try:
    for (i in 5:10) { print(i); }
-->
    for (i in min:len) { ... }

Alternatively, you can use the ordinary range operator `..` to produce 
a sequence of `Integer`s given two endpoints:

<!-- try:
    for (i in 5..10) { print(i); }
-->
    for (i in min..max) { ... }

There are a couple of other tricks with `for` that we'll come back to
[later](../sequences/#iterating_using_for).

We often use [comprehensions](../comprehensions) or even 
[higher order functions](../functions/#anonymous_functions) instead of
`for`.

### `while`

The `while` loop is traditional.

<!-- try-pre:
    value names = { "aap", "noot", "mies" };
-->
<!-- cat: void m(String[] names) { -->
    value it = names.iterator();
    while (is String next = it.next()) {
        print(next);
    }
<!-- cat: } -->

There is no `do/while` statement.

<a name="exception_handling"><!-- old id --></a>

### `try`

The `try/catch/finally` statement works just like Java's:

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

<!-- try: -->
<!-- cat-id:tx -->
<!-- cat: void m(Message message, Transaction tx) { -->
    try {
        message.send();
    }
    catch (ConnectionException|MessageException e) {
        tx.setRollbackOnly();
    }
<!-- cat: } -->

To handle all Ceylon exceptions, together with all JavaScript exceptions,
or all Java exceptions that are subclasses of `java.lang.Exception`, we 
can `catch` the type 
[`Exception`](#{site.urls.apidoc_1_0}/Exception.type.html) 
defined in `ceylon.language`. If we don't explicitly specify a type,
`Exception` is inferred:

<!-- try: -->
<!-- cat-id:tx -->
<!-- cat: void m(Message message, Transaction tx) { -->
    try {
        message.send();
    }
    catch (e) {  //equivalent to "catch (Exception e)"
        tx.setRollbackOnly();
    }
<!-- cat: } -->

There is no way to handle exceptions of type of `java.lang.Error`.

The `try` statement may optionally specify a "resource" expression, just
like in Java.

<!-- try: -->
<!-- cat-id:tx -->
<!-- check:parse:Requires try-with-resources -->
    try (Transaction()) {
        try (s = Session()) {
            s.persist(person);
        }
    }

There are no Java-style checked exceptions in Ceylon.


## Condition lists

Constructs like `if`, `while`, and `assert` accept a  *condition list*.
A condition list is simply an ordered list of multiple boolean, `exists`,
`nonempty`, and `is` conditions. The condition list is satisfied if 
(and only if) *every one* of the conditions is satisfied. 

With plain `Boolean` conditions you could achieve the same thing with the 
`&&` operator of course. But a condition list lets you use the "structured 
typecasting" of `exists`, `is`, and friends in conditions appearing later 
in the same list. 

Let's see an example using `assert`:

<!-- try: -->
    value url = parserUri("http://ceylon-lang.org/download");
    assert(exists authority=url.authority,
           exists host=authority.hostname);
    // do something with host

Here you can see two `exists` conditions in the `assert` statement, separated 
with a comma. The first one declares `authority` (which is inferred to be a 
`String`, rather than a `String?` because of the `exists`). The second condition
then uses this in it's own `exists` condition. 

The important thing to note is that the compiler lets us use `authority` in the 
second condition and knows that it's a `String` not a `String?`. You can't do 
that by `&&`-ing multiple conditions together. You could do it by nesting several 
`if`s, but that tends to lead to much less readable code, and doesn't work well 
in `while` statements or comprehensions. 


## There's more...

Now that we know enough about classes and their members, we're ready to 
explore [inheritance and refinement (overriding)](../inheritance).

