---
layout: tour13
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
variable or parameter of a constructor. Fields are declared directly in
the body of a Java class, whereas local variables are declared within 
the body of the constructor. And they're different kinds of things. A
local variable in a constructor doesn't outlive the invocation of the
constructor. But a field lives until the object it belongs to is garbage
collected.

This distinction is much less meaningful in Ceylon, and often irrelevant. 
An _attribute_ is really just a value declared in the parameter list or 
body of the class that happens to be captured by some `shared` declaration.

Here, `count` is a block-local variable of the initializer of `Counter`:

<!-- try-post:
    value c = Counter();
    print(c.count); // Compiler error! No access
-->
    class Counter() {
        variable Integer count = 0;
    }

But in this example, `count` is a `shared` attribute, visible to clients 
of the class:

<!-- try-post:
    value c = Counter();
    print(c.count);
    c.count++;
    print(c.count);
-->
    class Counter() {
        shared variable Integer count = 0;
    }

The distinction starts to melt away when we consider the next example:

<!-- try-post:
    value c = Counter();
    print(c.inc());
-->
    class Counter() {
        variable Integer count = 0;
        shared Integer inc() => ++count;
    }

Here, even though `count` is _not_ `shared`, it still has a lifecycle that
extends beyond the execution of the class initializer. We say that `count`
is _captured_ by the method `inc()`.

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
        variable Integer count = 0;
        object counter satisfies Counter {
            inc() => ++count;
        }
        return counter;
    }

Or, as we'll see [later](../functions), a function can even return a nested 
function that captures the local variable:

<!-- try-post:
    print(counter()());
-->
    Integer() counter() {
        variable Integer count = 0;
        Integer inc() => ++count;
        return inc;
    }

(Don't worry too much about the syntax here&mdash;for now all we're interested
in is that `counter()` returns a reference to a function `inc()` that captures 
the variable `count`.)

So even though we'll continue to use the terms "local value" and "attribute" 
throughout this tutorial, keep in mind that there's no really strong distinction 
between the things these terms refer to. Any named value might be captured by 
some other declaration in the same containing scope. A local value is just an 
attribute that happens to not be captured by anything.

## Let expressions

It's possible to declare a local value within an expression using `let`, for
example:

<!-- try-post:
    print(greeting);
 -->
    value greeting 
            => let (name = process.arguments.first else "world")
               "Hello ``name``!";

Let expressions are especially useful in combination with tuple and entry 
[destructuring](../sequences/#destructuring). 

## Variables

Ceylon encourages you to use *immutable* references as much as possible. 
Therefore, immutability is the default! An immutable reference has its value 
specified when the object is initialized, and is never reassigned.

    class Box<Value>(val) {
        shared Value val;
    }
    
    Box<String> ref = Box("hello");
    print(ref.val);
    ref.val = "bar";    //compile error: value is not variable

Note that, just like in Java, we don't have to declare and initialize a reference
in one line of code. We can write:

<!--- try-pre:
    class Box<Value>(val) {
        shared Value val;
    }
    Boolean leaving = false;
-->
<!-- try-post:
    print(ref.val);
-->
    Box<String> ref;
    if (leaving) {
        ref = Box("goodbye");
    }
    else {
        ref = Box("hello");    //ok
    }

That's perfectly OK, as long as the compiler can verify that `ref` only gets
assigned once in each conditional path through the code.

But if we want to be able to reassign a new value to a reference that has already 
been [initialized](../classes/#initializing_attributes), we need to annotate it 
`variable`:

    class Box<Value>(val) {
        shared variable Value val;
    }
    
    Box<String> ref = Box("hello");
    print(ref.val);
    ref.val = "goodbye";    //ok
    print(ref.val);

Idiomatic Ceylon code uses mutable references relatively less often than in most 
other languages. 

## Setters

We've already met the concept of a [getter](../classes/#abstracting_state_using_attributes).

If we want to make an attribute defined as a getter mutable, we need to define 
a matching setter. Usually this is only useful if you have some other internal 
attribute you're trying to set the value of indirectly.

Suppose our class has the following attributes, intended for internal 
consumption only, so un-`shared`:

<!-- try: -->
<!-- id:attrs -->
    variable String? firstName = null;
    variable String? lastName = null;

(Remember, Ceylon never automatically initializes attributes to null.)

Then we can abstract the attributes using a third attribute defined 
as a getter/setter pair:

<!-- try-pre:
class Test() {
    variable String? firstName = null;
    variable String? lastName = null;

-->
<!-- try-post:
}
value t = Test();
t.fullName="Pietje     Pluk";
print(t.fullName);
-->
<!-- cat-id:attrs -->
    shared String fullName
            => " ".join({ firstName, lastName }.coalesced);
    
    assign fullName {
        value tokens = fullName.split().iterator();
        if (is String first = tokens.next()) {
            firstName = first;
        }
        if (is String last = tokens.next()) {
            lastName = last;
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

### Gotcha!

First, one "gotcha" for folks coming from other C-like languages: Ceylon 
doesn't allow you to omit the braces in a control structure. The following 
doesn't even parse:

<!-- try:
    Integer x = 200;
    if (x > 100) print("big");  //error
-->
    if (x > 100) print("big");  //error

You are required to write:

<!-- try-pre:
    Integer x = 200;
-->
    if (x > 100) { print("big"); }

(The reason braces aren't optional in Ceylon is that an expression 
can begin with an opening brace, for example, `{"hello", "world"}`, 
so optional braces in control structures would make the whole grammar 
ambiguous.)

OK, so here we go with the examples. 

### If conditionals

The `if/else` statement is totally traditional:

<!-- try-pre:
    Integer x = 2000;
-->
    if (x > 1000) {
        print("really big");
    }
    else if (x > 100) {
        print("big");
    }
    else {
        print("small");
    }

Later we will learn how `if` can [narrow the type](../types#narrowing_the_type_of_an_object_reference) 
of references in its block. We've already seen an example of that, 
back when we talked about [optional types](../basics/#dealing_with_objects_that_arent_there).

We often use [the operators `then` and `else`](../basics/#you_can_chain_an_else...)
instead of `if`. 

### Switch conditionals

The `switch/case` statement eliminates C's much-criticized "fall through" 
behavior and irregular syntax:

<!-- try-pre:
    Integer x = 100;
-->
    switch (x <=> 100)
    case (smaller) { print("smaller"); }
    case (equal) { print("one hundred"); }
    case (larger) { print("larger"); }

The type of the `switch`ed expression may be an enumerated type, `String`,
`Character`, or `Integer`.

A `switch` statement may declare a value:

    switch (name = process.arguments.first)
    case (null) {
        print("Hello world!");
    }
    else {
        print("Hello ``name``!");
    }

We'll have much more to say about `switch` when we discuss 
[enumerated types](../types/#enumerated_types).

### Assertions

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
    value y = x + 10;

This is really just the same behavior we saw 
[earlier](../basics#dealing_with_objects_that_arent_there), only this time 
it's happening in the middle of a block rather than at the start of an `if` block. 
(Don't worry, there's 
[more on this later](../types#narrowing_the_type_of_an_object_reference).)

Note that, unlike Java's `assert`, which can be disabled at runtime, Ceylon's 
assertions are always enabled. 

### For loops

The `for` loop allows iteration over the elements of a Ceylon 
[`Iterable` stream](../sequences/#streams_iterables), a Java `Iterable`,
or a Java array.

    for (arg in process.arguments) {
        print(arg);
    }

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
            if (p.age < 18) {
                minors = true;
                break;
            }
        }
        else {
            minors = false;
        }
        return minors;
    }
    print(hasMinors(Person("john", 34), Person("jake", 47)));
-->
    variable Boolean minors;
    for (p in people) {
        if (p.age < 18) {
            minors = true;
            break;
        }
    }
    else {
        minors = false;
    }

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

### While loops

The `while` loop is traditional.

<!-- try-pre:
    value names = { "aap", "noot", "mies" };
-->
    value it = names.iterator();
    while (!is Finished next = it.next()) {
        print(next);
    }

There is no `do/while` statement.

### Try statements

The `try/catch/finally` statement works just like Java's:

<!-- try: -->
    try {
        message.send();
    }
    catch (ConnectionException|MessageException e) {
        tx.setRollbackOnly();
    }

To handle all Ceylon exceptions, together with all JavaScript exceptions,
or all Java exceptions that are subclasses of `java.lang.Exception`, we 
can `catch` the type 
[`Exception`](#{site.urls.apidoc_1_3}/Exception.type.html) 
defined in `ceylon.language`. If we don't explicitly specify a type,
`Exception` is inferred:

<!-- try: -->
    try {
        message.send();
    }
    catch (e) {  //equivalent to "catch (Exception e)"
        tx.setRollbackOnly();
    }

To handle all exceptions, including subtypes of `java.lang.Error`,
we can catch the root exception class 
[`Throwable`](#{site.urls.apidoc_1_3}/Throwable.type.html).

The `try` statement may optionally specify one or more "resource" 
expressions, just like in Java. The resource must be 
[`Destroyable`](#{site.urls.apidoc_1_3}/Destroyable.type.html) or 
[`Obtainable`](#{site.urls.apidoc_1_3}/Obtainable.type.html),
or a Java `AutoCloseable`.

<!-- try: -->
    try (Transaction(), s = Session()) {
        s.persist(person);
    }

There are no Java-style checked exceptions in Ceylon.


## Condition lists

Constructs like `if`, `while`, and `assert` accept a  *condition list*.
This is one of the most distinctive features of the syntax of Ceylon.
A condition list is simply an ordered list of :

- boolean expressions, 
- `exists` conditions, which we 
  [already met](../basics#dealing_with_objects_that_arent_there),
- `nonempty` conditions, which will make sense when we talk about
  [sequences](../sequences#sequences), 
- `is` conditions, of which `exists` and `nonempty` conditions are
  really just abbreviations, which we'll also meet 
  [later](../types/#narrowing_the_type_of_an_object_reference), and,
  finally.
- _negated_ forms of the above condition types, that is, `!exists`,
  `!nonempty`, and `!is`.

A condition list is satisfied if (and only if) *every one* of its 
conditions is satisfied. Consider the following `if` statement:

<!-- try: -->
    if (exists arg = process.arguments.first, !arg.empty) {
        print("Hello " + arg + "!");
    }

The body of the `if` statement will be executed only if _both_ the
conditions are satisfied, that is, only if `arg` is non-`null` _and_
non-`empty`.

The difference between a Ceylon condition list, and an expression 
formed by combining boolean expressions with `&&`, is that an `exists`,
`nonempty`, or `is` condition actually narrows the type of the value
to which the condition is applied.

In our example:

- The first condition declares `arg`, which is inferred to be a 
  `String`, rather than just a `String?`, because it forms part of 
  an `exists` condition. 
- The second condition, a simple boolean expression, makes use of 
  the fact that `arg` is already known to be non-`null`. 

The important thing to note is that the compiler lets us use `arg` 
in the second condition, and within the body of the `if` statement,
and assigns it the type `String`, not just `String?`. We can't 
achieve this by combining multiple boolean expressions together
with `&&`. (We _could_ do it by nesting two `if`s, but that leads 
to somewhat less readable code, and doesn't work well in `while` 
statements or comprehensions.) 

### Gotcha!

A very common "WTF" moment for programmers new to Ceylon is that there
are two quite similar-looking constructs which have different semantics
and occur quite differently within the grammar of the language:

- The prefix forms `exists x`, `nonempty x`, `is X x` represent
  _conditions_ that narrow the type of `x`, and they may only occur 
  directly within a condition list.
- On the other hand, the postfix forms `x exists`, `x nonempty`, `x is X`,
  are simply expressions of type `Boolean`; they may occur anywhere any
  other boolean expression may occur, and they don't narrow the type of
  anything. 

By choosing a different syntax for these two different sorts of things,
we emphasize the difference in semantics to the reader of the code. It's
more obvious that this condition list _doesn't_ narrow the type of 
`whatever`:

<!-- try: -->
    if (something && whatever exists || somethingElse && whatever exists) { ... }

Whereas this condition list _does_:

<!-- try: -->
    if (something && somethingElse, exists whatever) { ... }

Additionally, the choice of prefix syntax for conditions accommodates
the use of a [value declaration within the condition](../../faq/language-design/#prefix_form_for_is_type_exists_and_nonempty), 
for example:

<!-- try: -->
    if (exists whatever = dontCare()) { ... }

Condition lists occur not only in `if`, `switch`, `while`, and `assert`
statements, but also in [comprehensions](../comprehensions), and in `if`
and `switch` _expressions_.

## If and switch expressions

It's possible to write an "inline" `if` or `switch` within an expression, for
example:

<!-- try-post:
    print(greeting);
-->
    value greeting
        => if (exists name = process.arguments.first)
        then "Hello ``name``!" else "Hello world!";

Or:

<!-- try-pre:
    value length = runtime.name.size;
-->
    print(switch (length <=> 100)
          case (smaller) "smaller"
          case (equal) "one hundred"
          case (larger) "larger");

Note that the branches of an `if` or `switch` expression are always just 
expressions, never blocks of code!

### Gotcha!

Don't forget the `then` keyword in your `if` expression!

## There's more...

If you're interested, you can read more about 
[exception handling in Ceylon](/blog/2015/12/14/failure/).

Now that we know enough about classes and their members, we're ready to 
explore [inheritance and refinement (overriding)](../inheritance).
