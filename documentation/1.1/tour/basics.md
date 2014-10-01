---
layout: tour11
title: Basics
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
doc_root: ../..
---

# #{page.title}

Let's get started!

Before we can get into any of the really interesting and powerful features of 
this language, we need to get comfortable with some of the basic syntax, so
we'll know what we're looking at later on, when we get up to the really good 
stuff. 


## String literals

As we [just saw](../#a_really_simple_program), a _string literal_ is text 
enclosed in double-quotes:

<!-- try-post:
    hello();
-->
    void hello() {
        print("Hello, World!");
    }

String literals in Ceylon may span multiple lines. Try this:

<!-- try:
    void hello() {
        print("Hello, 
               World!");
    }
    hello();
-->
<!-- id: hello -->
    void hello() {
        print("Hello, 
               World!");
    }

The output is:

<!-- lang: none -->
    Hello, 
    World!

Note that because the second line of the string literal contained whitespace 
right up until the first character of the first line of the string literal,
all that whitespace was automatically removed. This helps us format our
code nicely.

It's often useful to collapse whitespace in a multiline string literal. The
[`String`](#{site.urls.apidoc_1_1}/String.type.html)
class has an attribute called 
[`normalized`](#{site.urls.apidoc_1_1}/String.type.html#normalized). 
We can use it like this:

<!-- try-post:
    hello();
-->
<!-- id: hello -->
    void hello() {
        value message = "Hello, 
                         World!";
        print(message.normalized);
    }

Which results in the output:

<!-- lang: none -->
    Hello, World!

Multiline strings are especially useful for adding documentation to a 
program.


## Adding inline documentation

It's usually a good idea to add some kind of documentation to important 
functions like `hello()`. One way we could do this is by using a C-style 
comment, either like this:

<!-- try-post:
    hello();
-->
<!-- id: hello -->
    /* The classic Hello World program */
    void hello() {
        print("Hello, World!");
    }

Or like this:

<!-- try-post:
    hello();
-->
<!-- id: hello -->
    //The classic Hello World program
    void hello() {
        print("Hello, World!");
    }

But it's much better to use the `doc` annotation for comments that describe 
declarations.

<!-- try-post:
    void goodbye() {
    }
    class IOException() extends Exception() {}
    hello();
-->
<!-- check:none: Requires IO -->
<!-- id: hello -->
	doc ("The classic Hello World program")
	by ("Gavin")
	see (`function goodbye`)
	throws (`class IOException`)
	void hello() {
	    print("Hello, World!");
	}
<!-- cat: 
    void goodbye() {
        // ...
    } -->

The `doc`, `by`, `see`, `throws`, and `tagged` annotations contain documentation 
that is included in the output of the Ceylon documentation compiler, 
[`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html).

<!--
Notice that when an annotation argument is a literal, it doesn't need to be 
enclosed in parentheses. We can write simply: 

<!- - try: - ->
<!- - check:none - ->
    by "Gavin"

instead of:

<!- - try: - ->
<!- - check:none - ->
    by ("Gavin")
-->

Annotations like `doc`, `by`, `see`, and `throws`, aren't keywords. They're 
just ordinary identifiers. The same is true for annotations which are part of 
the language definition, for example: `abstract`, `variable`, `shared`, `formal`, 
`default`, `actual`, etc. This is quite different to other C-like languages. (On 
the other hand, `void` _is_ a keyword, just like in C or Java.)

Since the `doc` annotation is ubiquitous, its name and parentheses may be left 
out whenever it occurs as the first annotation in the list of annotations of a 
program element:

<!-- try-post:
    void goodbye() {
    }
    class IOException() extends Exception() {}
    hello();
-->
<!-- check:none: Requires IO -->
<!-- id: hello -->
    "The classic Hello World program"
    by ("Gavin")
    see (`function goodbye`)
    throws (`class IOException`)
    void hello() {
        print("Hello, World!");
    }
<!-- cat: 
    void goodbye() {
        // ...
    } -->


## Formatting inline documentation

The `doc` annotation may contain [Markdown](http://daringfireball.net/projects/markdown/syntax)
formatting.

<!-- try-post:
    hello();
-->
<!-- id: hello -->
    "The classic [Hello World program][helloworld]
     that prints a message to the console, this 
     time written in [Ceylon][]. 
     
     This simple program demonstrates:
     
     1. how to define a toplevel function, and
     2. how to `print()` a literal `String`.
     
     You can compile and run `hello()` from the 
     command line like this:
         
         ceylon compile source/hello.ceylon
         ceylon run -run hello default
         
     Or you can use `Run As > Ceylon Application` 
     in the IDE.
     
     [helloworld]: http://en.wikipedia.org/wiki/Hello_world_program
     [Ceylon]: http://ceylon-lang.org"
    
    void hello() {
        print("Hello, World!");
    }

Since Markdown is sensitive to the initial column in which text appears, 
you need to be careful to indent the lines of the multiline string literal 
correctly, as we've done here.


## Escape sequences

Inside a string literal, you can use the escape sequences `\n`, `\t`, `\\`,
`\"` and friends that you're used to from other C-like languages.

    print("\"Hello!\", said the program.");

You can also use 2-byte and 4-byte hexadecimal escape sequences to embed
Unicode characters in your text.

<!-- try-pre:
    Float calculateE() => 2.72;
    Float calculatePi() => 3.14;
    
-->
    "The mathematical constant \{#03C0}, the
     ratio of the circumference of a circle
     to its diameter."
    Float pi=calculatePi();
    
    "The mathematical constant \{#0001D452},
     the base of the natural logarithm."
    Float e=calculateE();

Even better, you can identity a Unicode character by its name.

<!-- try-pre:
    Float calculateE() => 2.72;
    Float calculatePi() => 3.14;
    
-->
    "The mathematical constant \{GREEK SMALL LETTER PI}, the 
     ratio of the circumference of a circle to its diameter."
    Float pi=calculatePi();
    
    "The mathematical constant \{MATHEMATICAL ITALIC SMALL E},
     the base of the natural logarithm."
    Float e=calculateE();

Ceylon strings are composed of UTF-32 characters, as we'll see 
[later in the tour](../language-module/#characters_and_character_strings).


## Verbatim strings

Sometimes, escape sequence interpolation is annoying, for example, when
embedding code in a string literal. If we use three double-quotes, `"""`, 
to delimit our string, we get a _verbatim string_, which may contain
unescaped backslash and double-quote characters:

    print(""""Hello!", said the program.""");


## String interpolation and concatenation

Let's make our program tell us a little more about itself.

<!-- try-post:
    hello();
-->
<!-- id: hello -->
    "The Hello World program ... version 1.1!"
    void hello() {
        print("Hello, this is Ceylon ``language.version``  
               running on Java ``runtime.version``!\n
               You ran me at ``system.milliseconds`` ms, 
               with ``process.arguments.size`` arguments.");
    }

Notice how our message contains interpolated expressions, delimited using
"doublebacks", that is, two backticks. This is called a _string template_. 

On my machine, this program results in the following output:

<!-- lang: none -->
    Hello, this is Ceylon 1.0.0
    running on Java 1.7!
    
    You ran me at 1362763185067 ms,
    with 0 arguments.

<!--
(If you're wondering why the syntax isn't something like 
`"Hello, you ran me at ${process.milliseconds}"`,
[here's why](#{page.doc_root}/faq/language-design/#string_interpolation_syntax).)
-->

The `+` operator you're probably used to is an alternative way to concatenate
strings, and more flexible in many cases:

<!-- cat: void m() { -->
    print("Hello, this is Ceylon " + language.version +  
          "running on Java " + process.vmVersion + "!\n" +
          "You ran me at " + process.milliseconds.string + 
          " ms, with " + process.arguments.size.string + 
          " arguments.");
<!-- cat: } -->

Note that when we use `+` to concatenate strings, we have to explicitly 
invoke the 
[`string`](#{site.urls.apidoc_1_1}/Object.type.html#string) 
attribute to convert numeric expressions to strings. The 
`+` operator does not automatically convert its operands to strings, so the 
following does not compile:  

<!-- check:none:Demoing error -->
    print("Hello, this is Ceylon " + language.version +  
          "running on Java " + process.vmVersion + "!\n" +
          "You ran me at " + process.milliseconds +  //compile error!
          " ms, with " + process.arguments.size +    //compile error!
          " arguments.");


## Dealing with objects that aren't there

Let's take a name as input from the command line. We have to account for 
the case where nothing was specified at the command line, which gives us 
an opportunity to explore how `null` values are treated in Ceylon, which 
is quite different to what you're probably used to in Java or C#.

Let's consider an overly-verbose example to start with. (We'll work our 
way up to a more convenient form.)

<!-- try-post:
    hello();
-->
    "Print a personalized greeting"
    void hello() {
        String? name = process.arguments.first;
        String greeting;
        if (exists name) {
            greeting = "Hello, ``name``!";
        }
        else {
            greeting = "Hello, World!";
        }
        print(greeting);
    }

The type `String?` indicates that `name` may contain a `null` value. We then 
use the `if (exists ... )` control structure to handle the case of a `null` 
name separately from the case of a non-`null` name.

It's possible to abbreviate the code we just saw by declaring the local `name` 
inside the `if (exists ... )` condition:

<!-- cat: void hello() { -->
    String greeting;
    if (exists name = 
            process.arguments.first) {
        greeting = "Hello, ``name``!";
    }
    else {
        greeting = "Hello, World!";
    }
    print(greeting);
<!-- cat: } -->

This is the preferred style most of the time, since we can't actually use 
`name` for anything useful outside of the `if (exists ... )` construct.
(But this still isn't the most compact way to write this code.)


## Optional types

Local variables, parameters, and attributes that may contain `null` values 
must be explicitly declared as being of optional type (the `T?` syntax). 
There's simply no way to assign `null` to a local that isn't of optional type. 
The compiler won't let you. This is an error:

    String name = null; //compile error: null is not an instance of String

Nor will the Ceylon compiler let you do anything dangerous with a value of 
type `T?` - that is, anything that could cause a `NullPointerException` in 
Java - without first checking that the value is not `null` using 
`if (exists ... )`. The following is also an error:

    String? name = process.arguments.first;
    print("Hello " + name + "!"); //compile error: name is not Summable

In fact, it's not even possible to use the equality operator `==` with an 
expression of optional type. We can't write: 

<!-- try:
    String? name = process.arguments.first;
    if (name==null) { } //compile error: name is not Object
-->
    String? name = process.arguments.first;
    if (name==null) { ... } //compile error: name is not Object
    
like we can in Java. This helps avoid the undesirable behavior of `==` in 
Java where `x==y` evaluates to true if `x` and `y` both evaluate to `null`.

In a language with static typing, we're always wanting to know what the type 
of something is. So what's the type of `null`? 

That's easy to answer: `null` is a [`Null`](#{site.urls.apidoc_1_1}/Null.type.html).

Yes, that's right: the value `null` isn't a primitive value in Ceylon, it's 
just a perfectly ordinary instance of the perfectly ordinary class `Null`, 
at least from the point of view of Ceylon's type system. 

And the syntax `String?` is just an abbreviation for the 
[union type](../types/#union_types) `Null|String`. 

That's why we can't call operations of `String` on a `String?`. It's simply 
a different type! The `if (exists ...)` construct narrowed the type of `name` 
inside the `if` block, allowing us to treat `name` as a `String` there.

(As an aside, if you're concerned about performance, it's worth mentioning that 
the Ceylon compiler does some special magic to transform this value to a virtual 
machine-level null, all under the covers.)

## Operators for handling null values

There are a couple of operators that will make your life easier when dealing 
with `null` values. The first is `else`:

<!-- try-pre:
    String? name = null;
-->
<!-- try-post:
    print(greeting);
-->
<!-- cat: void hello(String? name) { -->
    String greeting = "Hello, " + (name else "World");
<!-- cat: 
    print(greeting);
} -->

The `else` operator produces:

- its first operand if the first operand is not `null`, or 
- its second operand otherwise. 

It's a more convenient way to handle `null` values in simple cases. You 
can chain multiple `else`s:

<!-- try-pre:
    String? firstName = null;
    String? userId = "joe";
-->
<!-- try-post:
    print(name);
-->
    String name = firstName else userId else "Guest";

There's also an operator for _producing_ a null value:

<!-- try-pre:
    String arg = "hello";
-->
<!-- try-post:
    print(name else "No name");
-->
    String? name = !arg.trimmed.empty then arg;

The `then` operator produces 

- its second operand if its first operand evaluates to `true`, or
- `null` otherwise.

You can chain an `else` after a `then` to reproduce the behavior of C's
ternary `?:` operator:

<!-- try-pre:
    String arg = "hello";
-->
<!-- try-post:
    print(name);
-->
    String name = !arg.trimmed.empty then arg else "World";
<!--
Finally, the `?.` operator lets us call operations on optional types:
-->
<!-- try-pre:
    String? name = null;
-->
<!-- try-post:
    print(shoutedGreeting);
-->
<!-- cat: void hello(String? name) { -->
<!-- String shoutedGreeting = "HELLO, " + (name?.uppercased else "WORLD"); -->
<!-- cat: 
    print(shoutedGreeting);
} -->
<!--
If `name` is null, `name?.uppercased` evaluates to `null`. Otherwise, the
`uppercased` attribute of `String` is evaluated. 
-->

If we need to squeeze a whole chain of `then`s/`else`s into a single 
expression, we can use the "poorman's switch" idiom:

    String sign = (int>1P then "enormous")
             else (int<0 then "negative")
             else (int>0 then "positive")
             else "zero";

Using `else`, we can finally simplify our example to something reasonable:

<!-- try-post:
    hello();
-->
    "Print a personalized greeting"
    void hello() {
        print("Hello, ``process.arguments.first else "World"``!");
    }

Yes, after all that, it's a one-liner ;-)


## Functions and values

The two most basic constructs found in almost every programming language 
are functions and variables. In Ceylon, "variables" are, by default, 
assignable exactly once. That is, they can't be assigned a new value after 
an initial value has been assigned. Therefore, we use the word _value_ to 
talk about "variables" collectively, and reserve the word _variable_ to 
mean a value which is explicitly defined to be reassignable.

    String bye = "Adios";        //a value
    variable Integer count = 0;  //a variable
    
    bye = "Adieu";  //compile error
    count = 1;     //allowed

Note that even a value which isn't a variable in this sense, may still be
"variable" in the sense that its value varies between different runs of
the program, or between contexts within a single execution of the program.

A value may even be recalculated every time it is evaluated.

<!-- try-pre:
    value firstName = "David";
    value lastName = "Hilbert";
-->
<!-- try-post:
    print(name);
-->
    String name { return firstName + " " + lastName; } 

If the values of `firstName` and `lastName` vary, then the value of 
`name` also varies between evaluations.

A function takes this idea one step further. The value of a function
depends not only upon the context in which it is evaluated, but also
upon the arguments to its parameters.

<!-- try-post:
    print(sqr(3.5));
-->
    Float sqr(Float x) { return x*x; }

In Ceylon, a value or function declaration can occur almost anywhere: 

- as a _toplevel_, belonging directly to a package, 
- as an _attribute_ or _method_ of a class, or 
- as a _block-local_ declaration inside a different value or function 
  body.

Indeed, as we'll see later, a value or function declaration may even 
occur _inside an expression_ in some cases.

Functions declarations look pretty similar to what you're probably already
used to from other C-like languages, with two exceptions. Ceylon has:

- defaulted parameters, and
- variadic parameters.  

## Defaulted parameters

A function parameter may specify a default value.

<!-- try-post:
    hello(); //Hello, World!
    hello("JBoss"); //Hello, JBoss!
-->
<!-- id: hello -->
    void hello(String name="World") {
        print("Hello, ``name``!");
    }

Then we don't need to specify an argument to the parameter when we call 
the function:

<!-- try:
    void hello(String name="World") {
        print("Hello, ``name``!");
    }
    hello(); //Hello, World!
    hello("JBoss"); //Hello, JBoss!
-->
<!-- cat-id: hello -->
<!-- cat: void m() { -->
    hello(); //Hello, World!
    hello("JBoss"); //Hello, JBoss!
<!-- cat: } -->

Defaulted parameters must be declared after all required parameters in the 
parameter list of a function.


## Variadic parameters

A variadic parameter of a function or class is declared using a postfix
asterisk, for example, `String*`. There may be only one variadic parameter 
for a function or class, and it must be the last parameter.

<!-- try: -->
    void helloEveryone(String* names) { 
        // ... 
    }

Inside the function body, the parameter `names` has type `[String*]`, a 
[sequence type](../sequences), which we'll learn about later. Thus, we
can iterate the parameter using a `for` loop to get at the individual 
arguments.

<!-- try-post:
    helloEveryone("world", "mars", "saturn");
-->
    void helloEveryone(String* names) {
        for (name in names) {
            hello(name);
        }
    }

A _nonempty_ variadic parameter is declared using a postfix plus sign,
for example, `String+`. In this case, the caller must supply at least
one argument.

<!-- try-post:
    helloEveryone("world", "mars", "saturn");
-->
    void helloEveryone(String+ names) {
        for (name in names) {
            hello(name);
        }
    }

To pass an argument to a variadic parameter we have three choices. We
could:

- provide a an explicit list of enumerated arguments,
- pass in iterable object producing the arguments, or
- specify a comprehension.

The first case is easy:

<!-- try: -->
    helloEveryone("world", "mars", "saturn");

For the second case, Ceylon requires us to use the 
[spread operator](../functions/#the_spread_operator):

<!-- try: -->
    String[] everyone = ["world", "mars", "saturn"];
    helloEveryone(*everyone);

We'll come back to the third case, [comprehensions](../comprehensions),
later in the tour.


## Fat arrows and forward declaration

Ceylon's expression syntax is much more powerful than Java's, and it's
therefore possible to express a lot more in a single compact expression.
It's therefore _extremely_ common to encounter functions and values which
simply evaluate and return an expression. So Ceylon lets us abbreviate
such function and value definitions using a "fat arrow", `=>`. For example:

<!-- try-pre:
    value firstName = "David";
    value lastName = "Hilbert";
-->
<!-- try-post:
    print(name);
-->
    String name => firstName + " " + lastName;

Or:

<!-- try-post:
    print(sqr(3.5));
-->
    Float sqr(Float x) => x*x;

Now's the time to get comfortable with this syntax, because you're going 
to be seeing quite a lot of it. Take careful note of the difference between 
a fat arrow:

<!-- try-pre:
    value firstName = "David";
    value lastName = "Hilbert";
-->
<!-- try-post:
    print(name);
-->
    String name => firstName + " " + lastName;

And an assignment:

<!-- try-pre:
    value firstName = "David";
    value lastName = "Hilbert";
-->
<!-- try-post:
    print(name);
-->
    String name = firstName + " " + lastName;

In the first example, the expression is recomputed every time `name` is
evaluated. In the second example, the expression is computed once and the 
result assigned to `name`.

We're even allowed to define a `void` function using a fat arrow. Earlier,
we could have written `hello()` like this:

<!-- id: hello -->
<!-- try-post:
    hello();
-->
    void hello() => print("Hello, World!");

In Java and C#, we're allowed to separate the declaration of a variable
from the initialization of its value. We've 
[already seen](#dealing_with_objects_that_arent_there) that this is also
allowed in Ceylon. So we can write:

<!-- try-pre:
    value firstName = "Walter";
    value lastName = "Kovacs";
-->
    String name;
    name = firstName + " " + lastName;
    print(name);

But Ceylon even lets us do this with fat arrows:

<!-- try-pre:
    value firstName = "Walter";
    value lastName = "Kovacs";
-->
    String name;
    name => firstName + " " + lastName;
    print(name);

And even functions: 

    Float sqr(Float x);
    sqr(Float x) => x*x;
    print(sqr(0.01));

    void hello();
    hello() => print("Hello, World!");
    hello();

The compiler makes sure we don't evaluate a value or invoke a function
before assigning it a value or specifying its implementation, as we'll see 
[later](../initialization/#definite_assignment_and_definite_initialization).
(Because if we did, it would result in a `NullPointerException`, which
Ceylon doesn't have!)

## Numbers

Unfortunately, not every program is as simple and elegant as "hello world".
In business or scientific computing, we often encounter programs that do 
fiendishly complicated stuff with numbers. Ceylon doesn't have any primitive 
types, so numeric values are usually represented by the classes 
[`Integer`](#{site.urls.apidoc_1_1}/Integer.type.html)
and [`Float`](#{site.urls.apidoc_1_1}/Float.type.html),
which we'll come back to [later in the tour](../language-module/#numeric_types).

`Float` literals are written with a decimal point, and `Integer` literals 
without:

    Integer one = 1;
    Float zero = 0.0;

Even though they're classes, you can use all the usual numeric literals and
operators with them. For example, the following function efficiently determines 
if an `Integer` represents a prime number:

<!-- try-post:
    print(prime(17));
-->
    "Determine if `n` is a prime number."
    throws (`class AssertionException`, "if `n<2`")
    Boolean prime(Integer n) {
        "`n` must be greater than 1"
        assert (n>1);
        if (n<=3) {
            return true;
        }
        else if (n%2==0 || n%3==0) {
            return false;
        }
        else if (n<25) {
            return true;
        }
        else {
            for (b in 1..((n.float^0.5+1)/6).integer) {
                if (n%(6*b-1)==0 || n%(6*b+1)==0) {
                    return false;
                }
            }
            else {
                return true;
            }
        }
    }

Try it, by running the following function:

<!-- try-pre:
    "Determine if `n` is a prime number."
    throws (`class AssertionException`, "if `n<2`")
    Boolean prime(Integer n) {
        "`n` must be greater than 1"
        assert (n>1);
        if (n<=3) {
            return true;
        }
        else if (n%2==0 || n%3==0) {
            return false;
        }
        else if (n<25) {
            return true;
        }
        else {
            for (b in 1..((n.float^0.5+1)/6).integer) {
                if (n%(6*b-1)==0 || n%(6*b+1)==0) {
                    return false;
                }
            }
            else {
                return true;
            }
        }
    }
-->
<!-- try-post:
    findPrimes();
-->
    "Print a list of all two-digit prime numbers."
    void findPrimes()
        => printAll { for (i in 2..99) if (prime(i)) i };

Heh, this was just a little teaser to keep you interested. We'll explain 
the syntax we're using here a bit [later in the tour](../comprehensions).


## There's more...

Ceylon is an object-oriented language, so an awful lot of the code we write 
in Ceylon is contained in a _class_. [Let's learn about classes](../classes)
right now, before we come back to [more of the basic stuff](../attributes-control-structures).

