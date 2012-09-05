---
layout: tour
title: Tour of Ceylon&#58; Sequenced Parameters and Named Arguments
tab: documentation
unique_id: docspage
author: Gavin King
---

# #{page.title}

This is the eleventh leg in the Tour of Ceylon. In the 
[previous leg](../functions) we learnt about functions. This part builds 
on that by covering Ceylon's support for calling functions using *named 
arguments*. But first, we need to see what a *sequenced parameter* is.


## Sequenced parameters

A sequenced parameter of a method or class is declared using an ellipsis. 
There may be only one sequenced parameter for a method or class, and it 
must be the last parameter.

    void printAll(String... strings) { 
        // ... 
    }

Inside the method body, the parameter `strings` has type `Iterable<String>`.

<!-- try-post:

    printAll("aap", "noot", "mies");
-->
    void printAll(String... strings) {
        for (string in strings) {
            process.writeLine(string);
        }
    }

A slightly more sophisticated example is the `coalesce()` method we saw 
[earlier](../attributes-control-structures#then_we_can_abstract_the...). 
`coalesce()` accepts a sequence of `X?` and eliminates nulls, returning 
`X[]`, for any type `X`. Its signature is:

<!-- try: -->
<!-- check:none:pedagogical -->
    shared Value[] coalesce<Value>(Value?... sequence) { 
        // ... 
    }

To pass an argument to a sequenced parameter we have three choices. We
could:

- provide a an explicit list or arguments,
- pass in iterable object producing the arguments, or
- specify a comprehension.

The first case is easy:

<!-- try: -->
    print("hello", "world");

For the second case, Ceylon requires us to write an elipse:

<!-- try: -->
    value words = { "hello", "world" };
    print(words...);

The third, and easily most interesting case allows us to transform,
filter, and combine iterable streams of values:

<!-- try: -->
    value words = { "Hello", "World" };
    print(for (w in words) w.lowercased);

We'll come back to comprehensions later.

Sequenced parameters turn out to be especially interesting when used in 
named argument lists for defining user interfaces or structured data.


## Named arguments

Consider the following method:



<!-- try: -->
<!-- check:none:Requires IO -->
<!-- id:printf -->
    void printf(Writer to, String format, Object... values) { 
        // ... 
    }

We've seen lots of examples of invoking a method or instantiating a class 
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
           user.name, 
           order.total, 
           order.confimationNumber);
<!-- cat: } -->

This works fine, however Ceylon provides an alternative method 
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
        user.name, 
        order.total, 
        order.confimationNumber
    };
<!-- cat: } -->

This invocation protocol is called a *named argument list*. We can recognize a 
named argument list by the use of braces as delimiters instead of parentheses. 
Notice that arguments are separated by semicolons, except for arguments to the 
sequenced parameter, which are separated by commas. We explicitly specify the 
name of each parameter, except for the sequenced parameter, whose arguments 
always appear at the end of the named parameter list. Note that it's also 
acceptable to call this method like this, passing a sequence to the parameter
`values`:

<!-- try: -->
<!-- check:none:Requires IO -->
    printf {
        to = writer;
        format = "Thanks, %s. You have been charged %.2f. 
                  Your confirmation number is %d.";
        values = { 
            user.name, 
            order.total, 
            order.confimationNumber 
        };
    };

We usually format named argument invocations across multiple lines.


## Declarative object instantiation syntax

Named arguments are very commonly used for building graphs of objects. 
Therefore, Ceylon provides a special abbreviated syntax that simplifies the 
declaration of an attribute getter, named parameter, or method that builds 
an object by specifying named arguments to the class initializer. 
You've actually [already encountered](../modules#module_descriptors) this 
abbreviated syntax, though you probably didn't realize it at the time.

We're allowed to abbreviate an attribute definition of the following form:


<!-- try: -->
<!-- cat-id: Store -->
<!-- cat: class M(User user, Order order) { -->
    Payment payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };
<!-- cat: } -->

or a named argument specification of this form:

<!-- try: -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { 
    Payment payment; -->
    payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };
<!-- cat: } -->

to the following more declarative (and less redundant) style:

<!-- try: -->
<!-- cat-id: Store -->
<!-- cat: void m(User user, Order order) { -->
    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }
<!-- cat: } -->

We're even allowed to write a method of the following form:

<!-- try: -->
<!-- cat-id: Store -->
<!-- cat: void m(User user) { -->
    Payment createPayment(Order order) {
        return Payment {
            method = user.paymentMethod;
            currency = order.currency;
            amount = order.total;
        };
    }
<!-- cat: } -->

using the following abbreviated syntax:

<!-- try: -->
<!-- cat-id: Store -->
<!-- cat: void m(User user) { -->
    Payment createPayment(Order order) {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }
<!-- cat: } -->

Perhaps you're worried that this looks like a method that assigns the values 
of three attributes of the declaring class, rather than a shortcut syntax for 
a named argument instantiation of the `Payment` class. And that's a very 
fair point. To a Java developer, that is what it looks like. There's two 
things that should alert you to what's really going on. The above method:

* has no return statement, but it's not declared void, and
* contains a list of `=` specification statements instead of `:=` assignment 
  expressions.

Once you're used to Ceylon's more flexible syntax, these differences will 
usually stand out immediately.


## More about named arguments

The following classes define a data structure for building tables:

<!-- try: -->
<!-- check:none:pedagogical -->
    class Table(String title, Integer rows, Border border, Column... columns) {}
    class Column(String heading, Integer width, String content(Integer row)) {}
    class Border(Integer padding, Integer weight) {}

Of course, we could build a `Table` using positional argument lists and 
anonymous functions:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, Column... columns) {}
    class Column(String heading, Integer width, String content(Integer row)) {}
    class Border(Integer padding, Integer weight) {}

-->
<!-- check:none:pedagogical -->
    Table table = Table("Squares", 5, Border(2,1), 
            Column("x",10, (Integer row) row.string), 
            Column("x**2",12, (Integer row) (row**2).string));

However, it's far more common to use named arguments to build a complex 
graph of objects. In this section we're going to meet some new features of 
named argument lists, that make it especially convenient to build object 
graphs.

First, note that the syntax we've already seen for specifying a named argument 
value looks exactly like the syntax for refining a `formal` attribute. If you 
think about it, taking into account that a method parameter may accept 
references to other methods, the whole problem of specifying values for named 
parameters starts to look a lot like the problem of refining abstract members. 
Therefore, Ceylon will let us reuse much of the member declaration syntax 
inside a named argument list.

It's legal to include the following constructs in a named argument list:

* method declarations — specify the argument of a parameter that accepts a 
  function,
* `object` (anonymous class) declarations — are most useful for specifying 
  the value of a parameter whose type is an interface or abstract class, and
* getter declarations — lets us compute the value of an argument inline.

This helps explain why named argument lists are delimited by braces: the 
fully general syntax for a named argument list is very, very close to the 
syntax for a class, method, or attribute body. Notice, again, how flexibility 
derives from language regularity.

So we could rewrite the code that builds a `Table` as follows:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, Column... columns) {}
    class Column(String heading, Integer width, String content(Integer row)) {}
    class Border(Integer padding, Integer weight) {}

-->
<!-- check:none:pedagogical -->
    Table table = Table {
        title="Squares";
        rows=5;
        border = Border {
            padding=2;
            weight=1;
        };
        Column {
            heading="x";
            width=10;
            function content(Integer row) {
                return row.string;
            }
        },
        Column {
            heading="x**2";
            width=12;
            function content(Integer row) {
                return (row**2).string;
            }
        }
    };

Notice that we've specified the value of the parameter named `content` using the 
usual syntax for declaring a method.

Even better, our example can be further abbreviated like this:

<!-- try-pre:
    class Table(String title, Integer rows, Border border, Column... columns) {}
    class Column(String heading, Integer width, String content(Integer row)) {}
    class Border(Integer padding, Integer weight) {}

-->
<!-- check:none:pedagogical -->
    Table table {
        title="Squares";
        rows=5;
        Border border {
            padding=2;
            weight=1;
        }
        Column {
            heading="x";
            width=10;
            function content(Integer row) {
                return row.string;
            }
        },
        Column {
            heading="x**2";
            width=10;
            function content(Integer row) {
                return (row**2).string;
            }
        }
    }

Notice how we've transformed our code from a form which emphasized invocation 
into a form that emphasizes declaration of a hierarchical structure. 
Semantically, the two forms are equivalent. But in terms of readability, 
they are quite different.

We could put the above totally declarative code in a file by itself and it 
would look like some kind of "mini-language" for defining tables. In fact, 
it's executable Ceylon code that may be validated for syntactic correctness by 
the Ceylon compiler and then compiled to Java bytecode or JavaScript. Even 
better, the Ceylon IDE will provide authoring support for our mini-language. 
In complete contrast to the DSL support in some dynamic languages, any Ceylon 
DSL is completely typesafe! You can think of the definition of the `Table`, 
`Column` and `Border` classes as defining the "schema" or "grammar" of the 
mini-language. (In fact, they are really defining a syntax tree for the 
mini-language.)

Now let's see an example of a named argument list with an inline getter 
declaration:

<!-- try: -->
<!-- check:none:Needs more Store -->
    shared class Payment(PaymentMethod method, Currency currency, Float amount) {}
    
    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        value amount {
            variable Float total := 0.0;
            for (item in order.items) {
                total += item.quantity * item.product.unitPrice;
            }
            return total;
        }
    }

Finally, here's an example of a named argument list with an inline `object` 
declaration:

<!-- try: -->
<!-- check:parse:pedagogical -->
    shared interface Observable {
        shared void addObserver(Observer<Bottom> observer) { 
            // ... 
        }
    }
    
    shared interface Observer<in Event> {
        shared formal void on(Event event);
    }
    
    observable.addObserver {
        object observer satisfies Observer<UpdateEvent> {
            shared actual void on(UpdateEvent e) {
                print("Update:" + e.string);
            }
        }
    };

(Note that `Observer<T>` is assignable to `Observer<Bottom>` for any type `T`, 
since `Observer<T>` is contravariant in its type parameter `T`. If this 
doesn't make sense, please read the section on [generics](../generics) again.)

Of course, as we saw in the leg on [functions](../functions), a better way to 
solve this problem might be to eliminate the `Observer` interface and pass a 
method directly:

<!-- try: -->
<!-- check:parse:pedagogical -->
    shared interface Observable {
        shared void addObserver<Event>(void on(Event event)) { ... }
    }
    
    observable.addObserver {
        void on(UpdateEvent e) {
            print("Update:" + e.string);
        }
    };


## Defining user interfaces

One of the first modules we're going to create for Ceylon will be a library 
for writing HTML templates in Ceylon. A fragment of static HTML would look 
something like this:

<!-- try: -->
<!-- check:parse:Requires ceylon.html -->
    Html {
        Head head {
            title = "Hello World";
            cssStyleSheet = 'hello.css';
        }
        Body body {
            Div {
                cssClass = "greeting";
                "Hello World"
            },
            Div {
                cssClass = "footer";
                "Powered by Ceylon"
            }
        }
    }

A complete HTML template might look like this:

<!-- try: -->
<!-- check:parse:Requires ceylon.html -->
    import ceylon.html { ... }
     
    doc "A web page that displays a greeting"
    page '/hello.html'
    Html hello(Request request) {
         
        Head head {
            title = "Hello World";
            cssStyleSheet = 'hello.css';
        }
         
        Body body {
            Div {
                cssClass = "greeting";
                Hello( request.parameters["name"] ).greeting
            },
            Div {
                cssClass = "footer";
                "Powered by Ceylon"
            }
        }
     
    };

### implementation note <!-- m3 -->

This library does not yet exist! Why not [get involved](/community) in developing 
the Ceylon platform?

## There's more...

There's plenty of potential applications of this syntax aside from user 
interface definition. For example, Ceylon lets us use a named argument list to 
specify the arguments of a program element annotation. But we'll have to come 
back to the subject of [annotations](../annotations) in a future installment. 

The [next section](../comprehensions) introduces yet another way to specify an
argument to a function: _comprehensions_.
