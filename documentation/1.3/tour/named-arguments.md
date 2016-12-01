---
layout: tour13
title: Named arguments
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the twelfth leg in the Tour of Ceylon. In the 
[previous leg](../functions) we learnt about functions. This part builds 
on that by covering Ceylon's support for calling functions using *named 
arguments*.

## Named arguments

Consider the following function:

<!-- try: -->
<!-- check:none:Requires IO -->
<!-- id:printf -->
    void printf(Writer to, String format, {Object*} values) { 
        // ... 
    }

We've seen lots of examples of invoking a function or instantiating a class 
using a familiar C-style syntax where arguments are delimited by parentheses 
and separated by commas. Arguments are matched to parameters by their 
position in the list. Let's see one more example, just in case:

<!-- implicit-id:Store:
abstract class PaymentMethod() of cash | creditCard | debitCard {}
object cash extends PaymentMethod() {}
object creditCard extends PaymentMethod() {}
object debitCard extends PaymentMethod() {}

abstract class Currency() of usd | gbp | eur {}
object usd extends Currency() {}
object gbp extends Currency() {}
object eur extends Currency() {}

class User(String name) {
    shared String name = name;
    shared PaymentMethod paymentMethod = cash;
}

class Order(Integer total, Integer confirmationNumber) {
    shared Integer total = total;
    shared Integer confirmationNumber = confirmationNumber;
    shared Currency currency = usd;
}
    
class Payment(PaymentMethod method, Currency currency, Integer amount) {}
-->

<!-- try: -->
<!-- check:none:Requires IO -->
<!-- cat-id:printf -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { -->
    printf(writer, 
           "Thanks, %s. You have been charged %.2f. 
            Your confirmation number is %d.",
           { user.name, order.total, order.confimationNumber });
<!-- cat: } -->

This works fine. However, Ceylon provides an alternative function 
invocation protocol that is usually easier to read when there are more than 
one or two arguments:

<!-- try: -->
<!-- check:none:Requires IO -->
<!-- cat-id:printf -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { -->
    printf {
        to = writer;
        format = "Thanks, %s. You have been charged %.2f. 
                  Your confirmation number is %d.";
        values = { user.name, order.total, order.confimationNumber };
    };
<!-- cat: } -->

This invocation protocol is called a *named argument list*. We can recognize a 
named argument list by the use of braces as delimiters instead of parentheses. 
Notice that arguments are separated by semicolons. We explicitly specify the 
name of each parameter. 

We usually format named argument invocations across multiple lines.

## Iterable arguments

Since the parameter `values` is of type `Iterable`, we're allowed to abbreviate
this, leaving out the parameter name and the braces surrounding the iterable
construction expression:

<!-- try: -->
<!-- check:none:Requires IO -->
<!-- cat-id:printf -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { -->
    printf {
        to = writer;
        format = "Thanks, %s. You have been charged %.2f. 
                  Your confirmation number is %d.";
        user.name, order.total, order.confimationNumber
    };
<!-- cat: } -->

Later we'll see that we can even use a [comprehension][] or 
[spread operator][] here. 

Back when we first met the concept of a [stream][], we saw the
curly-brace syntax for instantiating a lazy stream of values. It's
no accident that named argument lists and stream instantiation use
a similar syntax; a stream instantiation expression is really just
a named argument list where the class is being instantiated is 
filled in implicitly by the compiler!

Thus, we have a pretty uniform syntax for instantiating container 
types in Ceylon:

<!-- try: -->
    import ceylon.collection { ArrayList, HashSet }

    value stream = { "hello", "world" }
    value list = ArrayList { "hello", "world" };
    value set = HashSet { "hello", "world" };

Even though there are no argument names in these expression, they're 
all just named argument lists, each with one "iterable" argument. 
Actually, we can even leave out the parameter names of other arguments!

[comprehension]: ../comprehensions
[spread operator]: ../functions/#the_spread_operator
[stream]: ../sequences/#streams_iterables

## Leaving out the parameter names

Contrary to the description of this feature as a "named argument list", 
we're actually allowed to leave out the names of the parameters if we
write the arguments down in the right order:
 
<!-- try: -->
<!-- check:none:Requires IO -->
<!-- cat-id:printf -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { -->
    printf {
        writer;
        "Thanks, %s. You have been charged %.2f. 
         Your confirmation number is %d.";
        user.name, order.total, order.confimationNumber
    };
<!-- cat: } -->

Yes, there's a great reason for this, as we're about to see!

### Gotcha!

There's a slightly-unfortunate near-ambiguity in the grammar
of named argument lists. This invocation:

    printAll { "hello" };

Is quite different to this
one, with a terminating semicolon:

    printAll { "hello"; };

(Try them and see.)

According to the rules above, the first example means this:

    printAll { values = { "hello" }; };

Whereas the second example is an abbreviation for:

    printAll { values = "hello"; };

Mind the punctuation! 

## Named arguments to variadic parameters

To pass a named argument to a variadic parameter, just wrap the arguments in
a sequence:

    Float product(Float+ floats) {
        variable value product = floats.first;
        for (float in floats.rest) {
            product *= float;
        }
        return product;
    }
    
    print(product(2.0, 3.0, 4.0));                //positional args
    print(product { floats = [2.0, 3.0, 4.0]; }); //same thing, with a named arg

## Declarative object instantiation syntax

The following classes define a data structure for defining tables:

<!-- try: -->
<!-- check:none:pedagogical -->
    class Table(String title, Integer rows, Border border, 
                    {Column*} columns) {}
    
    class Column(String heading, Integer width, 
                    String content(Integer row)) {}
    
    class Border(Integer padding, Integer weight) {}

Of course, we could build a `Table` using positional argument lists and 
anonymous functions:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, 
                    {Column*} columns) {}
    
    class Column(String heading, Integer width, 
                    String content(Integer row)) {}
    
    class Border(Integer padding, Integer weight) {}
    
-->
<!-- check:none:pedagogical -->
    Table table = Table("Squares", 5, Border(2,1), 
            { Column("x",10, (row) => row.string), 
              Column("x^2",12, (row) => (row^2).string) });

However, it's far more common to use named arguments to build a complex 
graph of objects. In this section we're going to meet some new features of 
named argument lists, that make it especially convenient to build object 
graphs.

First, note that the syntax we've already seen for specifying a named argument 
value looks exactly like the syntax for refining a `formal` attribute. If you 
think about it, taking into account that a function parameter may accept 
references to other functions, the whole problem of specifying values for named 
parameters starts to look a lot like the problem of refining abstract members. 
Therefore, Ceylon will let us reuse much of the member declaration syntax 
inside a named argument list.

It's legal to include the following constructs in a named argument list:

* function declarations—specify the argument of a parameter that accepts a 
  function,
* `object` (anonymous class) declarations—are most useful for specifying 
  the value of a parameter whose type is an interface or abstract class, and
* getter declarations—lets us compute the value of an argument inline.

This helps explain why named argument lists are delimited by braces: the 
fully general syntax for a named argument list is very, very close to the 
syntax for a class, function, or attribute body. Notice, again, how flexibility 
derives from language regularity.

So we could rewrite the code that builds a `Table` as follows:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, 
                    {Column*} columns) {}
    
    class Column(String heading, Integer width, 
                    String content(Integer row)) {}
    
    class Border(Integer padding, Integer weight) {}

-->
<!-- check:none:pedagogical -->
    Table table = Table {
        title = "Squares";
        rows = 5;
        border = Border {
            padding = 2;
            weight = 1;
        };
        Column {
            heading = "x";
            width = 10;
            function content(Integer row) 
                    => row.string;
        },
        Column {
            heading = "x^2";
            width = 12;
            function content(Integer row) 
                    => (row^2).string;
        }
    };

Notice that we've specified the value of the parameter named `content` using the 
usual syntax for declaring a function.

Even better, using the shortcuts we've already seen, our example can be further 
abbreviated like this:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, 
                    {Column*} columns) {}
    
    class Column(String heading, Integer width, 
                    String content(Integer row)) {}
    
    class Border(Integer padding, Integer weight) {}

-->
<!-- check:none:pedagogical -->
    Table table = Table {
        title = "Squares";
        rows = 5;
        Border {
            padding = 2;
            weight = 1;
        };
        Column {
            heading = "x";
            width = 10;
            content(Integer row) 
                    => row.string;
        },
        Column {
            heading = "x^2";
            width = 10;
            content(Integer row) 
                    => (row^2).string;
        }
    };

Notice how we've transformed our code from a form which emphasized invocation 
into a form that emphasizes declaration of a hierarchical structure. 
Semantically, the two forms are equivalent. But in terms of readability, 
they're quite different.

We could put the above totally declarative code in a file by itself and it 
would look like some kind of "minilanguage" for defining tables. In fact, 
it's executable Ceylon code that may be validated for syntactic correctness by 
the Ceylon compiler and then compiled to Java bytecode or JavaScript. Even 
better, the Ceylon IDE for Eclipse will provide authoring support for our minilanguage. 
In complete contrast to the DSL support in some dynamic languages, any Ceylon 
DSL is completely typesafe! You can think of the definition of the `Table`, 
`Column` and `Border` classes as defining the "schema" or "grammar" of the 
minilanguage. (In fact, they are really defining a syntax tree for the 
minilanguage.)

Now let's see an example of a named argument list with an inline getter 
declaration:

<!-- try: -->
<!-- check:none:Needs more Store -->
    shared class Payment(PaymentMethod method, 
                         Currency currency, 
                         Float amount) {}
    
    Payment payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        value amount {
            variable Float total = 0.0;
            for (item in order.items) {
                total += item.quantity * item.product.unitPrice;
            }
            return total;
        }
    };

Finally, here's an example of a named argument list with an inline `object` 
declaration:

<!-- try: -->
<!-- check:parse:pedagogical -->
    shared interface Observable {
        shared void addObserver(Observer<Nothing> observer) { 
            // ... 
        }
    }
    
    shared interface Observer<in Event> {
        shared formal void on(Event event);
    }
    
    observable.addObserver {
        object observer 
                satisfies Observer<UpdateEvent> {
            on(UpdateEvent e)
                    => print("Update:" + e.string);
        }
    };

(Note that `Observer<T>` is assignable to `Observer<Nothing>` for any type 
`T`, since `Observer<T>` is contravariant in its type parameter `T`. If this 
doesn't make sense, please read the section on [generics](../generics) again.)

Of course, as we saw in the leg on [functions](../functions), a better way to 
solve this problem might be to eliminate the `Observer` interface and pass a 
function directly:

<!-- try: -->
<!-- check:parse:pedagogical -->
    shared interface Observable {
        shared void addObserver<Event>(void on(Event event)) { ... }
    }
    
    observable.addObserver {
        void on(UpdateEvent e)
                => print("Update:" + e.string);
    };


## Defining user interfaces

The platform module `ceylon.html` is a library for writing HTML templates in 
Ceylon. A fragment of static HTML looks something like this:

<!-- try: -->
<!-- check:parse:Requires ceylon.html -->
    Html {
        doctype = html5;
        Head {
            title = "Welcome Message";
            Link { 
                rel = stylesheet; 
                type = css; 
                href = "/styles/screen.css"; 
                id = "stylesheet"; 
            }
        };
        Body {
            H2 ( "Welcome to Ceylon ``language.version``!" ),
            P ( "Now get your code on :)" )
        };
    }

Even though this looks like some kind of templating language, it's just an 
ordinary expression.


## There's more...

There's plenty of potential applications of this syntax aside from user 
interface definition. For example, Ceylon lets us use a named argument list to 
specify the arguments of a program element annotation. But we'll have to come 
back to the subject of [annotations](../annotations) in a future installment. 

The [next section](../comprehensions) introduces yet another way to specify an
argument to a function: _comprehensions_.
